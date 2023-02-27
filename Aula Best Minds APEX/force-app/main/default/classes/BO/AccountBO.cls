public class AccountBO{
    
    private static AccountBO instance = new AccountBO();

    public static AccountBO getInstance(){
        return instance;
    }

    public void copiarCEP(List<Account> contas, Map<Id, Account> mapOldContas){
        List<Account> contasProcessar = new List<Account>();
        for (Account conta : contas){
            Boolean diferenteShippingBillingPostalCode = conta.BillingPostalCode != conta.ShippingPostalCode;
            Boolean regrasUpdate = conta.BillingPostalCode == null || diferenteShippingBillingPostalCode;
            if (conta.Match_Billing_Adress__c && regrasUpdate){
                contasProcessar.add(conta);
            }
        }
        if (!contasProcessar.isEmpty()){
            for (Account conta : contasProcessar){
                conta.BillingPostalCode = conta.ShippingPostalCode;
            }
        }
    }

    public void criarRegistro(List<Account> acc){

        List<Fichario__c> newFichario = new List<Fichario__c>();

        for (Account conta : acc){

            Fichario__c f = new Fichario__c();

            f.Account__c = conta.Id;
            f.Name = 'Fichario Teste';

            newFichario.add(f);

        }
        Database.insert (newFichario);
    }

    public void deletarFichario(List<Account> acc){

        set<id> accListid = new set<id>();

        for (Account conta : acc){
            accListid.add(conta.Id);
        }

        List<Fichario__c> ficharioList = ficharioSelector.getFicharioIdList(accListid);


        Database.delete (ficharioList);
    }

    public void criaCaso(List<Account> acc){

        List<Case> cList = new List<Case>();

        for (Account conta : acc){
            Case c = new case();
            c.Status = 'New';
            c.Origin = 'Other';
            c.Description = 'A conta Id: ' + conta.id + ' Foi Deletada';
            c.Subject = 'Conta Deletada';
            cList.add(c);

        }
        database.insert (cList);
    }

    public void criaOpp(List<Account> acc){

        List<Opportunity> newOpp = new List<Opportunity>();

        for (Account conta : acc){

            if (conta.Type == 'Prospect'){
                Opportunity opp = new Opportunity();

                opp.AccountId = conta.Id;
                opp.Name = 'AccountOppBO Teste';
                opp.CloseDate = System.today();
                opp.StageName = 'Prospecting';

                newOpp.add(opp);
            }
        }
        Database.insert (newOpp);
    }

    public void attStatusOpp(List<Account> acc){

        set<id> accListid = new set<id>();

        for (Account conta : acc){
            if (conta.Type != 'Prospect'){
                accListid.add(conta.Id);
            }
        }
        List<Opportunity> listOpp = OpportunitySelector.getOppByAccountIdList(accListid);

        if (listOpp.size() > 0){
            for (Opportunity o : listOpp){
                o.StageName = 'Closed Won';
            }
        }
        Database.update (listOpp);
    }

    /* public void associaSocioFaturamento(List<Account> acc){

        set<id> setIdParent = new set<id>();

        List<Account> accList = new List<Account>();

        for (Account conta : acc){
            if (conta.Faturamento__c != null && conta.ParentId != null && conta.Faturamento__c > 1000000)

                setIdParent.add(conta.ParentId);
            }
            
            if(!setIdParent.isEmpty()){
                List<Account> atualizarAssociados = new List<Account>();
                List<Account> parentAccounts = new List<Account>();
                parentAccounts = AccountDAO.getAccountIdList(setIdParent);
                    if(!parentAccounts.isEmpty()){
                        for(Account parent : parentAccounts){
                            Account aux = new Account();
                            for(Account child : parent.ChildAccounts){
                                if(child.Faturamento__c > aux.Faturamento__c){
                                    parent.socioFaturamento__c = child.Id;
                                }
                            }
                            parent.SocioFaturamento__c = aux.Id;
                            if(parent.SocioFaturamento__c != null){
                                atualizarAssociados.add(parent);
                            }   
                        }
                        if(!atualizarAssociados.isEmpty()){

                            Database.update(atualizarAssociados);
                        }
                    }

            } 
    } */

    // 

    /* public void somaQntdContasFilial(List<Account> acc){

        Id rtFilial = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Filial').getRecordTypeId();
        Id rtMatriz = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Matriz').getRecordTypeId();

        set<id> accMatrizList = new set<id>();

        Map<Id,Account> matrizMap = new Map<Id,Account>();

        List<Account> lstAcc = new List<Account>();

        for(Account conta : acc ){
            if(conta.RecordTypeId == rtFilial && conta.ParentId != null && conta.Parent.RecordTypeId == rtMatriz){
                conta.Parent.QuantidadeContas__c = 0;
                matrizMap.put(conta.ParentId, conta.Parent);
                accMatrizList.add(conta.ParentId);
            }   
        }

        List<Account> filiaisAcc = AccountDAO.getFiliaisByMatrizId(accMatrizList);

        Map<String,String> billingStateMap = new Map<String,String>();

        Map<Id,Account> filiaisMap = new Map<Id, Account>();
        

        for(Account a : filiaisMap.values()){
            matrizMap.get(a.ParentId).QuantidadeContas__c += 1;
            if(billingStateMap.containsKey(a.BillingState)){
                billingStateMap.get(a.BillingState).value += a.id + ';';
            }else{
                billingStateMap.put(a.BillingState, a.Id);
            } 
        } 
           
        List<Account> filiasUpdate = new List<Account>();

        for(String s : billingStateMap.values()){
            List<String> slist = s.split(';');
            for(String ss : slist){
                Account a = new Account();
                a.id = ss;
                a.QuantidadeContas__c = slist.size();
                filiasUpdate.add(a);
            }

        }

        Database.update(matrizMap);
        Database.update(filiasUpdate);
    }  */
    
    /* public static void atualizarNomeConta(List<Account> accountList) {
        System.debug('# Método AccountBO >> atualizarNomeConta >>> accountList >>> ' + accountList);
        // Carrego Set de idAccountSet        Set<Id> idAccountSet = new Set<Id>();
        for (Account conta : accountList) {
            idAccountSet.add(conta.Id);
        }
        //Chamar método futuro        atualizarNomeContaFuture(idAccountSet, 'EMPRESA - ');
    }
    @future    public static void atualizarNomeContaFuture(Set<Id> idAccountSet, String nomePadrao) {
        System.debug('# Método AccountBO >> atualizarNomeContaFuture >>> idAccountSet >>> ' + idAccountSet);
        System.debug('# Método AccountBO >> atualizarNomeContaFuture >>> nomePadrao >>> ' + nomePadrao);
        // Busca das Contas para atualizar o nome        List<Account> accountList = new List<Account>();
        accountList = [SELECT Id, Name FROM Account WHERE Id IN: idAccountSet];
        System.debug('# Método AccountBO >> atualizarNomeContaFuture >>> accountList >>> ' + accountList);
        // Outra forma de codificar a busca        //List<Account> accountList = [SELECT Id, Name FROM Account WHERE Id IN: idAccountSet];        List<Account> accountUpdateList = new List<Account>();
        for (Account conta : accountList) {
            conta.Name = nomePadrao + conta.Name;
            accountUpdateList.add(conta);
        }
        System.debug('# Método AccountBO >> atualizarNomeContaFuture >>> accountUpdateList >>> ' + accountUpdateList);
        update accountUpdateList;
    }
    @future    public static void integrarConta(String jsonConta) {
        System.debug('# Método AccountBO >> integrarConta');
        List<Account> accountList = (List<Account>) JSON.deserialize(jsonConta, List<Account>.class);
        List<Account> accountUpdateList = new List<Account>();
        for (Account conta : accountList) {
            conta.IntegrarConta__c = true;
            accountUpdateList.add(conta);
        }
        System.debug('# Método AccountBO >> integrarConta >>> accountUpdateList >>> ' + accountUpdateList);
        update accountUpdateList;
    }
    public static void marcarContaIntegracao(List<Account> contaList) {
        System.debug('# Método AccountBO >> marcarContaIntegracao >>> contaList >>> ' + contaList);
        String jsonConta = JSON.serialize(contaList);
        System.debug('# Método AccountBO >> integrarConta >>> jsonConta >>> ' + jsonConta);
        integrarConta(jsonConta);
    }    */

    public static void atualizaContaEndereco(List<Account> acc){

         //### HISTORIA #####
    /* Crie uma Batch para preencher o endereço dos contatos de contas, com oendereço
     das contas(Fazer com que o endereço dos contatos sejao mesmo que os da contas que estão associados), porém
     essas contas a serem atualizadas devem ter no mínimo 2 contatos associados.
     */
        //# Adress Conta : BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,
        //# Adress Contato MailingCity, MailingCountry, MailingPostalCode, MailingState, MailingStreet
       
        List<Contact> attListContato = new List<Contact>();

      
        for(Account conta : acc){
            if(conta.Contacts.size() >=2){
               
                for(Contact c : conta.Contacts){
                    c.MailingCity = conta.BillingCity;
                    c.MailingCountry = conta.BillingCountry;
                    c.MailingPostalCode = conta.BillingPostalCode;
                    c.MailingState = conta.BillingState;
                    c.MailingStreet = conta.BillingStreet;
                    attListContato.add(c);
                }
            }
        }
        update attListContato;
    }  

    public static void calculoClassificacao(List<Account> acc){
     /*    #####HISTORIA#####

        Crie uma classe que receba uma lista de contas (Account) e calcule 
        a sua classificação baseado no campo faturamento anual (AnnualRevenue):
        - 0 à 5000 (Prata)
        - 5001 à 500000 (Ouro)
        - + de 500000 (Diamante)
        - Nulo não tem classificação */
        if(acc.size() >0){
            for(Account a : acc){
                if(a.AnnualRevenue != null){
                    if(a.AnnualRevenue >0 && a.AnnualRevenue <= 5000){
                        a.ClassificaoCliente__c = 'Prata';
                    }
                    else if(a.AnnualRevenue >5001 && a.AnnualRevenue <= 500000){
                        a.ClassificaoCliente__c = 'Ouro';
                    }
                    else if(a.AnnualRevenue >500000){
                        a.ClassificaoCliente__c = 'Diamante';
                    }
                }
            } 
        }
        Database.update(acc);
    }
}
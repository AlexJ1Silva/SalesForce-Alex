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

}
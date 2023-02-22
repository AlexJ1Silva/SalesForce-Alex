public with sharing class OpportunityBO{
    private static OpportunityBO instance = new OpportunityBO();
    public static OpportunityBO getInstance(){
        return instance;
    }

    public void creatContacOpportunityContactRole(List<Opportunity> opptList){

        set<id> idAccountSet = new set<id>();

        for (Opportunity opp : opptList){
            if (opp.AccountId != null){
                idAccountSet.add(opp.AccountId);
            }
        }

        List<Account> accs = AccountDAO.getAccountContactsById(idAccountSet);

        map<Id, List<Contact>> accountContactMap = new map<id, List<Contact>>();

        for (Account acc : accs){
            accountContactMap.put(acc.id, acc.Contacts);
        }

        //system.debug('#########>>>> accountContactMap'+ accountContactMap);

        List<OpportunityContactRole> oppOcr = new List<OpportunityContactRole>();


        for (Opportunity opp : opptList){
            List<Contact> cnt = accountContactMap.get(opp.AccountId);
            if (cnt != null){
                for (Contact c : cnt){
                    OpportunityContactRole oppCRole = new OpportunityContactRole();
                    oppCRole.ContactId = c.Id;
                    oppCRole.OpportunityId = opp.Id;
                    oppOcr.add(oppCRole);
                }
            }
        }

        OcrAccTO to = new OcrAccTO();
        to.oppRole = oppOcr;

        String jsonOcr = JSON.serialize(to);
        insereContactOppContactRole(jsonOcr);
    }

    public void attUltimaOppConta(List<Opportunity> opptList){
        set<id> idAccountSet = new set<id>();

        for (Opportunity opp : opptList){
            if (opp.AccountId != null){
                idAccountSet.add(opp.AccountId);
            }
        }

        List<Account> accs = AccountDAO.getAccountOppRecente(idAccountSet);

        for (Account conta : accs){

            conta.UltimaOportunidade__c = conta.Opportunities[0].Id;
        }


        OcrAccTO to = new OcrAccTO();
        to.accList = accs;

        String jsonOcr = JSON.serialize(to);
        insereContactOppContactRole(jsonOcr);
    }

    @future
    public static void insereContactOppContactRole(String jsonOcr){

        OcrAccTO to = (OcrAccTO)JSON.deserialize(jsonOcr, OpportunityBO.OcrAccTO.class);

        if (to.accList != null){
            Database.update (to.accList, false);

        }
        if (to.oppRole != null){
            Database.upsert (to.oppRole, false);
        }
    }

    public class OcrAccTO{
        public List<Account> accList{ get; set; }

        public List<OpportunityContactRole> oppRole{ get; set; }

    }

    public static void criaContratoOpp(){

        //####HISTORIA######
        /* Crie um Schudule que busque todas as oportunidades
         que estão com Estágio em “Close Won” ou com a quantia da oportunidade acima de 100 mil reais
         e crie um contrato para essa oportunidade, use a mesma Conta da oportunidade para criar o Contrato. */

        List<Contract> contractList = new List<Contract>();
        List<Opportunity> opptList = OpportunityDAO.getOpportunityIdList();

        for (Opportunity opp : opptList){
            Contract c = new Contract();
            c.AccountId = opp.AccountId;
            c.Status = 'In Approval Process';
            c.StartDate = system.today();
            c.ContractTerm = 12;
            c.Opportunity__c = opp.Id;
            contractList.add(c);
        }

        Database.insert (contractList);


        List<Opportunity> attOppList = new List<Opportunity>();

        for (Contract c : contractList){
            Opportunity opp = new Opportunity();
            opp.id = c.Opportunity__c;
            opp.ContractId = c.Id;
            attOppList.add(opp);
        }

        Database.update (attOppList);
    }

    public static void attOppSemContato(List<Opportunity> oppList){

        //###HISTORIA###
        /* Crie uma  Queueable que receba uma lista de Oportunidades e verifique se alguma dessas oportunidades
         não possuem contato, após atualizar essas oportunidades sem contato,
         associando ao primeiro Contato encontrado associado à Conta que está na Oportunidade. */

        List<Opportunity> attOppList = new List<Opportunity>();

        Set<Id> accountId = new Set<Id>();

        Map<Id, Account> mapAcc = new Map<Id, Account>();

        for (Opportunity opp : oppList){
            if (opp.ContactId == null){
                attOppList.add(opp);
                accountId.add(opp.AccountId);
            }
        }

        List<Account> listAcc = AccountDAO.getAccountContactsById(accountId);

        for (Account a : listAcc){
            mapAcc.put(a.id, a);
        }

        for (Opportunity opp : attOppList){
            Account a = mapAcc.get(opp.AccountId);
            if (a.Contacts.size() > 0){
                opp.ContactId = a.Contacts[0].Id;
            }
        }

        update attOppList;
    }

    public static List<Opportunity> attDescricao(){
        //####HISTORIA####
        /* Crie uma Queueable que busque oportunidades com a Data de Fechamento maior que a data atual,
         e atualize o campo Descrição para “Oportunidades com contato associado”.
         Após isso chame a Queable criada na atividade anterior passando para ela a lista de oportunidade buscadas.
         (Isso fará o encadeamento de duas Queueables). */
        List<Opportunity> listOpp = OpportunityDAO.getOppoDataFechamentoList();

        for (Opportunity opp : listOpp){
            opp.Description = 'Oportunidades com contato associado';
        }
        return listOpp;
    }

}
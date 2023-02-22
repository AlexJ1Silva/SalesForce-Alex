public with sharing class OpportunityDAO {
 
    public static List<Opportunity> getOpportunityIdList(){


        return [SELECT id, AccountId FROM Opportunity WHERE (StageName = 'Closed Won' OR Amount >= 1000000)];
    }

    public static List<Opportunity> getOppoDataFechamentoList(){


        return [SELECT id, AccountId, ContactId FROM Opportunity WHERE CloseDate > TODAY];
    }
}
public with sharing class OpportunitySelector {

    public static List<Opportunity> getOppByAccountIdList(set<Id> accountId){
        return [SELECT id, StageName FROM Opportunity WHERE AccountId  IN: accountId];
    }
 
}
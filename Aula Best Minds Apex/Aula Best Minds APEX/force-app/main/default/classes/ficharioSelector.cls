public with sharing class ficharioSelector {
    public static List<Fichario__c> getFicharioIdList(set<Id> accId){
        return [SELECT id, Name FROM Fichario__c WHERE Account__c  IN: accId];
    }
}
public with sharing class AccountDAO {

    public static List<Account> getAccountIdList(set<id> accountId){


        return [SELECT id, Faturamento__c FROM Account WHERE Id IN :accountId];
         
    }

    public static List<Account> getFiliaisByMatrizId(set<id> accountId){

        return [SELECT id, QuantidadeContas__c, ParentId FROM Account WHERE id IN: accountId];

    }

    public static List<Account> getAccountContactsById(set<id> accountId){

        return [SELECT id,(SELECT id FROM Contacts) FROM Account WHERE id IN: accountId];

    }

    public static List<Account> getAccountOppRecente(set<id> accountId){

        return [SELECT Id, Name, 
        (SELECT Id, Name, CreatedDate FROM Opportunities ORDER BY CreatedDate DESC LIMIT 1) 
        FROM Account 
        WHERE id 
        IN:accountId];

    }

}
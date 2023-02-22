public with sharing class ContactDAO{
    public static List<Contact> getContactIdList(set<id> accId){


        return [SELECT id, FirstName, LastName, AccountId
                FROM Contact
                WHERE AccountId IN:accId];
    }

    public static Contact getMeuContato(){


        return [SELECT id, LastName
                FROM Contact
                WHERE LastName LIKE '%ALEX JUNIO%' LIMIT 1];
    }

}
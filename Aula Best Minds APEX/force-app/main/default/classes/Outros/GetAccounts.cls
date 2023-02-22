public with sharing class GetAccounts{
    public static void getAllAccounts(){
        for (Account a : [SELECT Id, Name
                          FROM Account
                          WHERE Name Like '%teste%']){
            System.debug(a.Name);
        }
    }

}
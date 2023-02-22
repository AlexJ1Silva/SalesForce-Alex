public with sharing class UpdateClienteCampo{
    public static void updateAccontAtivoFalse(String Id){

        Account acc = new Account();
        acc.id = Id;
        acc.Ativo__c = False;

        Database.update(acc);
    }

}
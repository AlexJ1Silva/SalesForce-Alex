public with sharing class CriaCaso{
    public static void criaCasoClient(id Client){

        //Account acc = [SELECT id, Ativo__c, (SELECT id FROM Contact) FROM Account WHERE id= :Client];

        Contact cnt = [SELECT AccountId, id, Account.Ativo__c, Account.Name
                       FROM Contact
                       WHERE AccountId = :Client
                       LIMIT 1];


        if (cnt.Account.Ativo__c && cnt.Id != null){
            insertCase(cnt);

        } else{

            throw new MyException('O cliente deve estar Ativo e um contato associado para criar um caso');

        }
    }

    public static Boolean insertCase(Contact cnt){

        Case caso = new Case();
        caso.AccountId = cnt.AccountId;
        caso.Status = 'New';
        caso.Origin = 'Email';
        caso.Subject = cnt.Account.Name + ' - Sinistro';

        Boolean res = false;

        try{
            Database.insert(caso);
            res = true;
        } catch (Exception e){

            system.debug('Erro: ' + e);

            
        }


        return res;
    }

}
public with sharing class SelecionaRecordType{
    public static void selecionaConta(){

        Account acc = [SELECT Id, Name, RecordType.Name
                       FROM Account
                       WHERE RecordType.Name IN ('Teste')
                       LIMIT 1];

        try{
            acc.Name = '';
            system.debug(acc.Name);

            update acc;

        } catch (Exception e){
            system.debug('Erro ' + e);
        }
    }

    public static void attContatos(){


        List<Contact> lstContact = [SELECT Id, Name
                                    FROM Contact
                                    WHERE Account.RecordType.Name IN ('Teste')];


        integer contador = 0;

        for (Contact c : lstContact){
            if (contador < (lstContact.size() / 2)){


                c.FirstName = 'K Teste';
                c.LastName = 'K Teste' ;


            } else{
                c.FirstName = 'A Teste';
                c.LastName = 'A Teste' ;
            }
            contador++;

        }

        try{
            update lstContact;
        } catch (Exception e){

            system.debug('Erro ' + e);

        }
    }

}
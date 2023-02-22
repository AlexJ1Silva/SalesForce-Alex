public with sharing class PreencherEndContatosContasBatch implements Database.Batchable<sObject>{
    //### HISTORIA #####
    /* Crie uma Batch para preencher o endereço dos contatos de contas, com oendereço
     das contas(Fazer com que o endereço dos contatos sejao mesmo que os da contas que estão associados), porém
     essas contas a serem atualizadas devem ter no mínimo 2 contatos associados.
     */
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT id, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,
                                        (SELECT id                                                                                      
                                        FROM Contacts)
                                        FROM Account 
                                        WHERE BillingCity != null 
                                        AND BillingCountry != null 
                                        AND BillingPostalCode != null 
                                        AND BillingState != null 
                                        AND BillingStreet != null]);
    }

    public void execute(Database.BatchableContext bc, List<Account> acc){


        AccountBO.atualizaContaEndereco(acc);
    }

    public void finish(Database.BatchableContext bc){
    }

}
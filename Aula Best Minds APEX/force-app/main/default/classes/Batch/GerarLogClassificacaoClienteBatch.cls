public with sharing class GerarLogClassificacaoClienteBatch implements Database.Batchable<sObject>{
    /*    ###HISTORIA###
     Crie um batch que chame o método de reclassificação criado no exercício 2.
     Ele também deve gerar um registro de Log de classificação de cliente no início da execução
     e marcar o flag de finalizado ao finalizar a execução do batch. */
    public Database.QueryLocator start(Database.BatchableContext bc){

        return Database.getQueryLocator([SELECT id, AnnualRevenue
                                         FROM Account 
                                         WHERE ClassificaoCliente__c = null]);
                                         
    }

    public void execute(Database.BatchableContext bc, List<Account> listAcc){


        AccountBO.calculoClassificacao(listAcc);

        LogClassificaoCliente__c log = new LogClassificaoCliente__c();
        log.DataExecucao__c = System.today();
        insert log;
    }

    public void finish(Database.BatchableContext bc){

        try{
            LogClassificaoCliente__c log = [SELECT id
                                            FROM LogClassificaoCliente__c
                                            WHERE DataExecucao__c = TODAY];

            log.Finalizado__c = true;
            update log;

        } catch(Exception e) {

            system.debug('>>>>>>>'+e.getMessage());

        }
    }

}
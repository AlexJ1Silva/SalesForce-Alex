public with sharing class BuscarCasosCriadosUltimosDiasBatch implements Database.Batchable<sObject>{
    /* #### HISTORIA #####
     Crie um Contato como seu nome,

     
     depois crie uma Batch para buscar todos os Casos criados nos últimos 5 dias e que estão sem nenhum contato associado
     e
     associe todos os Casos encontrados a esse contato criado.
     */
    public Database.QueryLocator start(Database.BatchableContext bc){

        Date data = System.today() - 5;
        return Database.getQueryLocator([SELECT Id, CreatedDate
                                         FROM Case
                                         WHERE ContactId = null
                                         AND CreatedDate > :data]);
    }

    public  void execute(Database.BatchableContext bc, List<Case> caseList){


        CaseBO.associarCasosEncontrados(caseList);
    }

    public void finish(Database.BatchableContext bc){
    }

}
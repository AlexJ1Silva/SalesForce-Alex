public with sharing class AtualizarOppSemContatoQueueable implements Queueable {
    //###HISTORIA###
    /* Crie uma  Queueable que receba uma lista de Oportunidades e verifique se alguma dessas oportunidades 
    não possuem contato, após atualizar essas oportunidades sem contato, 
    associando ao primeiro Contato encontrado associado à Conta que está na Oportunidade. */
    List<Opportunity> oppList {get;set;}
    public AtualizarOppSemContatoQueueable(List<Opportunity> oppList) {
        this.oppList = oppList;
    }
    public void execute(QueueableContext context) {
        OpportunityBO.attOppSemContato(oppList);
    }

}
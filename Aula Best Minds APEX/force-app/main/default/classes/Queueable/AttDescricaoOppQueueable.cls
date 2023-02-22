public with sharing class AttDescricaoOppQueueable {
        //###HISTORIA###
        /* Crie uma  Queueable que receba uma lista de Oportunidades e verifique se alguma dessas oportunidades 
        não possuem contato, após atualizar essas oportunidades sem contato, 
        associando ao primeiro Contato encontrado associado à Conta que está na Oportunidade. */
        List<Opportunity> oppList {get;set;}
        public AttDescricaoOppQueueable() {
            
        }
        public void execute(QueueableContext context) {
           List<Opportunity> oppList = OpportunityBO.attDescricao();

           System.enqueueJob(new AtualizarOppSemContatoQueueable(oppList));
        }
}
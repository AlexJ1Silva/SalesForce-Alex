public with sharing class BuscaOportunidadesClosedWonScheduler implements Schedulable {

    //####HISTORIA######
    /* Crie um Schudule que busque todas as oportunidades 
    que estão com Estágio em “Close Won” ou com a quantia da oportunidade acima de 100 mil reais 
    e crie um contrato para essa oportunidade, use a mesma Conta da oportunidade para criar o Contrato. */
    
    // Nome do agendamento    
    private static String nome = 'Cria Contrato';
    // Cron de 1 minuto    
    private static String expressaoCron = '0 0 23 1/1 * ? *';
    // Método para iniciar o job    
    public static void agendar(){
        System.schedule(nome, expressaoCron, new BuscaOportunidadesClosedWonScheduler());
    }
    // método para executar a classe desejada.    
    public void execute(SchedulableContext context) {
        OpportunityBO.criaContratoOpp();
    }
}

   

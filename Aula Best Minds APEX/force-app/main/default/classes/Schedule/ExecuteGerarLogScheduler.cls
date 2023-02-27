public with sharing class ExecuteGerarLogScheduler implements Schedulable{
    /* ###HISTORIA###
    Crie um schedule que execute o batch todos os dias às 12:00 */

    // Nome do agendamento    
    private static String nome = 'Agendar Batch Gerar Log Classificação do Cliente';
    // Cron de 1 minuto    
    private static String expressaoCron = '0 0 12 1/1 * ? *';
    // Método para iniciar o job    
    public static void agendar(){
        System.schedule(nome, expressaoCron, new ExecuteGerarLogScheduler());
    }
    // método para executar a classe desejada.    
    public void execute(SchedulableContext context) {
        GerarLogClassificacaoClienteBatch b = new GerarLogClassificacaoClienteBatch(); 
      database.executebatch(b);
    }
}
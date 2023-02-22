public with sharing class BuscarCasosCriadosUltimosDiasScheduler implements Schedulable {
    //####HISTORIA####
    /* Crie um Schedule que chama o Batch criado na atividade 
    anterior que atualiza os Casos sem Contatos. */
    // Nome do agendamento    
    private static String nome = 'Busca COntatos Criados ultimos 5 dias';
    // Cron de 1 minuto    
    private static String expressaoCron = '0 0 23 1/1 * ? *';
    // Método para iniciar o job    
    public static void agendar(){
        System.schedule(nome, expressaoCron, new BuscarCasosCriadosUltimosDiasScheduler());
    }
    // método para executar a classe desejada.    
    public void execute(SchedulableContext context) {
        Database.executeBatch(new BuscarCasosCriadosUltimosDiasBatch());
    }

}
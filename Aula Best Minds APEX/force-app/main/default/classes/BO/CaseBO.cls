public with sharing class CaseBO{
    private static CaseBO instance = new CaseBO();
    public static CaseBO getInstance(){
        return instance;
    }

    /*  #### HISTORIA #####
     Crie um Contato como seu nome
     CONTA CRIADA >>>>ALEX ALEX JUNIO<<<<,
     depois crie uma Batch para buscar todos os Casos criados nos últimos 5 dias e que estão sem nenhum contato associado
     e
     associe todos os Casos encontrados a esse contato criado.
     */
    public static void associarCasosEncontrados(List<Case> caseList){

        List<Case> casoAtualizarList = new List<Case>();

        Contact cntc = ContactDAO.getMeuContato();
        if(cntc. == null){
           cntc.FirstName = 'Alex';
           cntc.LastName = 'Alex J';

           insert cntc;
        }

        for (Case caso : caseList){

            caso.ContactId = cntc.Id;
        }

        update caseList;
    }

}
public with sharing class FormularioListController {
    
    @AuraEnabled public static ListaFormulario__c novoFormulario(ListaFormulario__c listFormulario){
        


        try {

            insert listFormulario;
            return listFormulario;
            
        } catch (Exception e) {

            throw new AuraHandledException(e.getMessage());
            
        }



    }
}
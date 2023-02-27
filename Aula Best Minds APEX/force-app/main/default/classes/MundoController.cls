public with sharing class MundoController {
   
   
    @AuraEnabled public static Mundo__c buscarMundoList(Mundo__c mundo ){

       /*  List<MundoTO> mundoTOList = new List<MundoTO>(); 
         MundoTO terra = new mundoTO();
        terra.nome = 'Terra';
        terra.tamanho = 213137;
        terra.cor = 'azul';
        terra.possuiAgua = true;
        mundoTOList.add(terra);  */

        try {

          insert mundo;
          return mundo;
          
      } catch (Exception e) {

          throw new AuraHandledException(e.getMessage());
          
      }
     
    }

}
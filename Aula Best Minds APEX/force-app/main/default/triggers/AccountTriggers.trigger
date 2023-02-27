trigger AccountTriggers on Account(before delete, after insert, after delete ){

    if (Trigger.isInsert && Trigger.isAfter){
        AccountBO.getInstance().criarRegistro(Trigger.new );

    }

    if (Trigger.isDelete && Trigger.isBefore){
        AccountBO.getInstance().deletarFichario(Trigger.old);


        if (Trigger.isDelete && Trigger.isAfter){
            AccountBO.getInstance().criaCaso(Trigger.old);
        }

    }

    if (Trigger.isInsert || Trigger.isUpdate){

        AccountBO.getInstance().copiarCEP(Trigger.new, Trigger.oldMap);
    }

    if (Trigger.isInsert && Trigger.isAfter){
        AccountBO.getInstance().criaOpp(Trigger.new );
    }

    if (Trigger.isUpdate && Trigger.isAfter){

        AccountBO.getInstance().attStatusOpp(Trigger.new );

    }
    if(Trigger.isInsert && Trigger.isAfter){
        ExerciciosSoql e = new ExerciciosSoql();
        e.criaTaskParaAccount(Trigger.new);
        
    }

  
}
trigger CriaContaRegFichario on Account (before delete, after insert, after delete) {

    if (Trigger.isInsert && Trigger.isAfter){
    AccountBO.getInstance().criarRegistro(Trigger.new);

    }
    
    if(Trigger.isDelete && Trigger.isBefore){
        AccountBO.getInstance().deletarFichario(Trigger.old);



    if (Trigger.isDelete && Trigger.isAfter){
        AccountBO.getInstance().criaCaso(Trigger.old);
    }

    }

}
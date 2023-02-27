trigger ContactTrigger on Contact (after insert, after update) {

    if (Trigger.isUpdate && Trigger.isAfter){

       ContactBO.getInstance().contarContatos(Trigger.new);

    }

    if(Trigger.isInsert && Trigger.isAfter){

        ContactBO.getInstance().contarContatos(Trigger.new);
        
        
    }

}
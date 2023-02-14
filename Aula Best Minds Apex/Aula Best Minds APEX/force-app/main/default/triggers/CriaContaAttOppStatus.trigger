trigger CriaContaAttOppStatus on Account (before insert, after insert, after update) {

    if (Trigger.isInsert && Trigger.isAfter){
    AccountBO.getInstance().criaOpp(Trigger.new);
    }

    if(Trigger.isUpdate && Trigger.isAfter){

        AccountBO.getInstance().attStatusOpp(Trigger.new);

    }
}
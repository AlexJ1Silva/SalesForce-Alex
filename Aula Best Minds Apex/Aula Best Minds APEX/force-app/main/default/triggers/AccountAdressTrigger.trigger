trigger AccountAdressTrigger on Account(before insert, before update ){

    if (Trigger.isInsert || Trigger.isUpdate){

        AccountBO.getInstance().copiarCEP(Trigger.new, Trigger.oldMap);
    }
}
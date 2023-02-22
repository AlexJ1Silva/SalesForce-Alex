trigger OpportunityTrigger on Opportunity (after insert, before insert, after update){

    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter ){
        OpportunityBO.getInstance().creatContacOpportunityContactRole(Trigger.new);
        OpportunityBO.getInstance().attUltimaOppConta(Trigger.new);
    }

}
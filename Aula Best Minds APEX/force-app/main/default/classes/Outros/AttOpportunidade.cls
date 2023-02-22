public with sharing class AttOpportunidade{
    public static void updateAmountOpportunidade(String Id, Decimal Amount){

        Opportunity opp = [SELECT Id, Amount
                           FROM Opportunity
                           WHERE Id = :Id];

        opp.Amount = Amount;

        Database.update (opp);
    }

}
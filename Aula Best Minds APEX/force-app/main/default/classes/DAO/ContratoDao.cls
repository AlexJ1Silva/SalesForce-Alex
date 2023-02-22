public with sharing class ContratoDao {
   
    public static List<Contract> getAllRegistroContrato (){
       
        return [SELECT id, ContractNumber FROM CONTRACT ORDER BY ContractNumber DESC];

    }

    public static List<AggregateResult> getAllStatus(){
       
        return [SELECT COUNT(AccountId), Status FROM CONTRACT WHERE Status = 'Draft' OR Status = 'In Approval Process' GROUP BY Status];

    }

    public static List<Contract> getContractDate(){

        return [SELECT StartDate, EndDate FROM CONTRACT WHERE StartDate >= 2023-01-01  AND EndDate <= 2023-12-30 ORDER BY StartDate ASC];
    }


}
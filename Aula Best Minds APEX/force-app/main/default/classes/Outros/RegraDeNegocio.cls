public class RegraDeNegocio{
    private static RegraDeNegocio instance = new RegraDeNegocio();
    public static RegraDeNegocio getInstance(){
        return instance;
    }

    public void regraDeNegocioAccount(List<Account> acc, Map<Id, Account> accAntigas){
        List<Account> contasProcessar = new List<Account>();
        if (accAntigas != null){
            for (Account conta : acc){
                Account accAntiga = accAntigas.get(conta, id);
                if (conta.Match_Billing_Adress__c && (conta.BillingPostalCode == null || conta.BillingPostalCode != conta.ShippingPostalCode || conta.ShippingPostalCode != accAntiga.ShippingPostalCode)){
                    contasProcessar.add(acnt);
                }
            }
        } else{
            for (Account conta : acnt){
                if (acnt.Match_Billing_Adress__c){
                    contasProcessar.add(conta);
                }
            }
        }
        if (!contasProcessar.isEmpty()){
            for (Account conta : contasProcessar){
                conta.BillingPostalCode = conta.ShippingPostalCode;
            }
        }
    }
}


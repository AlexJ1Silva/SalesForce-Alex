public with sharing class ContactBO{
    private static ContactBO instance = new ContactBO();
    public static ContactBO getInstance(){
        return instance;
    }

    public void contarContatos(List<Contact> contact){

        Set<id> accIds = new Set<id>();

        for (Contact c : contact){
            if (c.sexualidade__c == 'Homossexual'){
                accIds.add(c.AccountId);
            }
        }

        List<Account> listAcc = new List<Account>();

        listAcc = AccountDAO.getSexualidadeAccountIdList(accIds);

        if (listAcc.size() > 0){

            for (Account acc : listAcc){

                acc.QntdHomossexuais__c = acc.Contacts.size();
            }
        }

        update listAcc;
    }

}
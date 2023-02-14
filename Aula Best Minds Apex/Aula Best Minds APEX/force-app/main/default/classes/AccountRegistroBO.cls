public class AccountRegistroBO{
    private static AccountRegistroBO instance = new AccountRegistroBO();
    public static AccountRegistroBO getInstance(){
        return instance;
    }

    public void criarRegistro(List<Account> acc){

        List<Fichario__c> newFichario = new List<Fichario__c>();

        for (Account conta : acc){

            Fichario__c f = new Fichario__c();

            f.Account__c = conta.Id;
            f.Name = 'Fichario Teste';

            newFichario.add(f);

        }
        Database.insert (newFichario);
    }

    public void deletarFichario(List<Account> acc){

        set<id> accListid = new set<id>();

        for (Account conta : acc){
            accListid.add(conta.Id);
        }

        List<Fichario__c> ficharioList = ficharioSelector.getFicharioIdList(accListid);


        database.delete (ficharioList);      
    }

    public void criaCaso(List<Account> acc){

        List<Case> cList = new List<Case>();

        for (Account conta : acc){
            Case c = new case();
            c.Status = 'New';
            c.Origin = 'Other';
            c.Description = 'A conta Id: ' + conta.id + ' Foi Deletada'; 
            c.Subject = 'Conta Deletada';
            cList.add(c);

        }
        database.insert(cList);


    }

}
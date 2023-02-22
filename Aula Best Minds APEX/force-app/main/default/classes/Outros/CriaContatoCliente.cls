public with sharing class CriaContatoCliente{
    public Boolean criaContato( id client, String primeiroName, String ultimoName, 
    String Email, Date Birthdate, String Department){


        if (client == null || String.isBlank(primeiroName) || String.isBlank(ultimoName) == null|| String.isBlank(Email)  || Birthdate == null || String.isBlank(Department)){

            System.debug('Preencha todos os campos');

            return false;

        }
        if (client != null || String.isBlank(primeiroName) || String.isBlank(ultimoName) || String.isBlank(Email) || Birthdate != null || String.isBlank(Department)){

            Contact contato = new Contact();
            contato.AccountId = client;
            contato.FirstName = primeiroName;
            contato.LastName = ultimoName;
            contato.Email = Email;
            contato.Birthdate = Birthdate;
            contato.Department = Department;

            Database.insert(contato);

            system.debug('Contato criado');


            return true;
        }

        return true;
    } 

    
   

}
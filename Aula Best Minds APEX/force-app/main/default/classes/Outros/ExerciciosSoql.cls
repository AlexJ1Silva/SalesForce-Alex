public with sharing class ExerciciosSoql{
    
        public List<Contract> TodosOsContratos(){
            List<Contract> contratosDoSales = [SELECT Id
                                               FROM Contract];
            return contratosDoSales;
        }

        public List<Contract> TodosOsContratosFinalizados(){
            List<Contract> ContratosFinalizados = [SELECT Id
                                                   FROM Contract
                                                   WHERE status = 'Activated'];
            return ContratosFinalizados;
        }

        public Integer NumeroDeContratosAbertos(){
            Integer QuantidadeContratosAbertos = [SELECT COUNT()
                                                  FROM Contract
                                                  WHERE status != 'Activated'];
            return QuantidadeContratosAbertos;
        }

        public void printaTestAccount(){
            List<Account> contasTeste = [SELECT Id, Name
                                         FROM Account
                                         WHERE Name LIKE '%teste%'];
            for (Account conta : contasTeste){
                System.debug('>>>' + conta.Name);
            }
        }

        public List<Task> criaTaskParaAccount(List<Account> todasContas){
            /* List<Account> todasContas = [SELECT Id, OwnerId, Name
                                         FROM Account]; */
            List<Task> TasksParaInserir = new List<Task>();
            for (Account conta : todasContas){
                Task novaTask = new Task();
                novaTask.Subject = 'Call';
                novaTask.Status = 'Not Started';
                novaTask.Priority = 'Normal';
                novaTask.WhatId = conta.Id;
                novaTask.OwnerId = conta.OwnerId;
                TasksParaInserir.add(novaTask);
            }
            if (!TasksParaInserir.isEmpty()){
                insert TasksParaInserir;
            }

            return TasksParaInserir;
        }

}


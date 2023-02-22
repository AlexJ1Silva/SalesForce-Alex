public with sharing class TaskAccountAll{
    public static void creatTaskAccount(){
        List<Account> accList = [SELECT id, OwnerId
                                 FROM ACCOUNT];
        List<Task> creatTask = new List<task>();


        if (accList.size() < 0){
            for (Account a : accList){
                Task tsk = new Task();
                tsk.Subject = 'Call';
                tsk.Status = 'Not Started';
                tsk.Priority = 'Normal';
                tsk.WhatId = a.Id;
                tsk.OwnerId = a.OwnerId;
                creatTask.add(tsk);
            }

        }
        If (creatTask.size() > 0){
            Database.insert (creatTask);
        }
    }

}
public with sharing class AccountSearchLWC {

    @AuraEnabled(cacheable=true)
    public static list<Account> SearchAccount(string AccName){
        system.debug('Invoked'+AccName);
        String Term='%'+AccName+'%';
        return [Select Id, Name, Website,Industry FROM Account WHERE Name like :Term];
}
}
  
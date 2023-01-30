trigger ContactMinBirth on Contact (after update) {
    set<Id> relatedIds = new set<Id>();
    for (Contact con:trigger.new){
        relatedIds.add(con.AccountId);
    }
    List<Account> accts = [select Id,Name,(select Name, Birthdate from Contacts order by Birthdate Asc limit 1) 
                           from Account where Id in :relatedIds];
    for(Account acc :accts){
        acc.YoungestBirthDay__c = acc.Contacts[0].BirthDate;
    }
    update accts;
}
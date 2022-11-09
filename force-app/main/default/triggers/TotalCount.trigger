trigger TotalCount on Contact (after insert , after update , after delete) {
    //list<Account>Acc1 = new List <account>();
    set <id>RelatedID = new set<id>();
    if(trigger.isinsert || trigger.isupdate || trigger.isdelete){
        for ( Contact Cons: Trigger.new){
            RelatedID.add(Cons.AccountId);
        }
        List <Account> AccRel= [Select Name, TotalContact__c, (Select Id from Contacts)  from Account WHERE Id in: RelatedID ];
        for (Account Acc : AccRel){
            List<Contact> ConChange = Acc.Contacts;
            //system.debug(ConChange.size());
            Acc.TotalContact__c = ConChange.size();
        }
        if( AccRel.size()>0){
            Database.Update(AccRel,False);
        }
    }
}
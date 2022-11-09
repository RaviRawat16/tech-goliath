trigger SumOfOpps on Opportunity (after insert ,  after update) {
    set <id>RelatedID = new set<id>();
    if(trigger.isinsert || trigger.isupdate){
        for ( Opportunity Oppty: Trigger.new){
            RelatedID.add(Oppty.AccountId);
        }
        List <Account> AccRel= [Select Id,Sum_Of_Opportunities__c, (Select Amount from Opportunities order by Amount Desc limit 2) 
                                from Account WHERE Id in: RelatedID ];
        for (Account Acc : AccRel){
            Double X=0;
            for (Opportunity Opps : Acc.Opportunities){
                X = X + Opps.Amount;
            }
            Acc.Sum_Of_Opportunities__c = X;
        }
        if( AccRel.size()>0){
            Database.Update(AccRel,False);
        }
    }
}
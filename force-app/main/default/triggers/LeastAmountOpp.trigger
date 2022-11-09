trigger LeastAmountOpp on Account (before update ) {
    list<account> AccOpp=[Select Id , Least_Amount_Opportunity__c, (
        Select Name, Amount from Opportunities order by Amount ASC limit 1) from account ];
    for(Account acc:trigger.new){
        for (Account Accx : Accopp){
            for(Opportunity leastOpp : Accx.Opportunities){
                if(acc.Id == Accx.Id){
                    acc.Least_Amount_Opportunity__c = leastOpp.Name;
                }
            }
        }
    }   
}
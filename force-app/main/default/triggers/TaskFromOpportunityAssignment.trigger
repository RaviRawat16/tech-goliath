trigger TaskFromOpportunityAssignment on Opportunity (after insert , after update) {
    
    set<Id> relatedIds = new set<Id>(); 			//Empty set to get updated/inserted Opportunity Ids
    
    for(Opportunity opps: Trigger.new){        
        if(opps.StageName=='Negotiation/Review'){
            relatedIds.add(opps.Id);
        }
    }
    TaskFromOpportunityAssignmentClass.taskFromOpportunity(relatedIds); // pass set of Ids as Parameter to helper Class Method
}
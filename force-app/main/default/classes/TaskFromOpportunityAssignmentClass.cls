public class TaskFromOpportunityAssignmentClass {
    
    public static void taskFromOpportunity(set<Id> relatedIds){     // Get relatedId set from trigger as Parameter for method
        
        List<Task> newTask = new List<Task>();						// Create a List of Empty tasks
        
        // Get list of opportunities which have been inserted or updated
        List<Opportunity> selectedOpp = [Select Id, AccountId, Account.OwnerId from Opportunity where Id IN:relatedIds];        
        
        for(Opportunity oppRelTask : selectedOpp){   // Iterate over the above opportunity list
            
            Task ownerTask = new Task();
            
            //add values to task fields
            ownerTask.Subject = 'Please work on Opportunity';
            ownerTask.WhatId = oppRelTask.Id;                       // Link Task Created to opportunity updated
            ownerTask.OwnerId = oppRelTask.Account.OwnerId;         // Assign opportunity Account Owner Id to Task owner 
            ownerTask.ActivityDate = date.today()+10;
            newTask.add(ownerTask);
        }
        if(newTask.size()>0){
            database.insert(newTask); 			// Insert task to database
        }    
    }
    
}
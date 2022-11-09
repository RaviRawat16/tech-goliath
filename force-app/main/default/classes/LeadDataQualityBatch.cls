public class LeadDataQualityBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [Select Id, FirstName,LastName,Email,Phone,Website,Title,
             Fields_Polpulated__c , Data_Quality__c from Lead]
        );
    }
    public void execute(Database.BatchableContext bc, List<Lead> leadInputs){
        list<Task> newTask = new list<Task>();
        for (Lead newLead : leadInputs){	
            list<string>counter =new list <string>();
            Decimal Sum  = 20;
            if(newLead.FirstName != null){
                counter.add(newLead.FirstName);
                sum = sum+20;
            }
            if(newLead.Email != null){
                counter.add(newLead.Email);
                sum = sum+25;
            }
            if(newLead.Phone != null){
                counter.add(newLead.Phone);
                sum = sum+25;
            }
            if(newLead.Website != null){
                counter.add(newLead.Website);
                sum = sum+10;
            }
            if(newLead.Title != null){
                counter.add(newLead.Title);
                sum=sum+10;
            }
            counter.add(newLead.LastName);
            newLead.Fields_Polpulated__c=counter.size();
            newLead.Data_Quality__c=(sum/110)*100;
            if (newLead.Fields_Polpulated__c > 2){
                user u =[Select Id from user where alias=: 'bwayn'];
                for (string fields : counter){
                    if(fields != null){
                        Task t1 = new Task();
                        t1.Subject='Verify the '+fields+' field';
                        t1.WhoId = newLead.id;
                        t1.OwnerId=u.id;
                        newTask.add(t1); 
                    }
                }
                
            }}
        Database.update(leadInputs,false);   
        Database.Insert(newTask,false);
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Opportunity Name Update');
    }
    
}
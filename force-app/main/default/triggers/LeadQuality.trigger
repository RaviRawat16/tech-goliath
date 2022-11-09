trigger LeadQuality on Lead (before insert, after insert) {
    list<Task> newTask = new list<Task>();
    list<Task> consideration = new list<Task>();
    for (Lead newLead : trigger.new){
        if(trigger.isinsert && trigger.isbefore){
            set<string>counter =new set <string>();
            decimal sum = 0;
            if(newLead.FirstName != null){
                counter.add(newLead.FirstName);
                sum = sum+10;
            }
            if(newLead.LastName != null){
                counter.add(newLead.LastName);
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
            newLead.Fields_Polpulated__c=counter.size();
            newLead.Data_Quality__c=(sum/100)*100;
            
        }
        //system.debug(counter);
        if(trigger.isinsert && trigger.isafter &&newLead.Fields_Polpulated__c>2){
            list<String> testFields=New list<String>();
            user u =[Select Id from user where alias=: 'bwayn'];
            if(newLead.FirstName != null){
                if(newLead.FirstName.containsIgnoreCase('TEST')){
                    testFields.add('FirstName');
                }
                Task t1 = new Task();
                t1.Subject='Verify the '+'FirstName'+' field';
                t1.WhoId = newLead.id;
                t1.OwnerId=u.id;
                newTask.add(t1);
            }
            if(newLead.LastName != null){
                if(newLead.LastName.containsIgnoreCase('TEST')){
                    testFields.add('LastName');
                }
                Task t1 = new Task();
                t1.Subject='Verify the'+'LastName'+'field';
                t1.WhoId = newLead.id;
                t1.OwnerId=u.id;
                newTask.add(t1);
            }
            if(newLead.Title != null){
                if(newLead.Title.containsIgnoreCase('TEST')){
                    testFields.add('Title');
                }
                Task t1 = new Task();
                t1.Subject='Verify the'+'Title'+'field';
                t1.WhoId = newLead.id;
                t1.OwnerId=u.id;
                newTask.add(t1);
            }
            if(newLead.Phone != null){
                if(newLead.Phone.containsIgnoreCase('TEST')){
                    testFields.add('Phone');
                }
                Task t1 = new Task();
                t1.Subject='Verify the'+'Phone'+'field';
                t1.WhoId = newLead.id;
                t1.OwnerId=u.id;
                newTask.add(t1);
            }
            if(newLead.Email != null){
                if(newLead.Email.containsIgnoreCase('TEST')){
                    testFields.add('Email');
                }
                Task t1 = new Task();
                t1.Subject='Verify the'+'Email'+'field';
                t1.WhoId = newLead.id;
                t1.OwnerId=u.id;
                newTask.add(t1);
            }
            if(newLead.Website != null){
                if(newLead.Website.containsIgnoreCase('TEST')){
                    testFields.add('Website');
                }
                Task t1 = new Task();
                t1.Subject='Verify the'+'Website'+'field';
                t1.WhoId = newLead.id;
                t1.OwnerId=u.id;
                newTask.add(t1);
            }
            if(testFields.size()>0){
                if(newLead.ByPassTriggers__c!=True){
                    Task t1 = new Task();
                    t1.Description='This Lead contains the TEST keyword in the following key fields: '+ testFields ;
                    t1.Subject='Warnings!!!!!';
                    t1.WhoId=newLead.Id;
                    consideration.add(t1);
                }
            }
            
        }
    }  
    insert consideration;    
    insert newTask;
}
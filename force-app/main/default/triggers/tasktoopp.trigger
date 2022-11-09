trigger tasktoopp on Opportunity (before insert, after insert, after update ) {
    List <Task> MyList = new List <Task>();
    for (opportunity opp : Trigger.New){
        if(opp.Amount>10000) {
            if (trigger.isbefore){
                opp.StageName = 'Immediate Attention Required';}
            
            if (trigger.isinsert && trigger.isafter){    
            	OpportunityContactRole ocr =new OpportunityContactRole();
            	ocr.ContactId = '0035g00000e96QhAAI';
            	ocr.OpportunityId = opp.Id;
            	ocr.Role = 'Decision Maker';
            	Insert ocr;
            }
            if((trigger.isinsert || trigger.isupdate) && trigger.isafter){
                 MyList.add(new Task(Subject = 'Immediate Attention Required High Importance Opportunity created',
                 Description = 'please action ASAP and close the opportunity',
                                     Priority='High',WhatId = opp.Id));}
                    
        }
        else{
            if(Trigger.isInsert && trigger.isafter){
                MyList.add(new Task(Subject = 'Immediate Attention Required ',
                Description = 'please action ASAP and close the opportunity',
                Priority='High',WhatId = opp.id));
            }
            }
    }
    if(MyList.size()>0){
        insert MyList;
    }   
}
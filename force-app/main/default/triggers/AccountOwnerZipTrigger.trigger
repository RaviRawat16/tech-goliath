trigger AccountOwnerZipTrigger on Account (before insert,before update, after update, after insert){   
    
    List<Territory__c> terriCodes = [Select Zip_Code__c,Owner__c from Territory__c ]; //List of Zip Codes And OwnerIds
    
    if(Trigger.isInsert && Trigger.isBefore){       			
        AccountOwnerZipHelper.insertAccountOwner(Trigger.new , terriCodes);			//Method for inserted Account
    }
    
    List<Account> updatedAccount = new List<Account>();
    if(Trigger.isUpdate && Trigger.isBefore){
        for(Account acc : Trigger.new){
            Account accOld = Trigger.oldMap.get(acc.Id);
            if(acc.BillingPostalCode!= accOld.BillingPostalCode){
                updatedAccount.add(acc);									//List of Updated Accounts
            }            
        }
    }
    
    AccountOwnerZipHelper.updateAccountOwner(updatedAccount ,terriCodes);		//Method for updated Account
    
    set<Id> updatedIds= new Set<Id>();
    if(Trigger.isUpdate && Trigger.isAfter){
        for(Account Acc : Trigger.new){
            Account accOld = Trigger.oldMap.get(acc.Id);
            if(Acc.BillingPostalCode!= accOld.BillingPostalCode){
                updatedIds.add(Acc.Id);										//Set of Ids of Updated Accounts
            }            
        }
    } 		
    AccountOwnerZipRelatedComp.oppAndContactOwner(updatedIds);				// Method for updating Contact and Opportunity Owner
    
    if(Trigger.isInsert && Trigger.isAfter){
        AssignmentHistory.insertAccountToHistory(Trigger.new ,terriCodes); 			//	Method for inserted Account
    }
    
    if(Trigger.isUpdate && Trigger.isAfter){
        AssignmentHistory.updateAccountToHistory(Trigger.new ,terriCodes,Trigger.oldMap);//	Method for inserted Account
        AccountOwnerZipEmail.sendEmail(Trigger.new ,Trigger.oldMap);
    }
    
}

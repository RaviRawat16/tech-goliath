public class UniqueSalesRepAccount {
    
    public static void changeAccountOwner(List<Territory__c>triggerNew , map<Id,Territory__c>triggerOlds){
        
        map<string,list<string>> zipIds = new map<string,list<string>>(); 	//Map(ZipCodes,List of owner (can be) more than one)
        set<string>changedOwner = new set<string>();
        for(Territory__c newOwn : triggerNew){
            if(newOwn.Owner__c!=triggerOlds.get(newOwn.Id).Owner__c){
                //newOwner.put(newOwn.Zip_Code__c,newOwn.Owner__c); 
                changedOwner.add(newOwn.Zip_Code__c);      // Get only those ZipCodes where owner has Changed
            }
        }
        
        List<Territory__c> terricodes = [Select Owner__c , Zip_Code__c from Territory__c Where Zip_Code__c In:changedOwner];
        for(Territory__c terr:terricodes){							// Loop for Territories
            List<Id> entries = new list<Id>();
            if(!zipIds.containsKey(terr.Zip_Code__c)){
                entries.add(terr.Owner__c);
                zipIds.put(terr.Zip_Code__c,entries);
            }
            else{           
                zipIds.get(terr.Zip_Code__c).add(terr.Owner__c);}
        }
        
        // List of only those Account where Owner where Postal address has owner changed and run loop to assign new Owners
        list<Account> changedAccOwner = [Select OwnerId,BillingPostalCode from Account where BillingPostalCode=:changedOwner];
        
        for(Account acc:changedAccOwner){
            if(zipIds.containskey(acc.BillingPostalCode)){
                
                // if One Zip code has more than one Owner assigned
                acc.OwnerId=zipIds.get(acc.BillingPostalCode)[Integer.valueof((Math.random() * zipIds.get(acc.BillingPostalCode).size()))];       							//Update Account Owners
                
            }  
        }															  
        if(changedAccOwner.size()>0){
            update changedAccOwner;  
        }
    }    
}
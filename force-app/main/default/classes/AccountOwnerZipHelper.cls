public class AccountOwnerZipHelper{
    
    public static void insertAccountOwner(List<Account> triggerOp , List<Territory__c> terriCodes){
        
        map<String,list<Id>> zipIds= new map<String,list<Id>>();     // map of Zipcodes and List of Relared owner Ids
        
        for(Territory__c terr:terricodes){							// Loop for Territories
            List<Id> entries = new list<Id>();
            
            //populate the map
            
            if(!zipIds.containsKey(terr.Zip_Code__c)){
                entries.add(terr.Owner__c);
                zipIds.put(terr.Zip_Code__c,entries);
            }
            else{           
                zipIds.get(terr.Zip_Code__c).add(terr.Owner__c);}
        }
        
        for(Account acc : triggerOp){									// Loop for Inserted Accounts
            
            if(zipIds.containskey(acc.BillingPostalCode)){
                // if One Zip code has more than one Owner assigned random Assignment
                acc.OwnerId=zipIds.get(acc.BillingPostalCode)[Integer.valueof((Math.random() * zipIds.get(acc.BillingPostalCode).size()))];       							//Update Account Owners
                
            }
        }  
    }
    
    public static void updateAccountOwner(List<Account> triggerOp ,List<Territory__c> terriCodes){  
        
        map<String,list<Id>> zipIds= new map<String,list<Id>>();			// map of Zipcodes and List of Relared owner Ids
        
        for(Territory__c terr:terricodes){							// Loop for Territories
            List<Id> entries = new list<Id>();
            
            //populate the map
            
            if(!zipIds.containsKey(terr.Zip_Code__c)){	
                entries.add(terr.Owner__c);
                zipIds.put(terr.Zip_Code__c,entries);
            }
            else{           
                zipIds.get(terr.Zip_Code__c).add(terr.Owner__c);}
        }
        
        for(Account acc : triggerOp){									// Loop for Updated Accounts
            
            if(zipIds.containskey(acc.BillingPostalCode)){
                // if One Zip code has more than one Owner assigned random Assignment
                acc.OwnerId=zipIds.get(acc.BillingPostalCode)[Integer.valueof((Math.random() * zipIds.get(acc.BillingPostalCode).size()))];       							//Update Account Owners
                
            }
        }  
        
    }
}
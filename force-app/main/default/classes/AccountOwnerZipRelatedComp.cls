public class AccountOwnerZipRelatedComp {
    
    public static void oppAndContactOwner(set<Id> updatedIds){
        
        // List of Related Contacts of updated Accounts
        List<Contact> updateCon = [Select OwnerId , AccountId , Account.OwnerId  
                                   from Contact where AccountId IN:updatedIds];	
        
        // List of Related Opportunity of updated Accounts
        List<Opportunity> updateOpp = [Select OwnerId , AccountId ,Account.OwnerId 
                                       from Opportunity where AccountId IN:updatedIds AND StageName ='Qualification'];
        
        for(Contact con: updateCon){
            con.OwnerId = con.Account.OwnerId;			//Update Contact Owner based on Account Owner
        }
        
        for(Opportunity opps: updateOpp){
            opps.OwnerId = opps.Account.OwnerId;		//Update Opportunity Owner based on Account Owner
        }
        
        if(updateCon.size()>0){
            Update updateCon;  
        }
        if(updateCon.size()>0){
            Update updateOpp;  
        }      			
    }
}
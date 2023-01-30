@istest
public class TerritoryTriggerTestClass {
    
    @testsetup
    static void TerritoryTriggerTestClassTestData(){
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        List<User> testUser = new List<User>();
        
        // List of Users 
        for(integer i=1 ;i<=5;i++){
            testUser.add(new User(firstname = 'ABC'+i, 
                                  lastName = 'XYZ'+i, 
                                  email = 'uniqueName' + '@test'  + '.org', 
                                  Username = 'uniqueName'+i + '@test'  + '.org', 
                                  EmailEncodingKey = 'ISO-8859-1', 
                                  Alias = 'unique'+i, 
                                  TimeZoneSidKey = 'America/Los_Angeles', 
                                  LocaleSidKey = 'en_US', 
                                  LanguageLocaleKey = 'en_US', 
                                  ProfileId = pf.Id
                                 )); 
        }
        insert testUser;				// Insert the test data users
    }
    
    @istest
    static void territoryTriggerTestForInsert(){
        // enter the Zip Codes and assign Owners (users) to each
        list<User>returnedUser =[Select id from User];
        List<Territory__c> testTerritory = new List<Territory__c>();
        testTerritory.add(new Territory__c(Zip_Code__c='10001' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10002' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[1].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[3].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10005' , Owner__c=returnedUser[3].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10006' , Owner__c=returnedUser[4].Id));         
        insert testTerritory; 
        
        Territory__c terri = new Territory__c();
        terri.Zip_Code__c = '10003';
        terri.Owner__c= returnedUser[4].id;
        
        List<Territory__c> updateTerr = [Select Zip_Code__c ,Owner__c from Territory__c where Zip_Code__c =:'10004'];
        updateTerr[0].Zip_Code__c='10003';
        
        test.startTest();        
        // should throw error if we try to assign more than three Owners to one Zip-code
        try{
            Insert terri;
        }
        catch(Exception error){
            system.assert(error.getMessage().contains('A single Zip cannot be assigned to more than three sales rep'));
        }
        test.stopTest();     
    }
    @istest
    static void territoryTriggerTestForUpdate(){
        list<User>returnedUser =[Select id from User];
        List<Territory__c> testTerritory = new List<Territory__c>();
        testTerritory.add(new Territory__c(Zip_Code__c='10001' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10002' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[1].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[3].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10005' , Owner__c=returnedUser[3].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10006' , Owner__c=returnedUser[4].Id));         
        insert testTerritory; 
        
        List<Territory__c> updateTerr = [Select Zip_Code__c ,Owner__c from Territory__c where Zip_Code__c =:'10004'];
        
        updateTerr[0].Zip_Code__c='10003'; 			// Try to update Zip code so that new Owner is added to ZipCode with already
        											// three unique users        
        test.startTest();        
            // should throw error if we try to update zip code assigning more than Owners to one Zip-code
        try{
            update updateTerr;
        }
        catch(Exception error){
            system.assert(error.getMessage().contains('A single Zip cannot be assigned to more than three sales rep'));
        }
        test.stopTest();     
    }
    
    @istest
    
    // test for if Zip code's owner is changed than Account with
    // same PostalBillingCode should also have updated Account Owner
    static void territoryTriggerTestAccountOwnerUpdate(){
        
        list<User>returnedUser =[Select id from User];
        List<Territory__c> testTerritory = new List<Territory__c>();
        testTerritory.add(new Territory__c(Zip_Code__c='10001' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10002' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[1].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[3].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10005' , Owner__c=returnedUser[3].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10006' , Owner__c=returnedUser[4].Id));         
        insert testTerritory; 
        
        List<Territory__c> updatedTerr = [Select Zip_Code__c ,Owner__c from Territory__c where Zip_Code__c =:'10001'];
        List<Territory__c> changeTerrOwner = [Select Zip_Code__c ,Owner__c from Territory__c where Zip_Code__c =:'10006'];
        
        Account acc =new Account();			// insert a test account 
        acc.Name='Acme Life';
        acc.BillingPostalCode='10001';
        insert acc;
        
        updatedTerr[0].Owner__c=changeTerrOwner[0].Owner__c; // Update Territory Record Owner's Name and test if 
        													 // account owner's name is also changed        
        test.startTest();
        update updatedTerr;						
        test.stopTest();
        List<Account> testAcc = [Select BillingPostalCode,OwnerId from Account where BillingPostalCode=:'10001'];
        system.assertEquals(changeTerrOwner[0].Owner__c, testAcc[0].OwnerId);        
    }
}
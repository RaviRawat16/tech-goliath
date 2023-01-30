@istest
public class AccountOwnerZipCodeTest {
    
    @testsetup
    static void AccountOwnerTriggerTestData(){
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
    static void AccountOwnerTriggerInsertTest(){
        
        // enter the Zip Codes and assign Owners (users) to each
        list<User>returnedUser =[Select id from User];
        List<Territory__c> testTerritory = new List<Territory__c>();
        testTerritory.add(new Territory__c(Zip_Code__c='10001' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10002' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[1].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[2].Id)); 
        
        insert testTerritory;
        
        // Create Accounts with Above ZipCodes as PostalBillingCodes
        
        List<Account> testAcc = new List<Account>();
        testAcc.add(new Account(BillingPostalCode='10001' , Name='TestAcc1'));
        testAcc.add(new Account(BillingPostalCode='10002' , Name='TestAcc2'));
        testAcc.add(new Account(BillingPostalCode='10003' , Name='TestAcc3'));
        testAcc.add(new Account(BillingPostalCode='10003' , Name='TestAcc4'));
        
        test.startTest();               
        insert testAcc;
        test.stopTest();
        list<Account> returnedAccount = [Select BillingPostalCode , OwnerId from Account where BillingPostalCode =:'10001'];
        list<Territory__c> returnedTerri = [Select Zip_Code__c , Owner__c from Territory__c where Zip_Code__c =:'10001'];
        system.assertEquals(returnedTerri[0].Owner__c, returnedAccount[0].OwnerId);
    }
    
    @istest
    static void AccountOwnerTriggerUpdateTest(){
        
        // enter the Zip Codes and assign Owners (users) to each
        list<User>returnedUser =[Select id from User];
        List<Territory__c> testTerritory = new List<Territory__c>();
        testTerritory.add(new Territory__c(Zip_Code__c='10001' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10002' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[0].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[1].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10003' , Owner__c=returnedUser[2].Id));
        testTerritory.add(new Territory__c(Zip_Code__c='10004' , Owner__c=returnedUser[2].Id)); 
        
        insert testTerritory;
        
        // Create Accounts with Above ZipCodes as PostalBillingCodes
        
        List<Account> testAcc = new List<Account>();
        testAcc.add(new Account(BillingPostalCode='10001' , Name='TestAcc1'));
        insert testAcc;
        
        list<Account> updatedAcc = [Select BillingPostalCode , OwnerId from Account where BillingPostalCode =:'10001'];
		updatedAcc[0].BillingPostalCode = '10003';     
        test.startTest();               
        Database.update(updatedAcc);
        test.stopTest();

        // more than one owner for zip code - 10003
        list<Account> returnedAccount = [Select BillingPostalCode , OwnerId from Account where BillingPostalCode =:'10003'];
        list<Territory__c> returnedTerri = [Select Zip_Code__c , Owner__c from Territory__c where Zip_Code__c =:'10003'];
   		Boolean results=false;
        integer count=0;
        for(Territory__c terrs :returnedTerri){
            if(terrs.Owner__c ==returnedAccount[0].OwnerId){
                count+=1;
            }
        }
        if(count>0){
            results=true;
        }
        system.assertEquals(true, results);
    }
}
@istest
public class TaskFromOpportunityAssignmentTest {
    
    @testsetup
    public static void taskFromOpportunityAssignmentData(){
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        List<User> testUser = new List<User>();
        
        // List of Users 
        for(integer i=1 ;i<3;i++){
            testUser.add(new User(firstname = 'ABC'+i,lastName = 'XYZ'+i, email = 'uniqueName' + '@test'  + '.org', 
                                  Username = 'uniqueName'+i + '@test'  + '.org',EmailEncodingKey = 'ISO-8859-1', 
                                  Alias = 'unique'+i,TimeZoneSidKey = 'America/Los_Angeles', 
                                  LocaleSidKey = 'en_US', LanguageLocaleKey = 'en_US',ProfileId = pf.Id )); 
        }
        insert testUser;				// Insert the test data users
    }
    
    @istest
    public static void taskFromOpportunityAssignmentInsertTest(){
        
        list<User>returnedUser =[Select id from User];
        
        List<Account> testAcc = new List<Account>();
        testAcc.add(new Account(Name='testAcc1' , OwnerId=returnedUser[0].Id));
        testAcc.add(new Account(Name='testAcc2' , OwnerId=returnedUser[1].Id)); 
        
        insert testAcc;
        
        List<Account> getAcc1 = [Select id, Name from Account where Name Like '%Acc1%'];
        List<Account> getAcc2 = [Select id, Name from Account where Name Like '%Acc2%'];
        
        List<Opportunity> testOpp = new List<Opportunity>();
		testOpp.add(new Opportunity(AccountId=getAcc1[0].Id , Name='testOpp1' , CloseDate = date.today(), StageName = 'Negotiation/Review'));
        testOpp.add(new Opportunity(AccountId=getAcc2[0].Id , Name='testOpp2' , CloseDate = date.today(), StageName = 'Prospecting')); 
        
        test.startTest();
        insert testOpp;
        test.stopTest();
        
		List<Opportunity> trialOpp1 = [Select Id, Name, Account.OwnerId from Opportunity where StageName ='Negotiation/Review'];
        List<Task> trialTask1 = [Select OwnerId, Activitydate from Task where WhatId =: trialOpp1[0].Id];
        system.debug(trialTask1.size());
        system.assertEquals(trialOpp1[0].Account.OwnerId,trialTask1[0].OwnerId);
        
        List<Opportunity> trialOpp2 = [Select Id, Name, Account.OwnerId from Opportunity where StageName ='Prospecting'];
        List<Task> trialTask2 = [Select OwnerId, Activitydate from Task where WhatId =: trialOpp2[0].Id];
        system.debug(trialTask2.size());
        system.assertEquals(0, trialTask2.size());
    }
    
    @istest
    public static void taskFromOpportunityAssignmentUpdateTest(){
        
        list<User>returnedUser =[Select id from User];
        
        List<Account> testAcc = new List<Account>();
        testAcc.add(new Account(Name='testAcc1' , OwnerId=returnedUser[0].Id));
        testAcc.add(new Account(Name='testAcc2' , OwnerId=returnedUser[1].Id)); 
        
        insert testAcc;
        
        List<Account> getAcc1 = [Select id, Name from Account where Name Like '%Acc1%'];
        List<Account> getAcc2 = [Select id, Name from Account where Name Like '%Acc2%'];
        
        List<Opportunity> testOpp = new List<Opportunity>();
		testOpp.add(new Opportunity(AccountId=getAcc1[0].Id , Name='testOpp1' , CloseDate = date.today(), StageName = 'Qualification'));
        testOpp.add(new Opportunity(AccountId=getAcc2[0].Id , Name='testOpp2' , CloseDate = date.today(), StageName = 'Qualification')); 
        insert testOpp;
        List<Opportunity> trialOpp = [Select Id, StageName, Account.OwnerId from Opportunity];
        trialOpp[0].StageName = 'Negotiation/Review';
        trialOpp[1].StageName = 'Prospecting';
        
        test.startTest();
        update trialOpp;
        test.stopTest();
        
		List<Opportunity> trialOpp1 = [Select Id, Name, Account.OwnerId from Opportunity where StageName ='Negotiation/Review'];
        List<Task> trialTask1 = [Select OwnerId, Activitydate from Task where WhatId =: trialOpp1[0].Id];
        system.debug(trialTask1.size());
        system.assertEquals(trialOpp1[0].Account.OwnerId,trialTask1[0].OwnerId);
        
        List<Opportunity> trialOpp2 = [Select Id, Name, Account.OwnerId from Opportunity where StageName ='Prospecting'];
        List<Task> trialTask2 = [Select OwnerId, Activitydate from Task where WhatId =: trialOpp2[0].Id];
        system.debug(trialTask2.size());
        system.assertEquals(0, trialTask2.size());
    }
}

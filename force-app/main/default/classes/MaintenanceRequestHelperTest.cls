@istest
public with sharing class MaintenanceRequestHelperTest {
    
    @istest
    public static void MaintenanceRequestBulkTest(){
        product2 testProduct = new product2();
        testProduct.Name = 'plug';
        testProduct.Maintenance_Cycle__c = 5;
        testProduct.Replacement_Part__c = true;
        
        Database.insert(testProduct);        
        
        List<case> testCase = new List<case>();
        for(Integer i=0;i<300;i++){
            Case newCase = new Case();
            newCase.Type = 'Repair';
            newcase.Status = 'Working';
            newCase.Subject = 'Test Data';
            newCase.Date_Reported__c = Date.today();
            newCase.ProductId = testProduct.id;
            testcase.add(newCase);
        }
        database.insert(testCase);
        
        List<Equipment_Maintenance_Item__c> newEmi = new List<Equipment_Maintenance_Item__c>();
        for(Integer i=0;i<3;i++){
            Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c();
            emi.Maintenance_Request__c = testCase[1].id;
            emi.Quantity__c = 5;
            emi.Equipment__c = testProduct.Id;
            newEmi.add(emi);
        }
        database.insert(newEmi);
        
        list<Case> testCases = [Select id ,Subject,Status from Case where Status='Working'];
        
        for(case cs :testCases){
            cs.Subject = 'Ran Test data';
            cs.Status = 'Closed';
        }
        test.startTest();
        Database.update(testCases);
        test.stopTest();
        Integer newCaseBulk = [Select count() from case where Status =:'New'];
        System.assertEquals(300, newCaseBulk);
        
    }
    
    @istest 
    public static void MaintenanceRequestPositiveTest(){
        product2 testProduct = new product2(Name = 'plug',Maintenance_Cycle__c = 5, Replacement_Part__c = true);
        
        Database.insert(testProduct);        
        
        Case testCase = new Case();
        testCase.Type = 'Repair';
        testCase.Status = 'Working';
        testCase.Subject = 'Test Data';
        testCase.Date_Reported__c = Date.today();
        testCase.ProductId = testProduct.id;
        
        database.insert(testCase,false);
        
        List<Equipment_Maintenance_Item__c> newEmi = new List<Equipment_Maintenance_Item__c>();
        for(Integer i=0;i<3;i++){
            Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c();
            emi.Maintenance_Request__c = testCase.id;
            emi.Quantity__c = 5;
            emi.Equipment__c = testProduct.Id;
            newEmi.add(emi);
        }
        database.insert(newEmi);
        list<Case> testCases = [Select id ,Subject,Status from Case where Status='Working'];
        for(case cs :testCases){
            cs.Subject = 'Ran Test data';
            cs.Status = 'Closed';
        }
        test.startTest();
        Database.update(testCases);
        test.stopTest();
        Integer newCasePositive = [Select count() from case where Status=:'New'];
        System.assertEquals(1, newCasePositive);
    }
    @istest public static void MaintenanceRequestNegativeTest(){
        product2 testProduct = new product2(Name = 'plug',Maintenance_Cycle__c = 5, Replacement_Part__c = true);
        
        Database.insert(testProduct); 
        
        
        Case testCase = new Case();
        testCase.Type = 'Repair';
        testCase.Status = 'Working';
        testCase.Subject = 'Test Data';
        testCase.Date_Reported__c = Date.today();
        testCase.ProductId = testProduct.id;
        
        database.insert(testCase,false);
        
        List<Equipment_Maintenance_Item__c> newEmi = new List<Equipment_Maintenance_Item__c>();
        for(Integer i=0;i<3;i++){
            Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c();
            emi.Maintenance_Request__c = testCase.id;
            emi.Quantity__c = 5;
            emi.Equipment__c = testProduct.Id;
            newEmi.add(emi);
        }
        database.insert(newEmi,False);
        
        list<Case> testCases = [Select id ,Subject,Status from Case where Status='Working'];
        for(case cs :testCases){
            cs.Subject = 'Ran Test data';
        }
        test.startTest();
        Database.update(testCases);
        test.stopTest();
        Integer newCaseNegative = [Select count() from case where Status =:'New'];
        System.assertEquals(0, newCaseNegative);
    }
}
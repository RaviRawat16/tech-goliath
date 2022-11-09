@isTest
private class LeadTriggerTest {
    @TestSetup
    static void leadphone(){
        Lead lacc = new Lead();
        lacc.FirstName = 'Adam';
        lacc.Lastname = 'Rooney';
        lacc.Company='NA';
        lacc.Status = 'Not Confirmed';
        //lacc.phone = null;
        //lacc.mobilephone='9997234888';
        Insert lacc; 
    }
    @isTest static void test1() {
               
        Lead lc = [Select Id,Phone from Lead];
        lc.phone = null;
        lc.mobilephone='9997234888';
        Test.startTest();
        update lc;
        Test.stoptest();  
        Lead l = [ Select Id,Phone from Lead where id=:lc.Id];
        System.assertEquals('9997234888', l.Phone) ;
       }
    @istest static void test2(){
        Lead lc = [Select Id,Phone from Lead];
        lc.phone = '9';
        lc.mobilephone ='9997234888';
        update lc;
        Test.startTest();
        update lc;
        Test.stoptest();  
        Lead l = [Select Id, Phone from Lead where id=:lc.Id];
        System.assertEquals('9', l.Phone) ;
    }
    @istest static void test3(){
        Lead lc = [Select Id,Phone from Lead];
        lc.phone = null;
        lc.mobilephone =null;
        update lc;
        Test.startTest();
        update lc;
        Test.stoptest();  
        Lead l = [Select Id, Phone from Lead where id=:lc.Id];
        System.assertEquals(null, l.Phone) ;
    }
    @istest static void test4(){
        Lead lc = [Select Id,Phone from Lead];
        lc.phone = '9997234888';
        lc.mobilephone =null;
        update lc;
        Test.startTest();
        update lc;
        Test.stoptest();  
        Lead l = [Select Id, Phone from Lead where id=:lc.Id];
        System.assertEquals('9997234888', l.Phone) ;
    }
}
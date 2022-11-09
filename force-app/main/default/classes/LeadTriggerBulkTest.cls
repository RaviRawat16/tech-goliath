@isTest
private class LeadTriggerBulkTest {
    @TestSetup
    static void leadphone(){
    	list<Lead> NewList = new list<Lead>();
        for(integer i=0; i<=100; i++){
        Lead lacc = new Lead();
        lacc.FirstName = 'Adam';
        lacc.Lastname = 'Rooney'+i;
        lacc.Company='NA';
        lacc.Status = 'Not Confirmed';
        lacc.phone = null;
        lacc.mobilephone=string.valueOf(1000000+i);
        NewList.add(lacc);
        }
        Insert NewList; 
    }
    @isTest static void test1() {
               
        list<Lead> lc = [Select Id,Phone from Lead];
        lc[49].Phone = '9997234852';
        lc[57].Phone = '9779177215';
        lc[66].Phone = '9997234888';
        update lc;
        Test.startTest();
        update lc;
        Test.stoptest(); 
        list<Lead> l = [ Select Id,Phone from Lead];
        System.assertEquals('9997234852', l[49].Phone);
        system.assertEquals('9779177215', l[57].Phone);
        system.assertEquals('1000058', l[58].Phone);
        system.assertEquals(lc[28].MobilePhone, l[28].MobilePhone);
       }
   
}
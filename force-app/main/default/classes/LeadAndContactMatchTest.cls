@istest
public class LeadAndContactMatchTest {
    @TestSetup
    static void ContactCheck(){
        List <Contact> TestCon = new List <Contact>();
        for (Integer i = 1 ; i < 20 ; i++){
            Contact AddCon = new Contact();
            AddCon.FirstName = 'Wayne'+i;
            AddCon.LastName = 'Rooney'+i;
            AddCon.Email ='Always'+i+'@united.com';
            TestCon.add(Addcon);
        }
        Insert TestCon;        
    }
    @istest
    static void LeadContactTest(){
        List <Lead> TestLead = new List <Lead>();
        for (Integer i = 1 ; i < 20 ; i++){
            Lead InsLead = new Lead();
            InsLead.FirstName = 'Wayne'+i;
            InsLead.LastName = 'Rooney'+i;
            InsLead.Email = 'alway_s'+i+'@united.com';
            TestLead.add(InsLead);
        }
        test.startTest();
        try{
            Insert TestLead;
        }
        catch(Exception error){
            system.assert(error.getMessage().contains('This Contact already exist. Use it for Lead'));
        }
        }
    }
public class FriendsFoodBillClass {

    public static List<SplitBill__c> splitted = new List<SplitBill__c>(); // List to store the SplitBill Created

    public static void EqualSplit(list<id>billsId){        
        List<Bill__c> billGenerated = [Select Name, BillAmount__c,Type__c ,
                                        HeadCount__c from Bill__c where Id IN :billsId];

        for(Bill__c bills : billGenerated){
            for ( integer i = 1; i<= bills.HeadCount__c ; i++){
                SplitBill__c splits = new SplitBill__c();
                splits.Person__c = bills.Name+i;
                splits.AmountOwed__c = bills.BillAmount__c/bills.HeadCount__c;
                splits.SplitType__c = bills.Type__c;
                splits.Bill__c = bills.Id;
                splitted.add(splits);
            }
        }
    }
    public static void PortionSplit(list<id>billsId){        
        List<Bill__c> billGenerated = [Select Name, BillAmount__c, Type__c , HeadCount__c,Individual_Portions__c
                                       from Bill__c where Id IN :billsId];
        
        for(Bill__c bills : billGenerated){

            // List of contribution made by people individually as CSV
            List<string> individualContributions=bills.Individual_Portions__c.split(',');
            
                // Run loop based on number of people splitting bill
                for(integer i=1; i<=individualContributions.size(); i++){       
                    SplitBill__c splits = new SplitBill__c();
                    splits.Person__c = bills.Name+i;
                     
                    // split amount owed based on individual contribution list created above
                    splits.AmountOwed__c = bills.BillAmount__c*decimal.valueOf(individualContributions[i-1])/100;
                    splits.SplitType__c = bills.Type__c;
                    splits.Bill__c = bills.Id;
                    splitted.add(splits);               
                }            
        }      
    }
    public static void NoSplit(list<id>billsId){        
        
        List<Bill__c> billGenerated = [Select Name, BillAmount__c,Type__c ,HeadCount__c 
                                        from Bill__c where Id IN :billsId];
                                        
        for(Bill__c bills : billGenerated){
            SplitBill__c splits = new SplitBill__c();
            splits.Person__c = bills.Name;
            splits.AmountOwed__c = bills.BillAmount__c;
            splits.SplitType__c = bills.Type__c;
            splits.Bill__c = bills.Id;
            splitted.add(splits);
        }
    }
    public static void ExecuteBill(){
    insert splitted;
    }
}
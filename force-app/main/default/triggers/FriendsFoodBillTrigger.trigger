trigger FriendsFoodBillTrigger on Bill__c (After Insert) {
    List<id>equalBills = new List<id>();     //list of bills equally split
    List<id>portionBills = new List<id>();   //list of bills partially split
    List<id>noSplitBills = new List<id>();   //list of bills not split   
    for ( Bill__c bills : Trigger.new){
        if(Bills.Type__c == 'Equal Split'){
            equalBills.add(bills.Id);
        }

        else if(Bills.Type__c == 'Portion Split'){
            system.debug(bills.Individual_Portions__c);

            Double splitPercent=0;  // Variable to get sum of individual Contributions

            //List of Portion entered as csv
            List<string> individualContributions=bills.Individual_Portions__c.split(',');

            for(string indContri: individualContributions){
                splitPercent+=decimal.valueOf(indContri);
            }
            system.debug(splitPercent);

            // Condition for Percent owed total =100 and bill split counter should be less than equal to Head count
            if(individualContributions.size()<=bills.HeadCount__c && splitPercent==100){       
                portionBills.add(bills.Id);
            }                      
            else{                                                           
                bills.addError('Please enter the correct value of head count or contributing people count or Split portion');          
                // else error in data entered and no record created
            }
        }
        else{
            noSplitBills.add(bills.Id);
        }
    }

    //call the class and lists created above to respective methods

    if(equalBills.size()>0){
        FriendsFoodBillClass.EqualSplit(equalBills);  
    } 
    if(portionBills.size()>0){
        FriendsFoodBillClass.PortionSplit(portionBills);  
    } 
    if(noSplitBills.size()>0){
        FriendsFoodBillClass.NoSplit(noSplitBills);
    }
    FriendsFoodBillClass.ExecuteBill();    // execute method to Insert the split Bill records only once
}
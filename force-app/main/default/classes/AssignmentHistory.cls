public class AssignmentHistory {
    
    public static void insertAccountToHistory(List<Account> triggerIns,List<Territory__c> terriCodes){
        List<Assignment_History__c> assignHis = new List<Assignment_History__c>();
        for(Account acc: triggerIns){
            Assignment_History__c aHC = new Assignment_History__c();
            aHC.New_Owner__c= acc.OwnerId;
            aHC.Account__c=acc.Id;
            aHC.Changed_By__c= acc.LastModifiedById;
            for (Territory__c terri : terriCodes){
                if(acc.BillingPostalCode==terri.Zip_Code__c && acc.OwnerId==terri.Owner__c){
                    aHC.New_Territory__c=terri.Id;
                }
            }
            assignHis.add(aHC);
        }
        insert assignHis;
    }
    public static void updateAccountToHistory(List<Account> triggerIns,List<Territory__c> terriCodes,Map<Id,Account> triggerOuts){
        List<Assignment_History__c> assignHis = new List<Assignment_History__c>();
        for(Account acc : triggerIns){
            if(acc.BillingPostalCode !=triggerOuts.get(acc.Id).BillingPostalCode){
                Assignment_History__c aHC = new Assignment_History__c();
                aHC.New_Owner__c= acc.OwnerId;
                aHC.Previous_Owner__c=triggerOuts.get(acc.Id).OwnerId;
                aHC.Changed_By__c= acc.LastModifiedById;
                aHC.Account__c=acc.Id;
                for (Territory__c terri : terriCodes){
                    if(acc.BillingPostalCode==terri.Zip_Code__c && acc.OwnerId==terri.Owner__c){
                        aHC.New_Territory__c=terri.Id;
                    }
                    if(triggerOuts.get(acc.Id).BillingPostalCode==terri.Zip_Code__c && triggerOuts.get(acc.Id).OwnerId==terri.Owner__c){
                      aHC.Previous_Territory__c=terri.Id;  
                    }
                }
                assignHis.add(aHC);
            }
        }
        insert assignHis;        
    }
}
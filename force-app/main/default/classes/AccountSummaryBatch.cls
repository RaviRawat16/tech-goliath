public class AccountSummaryBatch implements Database.Batchable<sObject>, Database.Stateful {
    Map<String,Account_Summary__c> mapAsics = new Map<String,Account_Summary__c>();
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [Select Id, Industry ,(Select Id, Name from Contacts),(Select id,Amount from Opportunities where Amount != null)
             from Account where Industry != null]);
    }
    public void execute(Database.BatchableContext bc, List<Account> AccountSum){
        set<String> industries  = new set<string>();
        set<String> extID = new set<String>();
        for (Account Acc : AccountSum){
            industries.add(Acc.Industry);
            extID.add(Acc.Industry+date.today());
        }
        for(String ind : industries){
            Account_Summary__c accSu =new Account_Summary__c();
            if(mapAsics.containsKey(ind)){
                accSu = mapAsics.get(ind);
                for(Account Acc : AccountSum){
                    if(Acc.Industry == ind){
                        accSu.Account_Records__c=accSu.Account_Records__c+1;
                        accSu.Contact_Records__c=accSu.Contact_Records__c+Acc.Contacts.size();
                        for(Opportunity Oppty:Acc.opportunities){
                            accSu.Sum_of_Opportunity__c=accSu.Sum_of_Opportunity__c+Oppty.amount;
                        }
                    }
                }
            }
            else{
                accSu.External_ID__c = ind+date.today();
                accSu.Name=ind+ind;
                accSu.Account_Industry__c = ind;
                Decimal AccCount =0;//accSu.Account_Records__c;
                Decimal ConCount =0;//accSu.Contact_Records__c;
                double oppSum=0;//accSu.Sum_of_Opportunity__c;
                for(Account Acc : AccountSum){
                    if(Acc.Industry == ind){
                        AccCount=AccCount+1;
                        ConCount=ConCount+Acc.Contacts.size();
                        for(Opportunity Oppty:Acc.opportunities){
                            oppSum=oppSum+Oppty.amount;
                        }
                    }
                }
                accSu.Account_Records__c = AccCount;
                accSu.Contact_Records__c = ConCount;
                accSu.Sum_of_Opportunity__c=oppSum;
            }
            system.debug(accSu);
            mapAsics.put(ind,accSu);
        }  
        upsert mapAsics.values() Account_Summary__c.External_Id__c;
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Opportunity Name Update');  
        //upsert mapAsics.values() Account_Summary__c.External_Id__c;
    }
}
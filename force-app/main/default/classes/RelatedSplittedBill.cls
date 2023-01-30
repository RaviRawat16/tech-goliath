public with sharing class RelatedSplittedBill {

    @AuraEnabled(cacheable=true)
    public static List<SplitBill__c> noPortionSplit(string keySearch){

        // Search Splitted Bills based on the id Retrieved and passes to keySearch variable

        List<SplitBill__c> splittedBill = [Select Id, Person__c,AmountOwed__c, SplitType__c, Bill__c, 
        Portion_Owed__c From SplitBill__c Where Bill__c=:keySearch];

        //return the list to the LWC file 

        return splittedBill;
    }
}

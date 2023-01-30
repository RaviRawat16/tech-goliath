public with sharing class AccountRelatedConAndOpp {

    @AuraEnabled(cacheable=true)   
    public static List<Contact> conRelatedToAcc( string searchKey) {
        return ([Select Id , Name from Contact where AccountId =: searchKey]);
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opptyRelatedToAcc( string searchKey) {
        return ([Select StageName , Name from Opportunity where AccountId =: searchKey]);
    }
}

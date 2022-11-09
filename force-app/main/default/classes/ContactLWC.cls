public with sharing class ContactLWC {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Integer Num) {
        return [
            SELECT Id, FirstName, LastName,AccountId
            FROM Contact
            ORDER BY FirstName Asc Limit:Num
        ];
    }
}
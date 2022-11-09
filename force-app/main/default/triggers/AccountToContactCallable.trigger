trigger AccountToContactCallable on Contact (After Update , After Insert , After Delete) {
    //Write a trigger that populates an Account’s “Callable Contacts” field (new custom field). 
    //This trigger should populate this field with the total number of related 
    //Contacts that have a phone number populated. Should work when contacts are inserted updated and deleted
    set <Id> RelatedToId = new set <Id>();
    if (trigger.isinsert || trigger.isupdate){
        for (Contact RelatedCons : Trigger.New){
            RelatedToId.add(RelatedCons.AccountId);
        }
    }
    if(trigger.isdelete){
        for (Contact RelatedCons : Trigger.Old){
            RelatedToId.add(RelatedCons.AccountId);
        }
    }
    List <Account> AccRelated = [Select Id , Name , Callable_Contacts__c,(Select Id, Name from Contacts where Phone != Null)
                                 from Account where Id in : RelatedToId];
    for( Account UpdateCallable : AccRelated){
        UpdateCallable.Callable_Contacts__c = UpdateCallable.Contacts.size();
    }
    if( AccRelated.size()>0){
        Database.Update(AccRelated,False);
    }
}
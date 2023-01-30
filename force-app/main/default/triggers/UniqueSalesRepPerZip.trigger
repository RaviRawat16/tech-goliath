trigger UniqueSalesRepPerZip on Territory__c (before insert, before update , after update){
    
    map<String,integer> uniqueReps = new map<String,integer>();
    List <AggregateResult> zipCodeOwner = [Select Zip_Code__c , Count(Owner__c)owncount from Territory__c Group By Zip_Code__c];
    for(AggregateResult uniqueOwner : zipCodeOwner){
        uniqueReps.put(string.valueof(uniqueOwner.get('Zip_Code__c')) , integer.valueof(uniqueOwner.get('owncount')));
    }
    if(trigger.isInsert && trigger.isBefore){
        for(Territory__c terriTrig : Trigger.new){
            if(uniqueReps.get(terriTrig.Zip_Code__c)==3 && uniqueReps.containskey(terriTrig.Zip_Code__c)){
                terriTrig.addError('A single Zip cannot be assigned to more than three sales rep');
            }
        }
    }
    if(trigger.isUpdate && trigger.isBefore){
        for(Territory__c terriTrig : Trigger.new){
            if(terriTrig.Zip_Code__c!=trigger.oldmap.get(terriTrig.Id).Zip_Code__c){
                if(uniqueReps.get(terriTrig.Zip_Code__c)>=3 && uniqueReps.containskey(terriTrig.Zip_Code__c)){
                    terriTrig.addError('A single Zip cannot be assigned to more than three sales rep');
                }
            }
        }
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        UniqueSalesRepAccount.changeAccountOwner(trigger.new , trigger.oldmap);
    }
}
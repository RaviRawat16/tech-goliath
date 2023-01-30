trigger TerritoryCustomOjectTrigger on Territory__c (before insert, before update , after update){
        
    if(trigger.isInsert){							// Run Trigger for before Insert to make sure not more than three users for one zip
        TerritoryCustomObjectClass.territoryInsert(Trigger.new); //class.method for before insert
    }
    
    if(trigger.isUpdate){							// Run Trigger for before Insert/Update to make sure not more than three users for one zip
             TerritoryCustomObjectClass.territoryUpdate(trigger.new , trigger.oldMap);  //class.method for before update
    }
    
    // trigger for Change of Account Owner when Zip-code owner changes in below class
    if(Trigger.isAfter && Trigger.isUpdate){
        TerritoryCustomOwnerToAccountOwner.changeAccountOwner(trigger.new , trigger.oldmap);
    }

}
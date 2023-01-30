trigger ContactBirthCurrentMonth on Account (before update) {
    set<Id> relatedIds = new set<Id>();
    for(Account acc : Trigger.new){
        relatedIds.add(acc.Id);
    }
}
trigger AcoountDeleteTrigger on Account (before delete) {
    // Prevent the deletion of accounts if they have related opportunities.
    for (Account acc : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(acc.Id).addError(
            'Cannot delete account with related opportunities.');
    }
}
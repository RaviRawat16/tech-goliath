global with sharing class WarehouseSyncSchedule implements Schedulable {
      
    global void execute(SchedulableContext SCT)
    {
        system.enqueueJob(new WarehouseCalloutService());
    }
    
}

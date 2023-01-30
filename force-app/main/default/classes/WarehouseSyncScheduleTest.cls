@isTest
public with sharing class WarehouseSyncScheduleTest {
    public static string CRON_EXP = '0 0 1 * * ?';
    @isTest    
    public static void WarehouseSyncTest(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        String jobId = System.schedule('SchedulableWarehouseTest',CRON_EXP, new WarehouseSyncSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId]; 
        
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2022-11-17 01:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
        
    }
}
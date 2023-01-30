@isTest
private class WarehouseCalloutServiceTest {   
    @isTest  
    static void testWareHouseCallout(){
        // implement mock callout test here
        Test.setMock(HTTPCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        //WarehouseCalloutService.WarehouseRecords();
        system.enqueueJob(new WarehouseCalloutService());
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Product2]);
    }     
}


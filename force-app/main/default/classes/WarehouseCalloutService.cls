global with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    global static void WarehouseRecords(){ 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(WAREHOUSE_URL); //define the end point
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            List<Object> jsonResponse = (List<Object>)JSON.deserializeUntyped(response.getBody());
            List<Product2> productList = new List<Product2>();
            for(Object obj : jsonResponse) {
                Map<String,Object> productInventory = (Map<String,Object>)obj;
                Product2 prod = new Product2();
                prod.Replacement_Part__c = (Boolean)productInventory.get('replacement');
                prod.Current_Inventory__c = (Double) productInventory.get('quantity');
                prod.Name = (String)productInventory.get('name');
                prod.Maintenance_Cycle__c = (Integer)productInventory.get('maintenanceperiod');
                prod.Lifespan_Months__c = (Integer)productInventory.get('lifespan');
                prod.Cost__c = (Decimal) productInventory.get('cost');
                prod.Warehouse_SKU__c = (String)productInventory.get('sku');
                productList.add(prod);
            }            
            if(productList.size()>0)
                upsert productList;
        }        
    }    
    public static void execute(QueueableContext context){
        WarehouseRecords();
    }
}
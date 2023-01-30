public class MaintenanceRequestHelper {
    
    public static void updateCases(list<Id> applicableCases){
        Map<Id, Integer> mapProduct = new Map<Id, Integer>(); 
           List<Case> newCases = new List<Case>();
        
        List<case> closedCases = [SELECT id,Vehicle__c,Subject,ProductID,Product__c, 
                               (SELECT id from Equipment_Maintenance_Items__r) from case 
                               where Id IN :applicableCases];
        
        Map<id,Equipment_Maintenance_Item__c> newEquipmentItems = new map<id,Equipment_Maintenance_Item__c>
            ([Select ID, Equipment__c, Quantity__c,Equipment__r.id,Equipment__r.Maintenance_Cycle__c from Equipment_Maintenance_Item__c ]);
        List<Equipment_Maintenance_Item__c> newEquipmentList = new List<Equipment_Maintenance_Item__c>();
		
        Integer days=1000;
        for(Case css: closedCases){
            Case newCase = new Case();
            newCase.Vehicle__c = css.Vehicle__c;
            newCase.Type = 'Routine Maintenance';
            newCase.ProductId = css.ProductId;
            newCase.Subject = 'Routine Maintenance Request Created';
            newCase.Date_Reported__c = Date.today();
            newCase.Status = 'New';
            newCase.Product__c = css.Product__c;
            newCase.ParentId = css.Id;
            for(Equipment_Maintenance_Item__c emi : css.Equipment_Maintenance_Items__r ){
                days = Math.min(Days,Integer.valueOf(newEquipmentItems.get(emi.id).Equipment__r.Maintenance_Cycle__c));
                newEquipmentList.add(new Equipment_Maintenance_Item__c(
                    Equipment__c = newEquipmentItems.get(emi.id).Equipment__c,
                    Maintenance_Request__c = css.id,
                    Quantity__c = newEquipmentItems.get(emi.id).Quantity__c));
            }
            Date dueDate = date.TODAY().adddays(days);
            newCase.Date_Due__c = dueDate;
            newCases.add(newCase);
        }
        if(newCases.size() > 0){
            insert newCases;
        }
        for(Case cs: newCases){
            for(Equipment_Maintenance_Item__c maintItems : newEquipmentList){
                if(cs.parentID == maintItems.Maintenance_Request__c){
                    maintItems.Maintenance_Request__c = cs.id;    
                }
            }
        }
        
        if(newEquipmentList.size()>0){
            Database.insert(newEquipmentList);    
        }             
        
    }           
    
}
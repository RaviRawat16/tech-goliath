trigger MaintenanceRequest on Case (before update, after update) {
    List<id>referCase = new List<id>();
    if(trigger.isAfter && trigger.isUpdate){
        for (Case css:Trigger.new){
            if(css.Status=='Closed'&&(css.Type=='Repair'||css.Type=='Routine Maintenance')){
                  referCase.add(css.Id);
        } }           
    }if(referCase.size()>0){
    MaintenanceRequestHelper.updateCases(referCase);
    }
}
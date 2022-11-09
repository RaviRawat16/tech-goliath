trigger LeadTrigger on Lead (before update) {
    for (Lead lphone : Trigger.New){
        if(lphone.phone == null){
            
            lphone.Phone = lphone.MobilePhone;
            
        }
    }

}
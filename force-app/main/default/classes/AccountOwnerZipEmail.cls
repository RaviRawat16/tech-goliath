                //When an account owner is changed, send an email to both the previous 
                //and the new owner notifying them of the change



public class AccountOwnerZipEmail {
    
    public static void sendEmail(List<Account> triggerNew, Map<Id,Account> triggerOld){
        
        set<Id> mailIds = new set<Id>();
        for(Account acc : triggerNew){
            if(acc.OwnerId != triggerOld.get(acc.Id).OwnerId){
                mailIds.add(acc.OwnerId);
                mailIds.add(triggerOld.get(acc.Id).OwnerId);
            }
        }
        List<User> changedOwner=[Select Email , Name from User where Id IN: mailIds];
        system.debug(changedOwner);
        
        List<Messaging.SingleEmailMessage> massMails = new List<Messaging.SingleEmailMessage>();
        
        for(Account acc : triggerNew){
            for(User sendMail : changedOwner){
                if (acc.OwnerId == sendMail.Id){
                    Messaging.SingleEmailMessage eachMail = new Messaging.SingleEmailMessage();
                    String[] sendingTo = new String[0];
                    system.debug(sendMail);
                    sendingTo.add(sendMail.Email);
                    system.debug(sendingTo);
                    eachMail.setToAddresses(sendingTo);
                    eachMail.setSubject(acc.OwnerId);
                    eachMail.setHtmlBody('Account Owner Changed for Account:'+acc.Id);
                    massMails.add(eachMail);
                    Messaging.sendEmail(massMails);
                    system.debug(massMails);
                } 
                if (triggerOld.get(acc.Id).OwnerId == sendMail.Id){
                    Messaging.SingleEmailMessage eachMail = new Messaging.SingleEmailMessage();
                    String[] sendingTo = new String[0];
                    system.debug(sendMail);
                    sendingTo.add(sendMail.Email);
                    system.debug(sendingTo);
                    eachMail.setToAddresses(sendingTo);
                    eachMail.setSubject(triggerOld.get(acc.Id).OwnerId);
                    eachMail.setHtmlBody('Account Owner Changed for Account:'+acc.Id);
                    massMails.add(eachMail);
                    Messaging.sendEmail(massMails);
                    system.debug(massMails);
                }    
            }
        }
    }
}
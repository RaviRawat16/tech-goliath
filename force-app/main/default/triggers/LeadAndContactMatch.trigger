//   No new lead should be created if Contact Contains First Name,
//    Last Name and Email
trigger LeadAndContactMatch on Lead (before insert) {
    list <Contact> Cons = [Select FirstName , LastName , Email from Contact];
    for(Lead LeadCon : Trigger.new){
        for(Contact ConToLead : Cons){
            if (LeadCon.FirstName == ConToLead.FirstName && 
                LeadCon.LastName == ConToLead.LastName &&
                LeadCon.Email == ConToLead.Email){
                    LeadCon.addError('This Contact already exist. Use it for Lead');
                }
        }
    }
}
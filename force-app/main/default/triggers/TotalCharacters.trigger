trigger TotalCharacters on Lead (before insert ,before update) {
    for (Lead LeadChar : trigger.new){        
        LeadChar.TotalCharacters__c =LeadChar.LastName.Length();
        }  
    }

trigger NameError on Contact (before insert ,before update) {
    if(trigger.isinsert || trigger.isupdate){
        for (Contact conError : trigger.new){
            if(conError.FirstName == conError.LastName){
                conError.addError('FirstName And LastName are Same');
            }
        }
    }
}
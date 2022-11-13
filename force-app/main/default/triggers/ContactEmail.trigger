trigger ContactEmail on Contact (before insert , before update) {
    if(trigger.isinsert || trigger.isupdate){
        for (Contact conEmail : trigger.new){
            if(conEmail.Email == null){
                conEmail.Email ='noemail@gmail.com';
            }
        }
    }
}
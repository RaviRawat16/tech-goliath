trigger ContactTrigger on Contact (before update) {
    for (Contact l : Trigger.new) {
        if( l.phone.startswith('0')){
            l.Phone= ' ';
}
}
}

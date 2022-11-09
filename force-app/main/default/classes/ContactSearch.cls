public class ContactSearch {
    public static Contact[] searchForContacts(String LN , String MPC){
        String a=LN;
        String b=MPC;
        Contact[] C = [Select Name,Id from 
                       Contact where (LastName =:a AND MailingPostalCode =:b)];
        Return C;
    }

}

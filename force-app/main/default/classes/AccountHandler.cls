public class AccountHandler {
    public static Account insertNewAccount(String newName){
        Account Acc = new Account();
        try{
            Acc.Name = newName;
            insert Acc;
            return Acc;
        }
        catch (exception e){
            return null;
        }
    }
}
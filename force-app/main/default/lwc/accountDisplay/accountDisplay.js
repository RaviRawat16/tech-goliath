import { LightningElement,track, wire } from 'lwc'; 
import SearchAccount from '@salesforce/apex/AccountSearchLWC.SearchAccount';

export default class AccountDisplay extends LightningElement {
    @track seachTerm=''
    Accs=[]
    accountID
    

    changeInput(event){
        this.searchTerm = event.target.value
    }
    UpdateSearch(){
        SearchAccount({AccName:this.searchTerm}).then(results=>{
            this.Accs=results
            console.log(this.Accs)
        })       
    }
    AccountSelected(event){
        this.accountID = event.target.value
        console.log(this.accountID)
    }
    CreateContact(){
        const popup = this.template.querySelector("c-contact-for-account");
        popup.show();
    }
}
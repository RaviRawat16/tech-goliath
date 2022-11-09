import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId'
export default class contactForAccount extends LightningElement {
    showContact=false
    LastName=LASTNAME_FIELD
    AccountId= ACCOUNTID_FIELD
    objectApi=CONTACT_OBJECT
    @api accId
    @api show(){
        this.showContact=true
    }
    dialogClose(){
        this.showContact=false
    }
    handleSuccess(){
        if(this.recordId !== null){
            this.dispatchEvent(new ShowToastEvent({
                    title: "SUCCESS!",
                    message: "New record has been created.",
                   variant: "success",
                }),
           );
         }
    }
}
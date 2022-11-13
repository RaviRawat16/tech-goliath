import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import AccountId_FIELD from '@salesforce/schema/Contact.AccountId';

export default class ContactRecord extends LightningElement {
    objectApi=CONTACT_OBJECT
    recordFields = [FIRSTNAME_FIELD , LASTNAME_FIELD, AccountId_FIELD]

    eventSuccessful(event){
        const newEvent = new ShowToastEvent({
        title : "Contact Created",
        message :"Conatct was Created",
        variant :"Success"
        });
        this.dispatchEvent(newEvent)
    }
}

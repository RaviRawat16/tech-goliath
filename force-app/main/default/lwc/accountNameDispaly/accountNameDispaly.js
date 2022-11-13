import { LightningElement,api,wire } from 'lwc';
import { getRecord ,getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';


export default class AccountNameDispaly extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD] })
    account;


    get name() {
        return getFieldValue(this.account.data, NAME_FIELD);
    }

}
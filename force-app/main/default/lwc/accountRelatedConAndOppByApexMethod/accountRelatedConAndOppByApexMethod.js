import { LightningElement,wire,track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import conRelatedToAcc from '@salesforce/apex/AccountRelatedConAndOpp.conRelatedToAcc';      // call method from apex class
import opptyRelatedToAcc from '@salesforce/apex/AccountRelatedConAndOpp.opptyRelatedToAcc';  // call method from apex class

const columnCon = [{label:'Name',fieldName:'Name'},                  // define columns to diaplay value
    {label:'Id',fieldName:'Id'}]

    const columnOpp = [{label:'Name',fieldName:'Name'},                // define columns to diaplay value
    {label:'StageName',fieldName:'StageName'}]

export default class AccountRelatedConAndOppByApexMethod extends LightningElement {

    @api recordId

    @track dataCon = []                // Empty array declared to store value of retrieved records related to account
    @track columnCon = columnCon

    @track dataOpp = []                // Empty array declared to store value of retrieved records related to account
    @track columnOpp = columnOpp

    @wire(conRelatedToAcc,({searchKey : '$recordId'}))  //Get records using the above recordId passed as parameter to apex method
    wiredContact({ error, data }) {
        if (data) {
            this.dataCon = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.dataCon = undefined;
        }
    }

    @wire(opptyRelatedToAcc,({searchKey : '$recordId'}))  //Get records using the above recordId passed as parameter to apex method
    wiredOpportunity({ error, data }) {
        if (data) {
            this.dataOpp = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.dataOpp = undefined;
        }
    }


}
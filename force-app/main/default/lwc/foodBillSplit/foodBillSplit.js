import { LightningElement,wire,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import retrieveBillReference from '@salesforce/apex/RelatedSplittedBill.noPortionSplit';
import Bill_Object from '@salesforce/schema/Bill__c';
import Name_Field from '@salesforce/schema/Bill__c.Name';
import BillAmount_Field from '@salesforce/schema/Bill__c.BillAmount__c';
import HeadCount_Field from '@salesforce/schema/Bill__c.HeadCount__c';
import IndiPortion_Field from '@salesforce/schema/Bill__c.Individual_Portions__c';
import Type_Field from '@salesforce/schema/Bill__c.Type__c';

const columns = [{label:'Name',fieldName:'Person__c'},
    {label:'Amount Owed',fieldName:'AmountOwed__c'},{label:'Portion Owed',fieldName:'Portion_Owed__c'},
    {label:'Type',fieldName:'SplitType__c'}]

export default class foodBillSplit extends LightningElement {
    @track billPerPerson=[]                     // List to store Retrieved data
    objectApi=Bill_Object
    @track Name = Name_Field
    @track BillAmount=BillAmount_Field
    @track HeadCount= HeadCount_Field
    @track IndiPortion=IndiPortion_Field
    @track Type=Type_Field
    @track recordId
    column=columns
    Show=false
    error;

    hideField = true;                       // Value is true so Individual Portions field is disabled

    openContri(event){
        this.hideField=event.target.value!=='Portion Split'      // make the Individual Portions field visible based on picklist
      
    }
  handleSuccess(event){
        this.recordId=event.detail.id                //Id of records created (to retrieve the records created by trigger action
        console.log(this.recordId)
        if(this.recordId !== null){
            this.Show=true
            this.dispatchEvent(new ShowToastEvent({
                    title: "SUCCESS!",
                    message: "New record has been created.",
                   variant: "success",
                }),
           );
         }
        }

            
    @wire(retrieveBillReference,{keySearch : '$recordId'})   //Get records using the above Id created
    wiredBill({ error, data }) {
        if (data) {
            this.billPerPerson = data;
            console.log(this.billPerPerson)
            this.error = undefined;
        } else if (error) {
            this.error = error;
            console.log('error')
            this.billPerPerson = undefined;
        }
    }
        
}
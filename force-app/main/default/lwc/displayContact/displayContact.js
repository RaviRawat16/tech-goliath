import { LightningElement, wire } from "lwc";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import PARENTACCOUNT_FIELD from "@salesforce/schema/Contact.AccountId";
import getContacts from "@salesforce/apex/ContactLWC.getContacts";

const COLUMNS = [
	{ label: "First Name", fieldName: FIRSTNAME_FIELD.fieldApiName, type: "text" },
	{ label: "Last Name", fieldName: LASTNAME_FIELD.fieldApiName, type: "text" },
	{ label: "Parent Account", fieldName: PARENTACCOUNT_FIELD.fieldApiName, type: "text" },
]

export default class displayContact extends LightningElement {
	columns = COLUMNS
	contacts;

    recordCount;

    inputedData(event){
        this.recordCount = event.detail.value;
    }
    handleClick(){
        getContacts({Num:this.recordCount})
        .then((data)=>{
            this.contacts=data
        })
    }
    
}
    
    
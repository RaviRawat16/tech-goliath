import { LightningElement, api, wire,track } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';  // wire adapter to get RelatedList records

const columnCon = [{label:'Name',fieldName:'Name'},             // define columns to diaplay value
    {label:'Id',fieldName:'Id'}]

    const columnOpp = [{label:'Name',fieldName:'Name'},          // define columns to diaplay value
    {label:'StageName',fieldName:'StageName'}]

export default class AccountRelatedListByWire extends LightningElement {
    @api recordId;                          // get the Id of the current record from record page
    error;
    recordsCon;                             // Empty Array to keep values retrieved by wire
    recordsOpp;                             // Empty Array to keep values retrieved by wire
    @track columnCon = columnCon
    @track columnOpp = columnOpp

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'Contacts',
        fields: ['Contact.Id','Contact.Name']
    })listContactInfo({ error, data }) {
        if (data) {                                           // Data is retrieved in object form
            console.log( 'Data is', JSON.stringify( data ) );
            let tempRecords = [];                             // Empty variable in array form to store list of records retrieved

            data.records.forEach( obj => {                    // Iterate over the RelatedList of records retrieved

                console.log( 'obj is', JSON.stringify( obj ) );
                let tempRecord = {};                           //Empty variable to which record field's value are added
                tempRecord.Id = obj.fields.Id.value;
                tempRecord.Name = obj.fields.Name.value;
                tempRecords.push( tempRecord );                // push local variable to Array variable global to this method

            } );

            this.recordsCon = tempRecords;                     // Add record values to the Array which will display values in table
            
            console.log( 'Records are ' + JSON.stringify( this.recordsCon ) );
        } else if (error) {
            this.error = error;
            this.recordsCon = undefined;
        }
    }

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'Opportunities',
        fields: ['Opportunity.Name','Opportunity.StageName']
    })listOppInfo({ error, data }) {
        if (data) {                                                 // Data is retrieved in object form
            console.log( 'Data is', JSON.stringify( data ) );
            let tempRecords = [];                                   // Empty variable in array form to store list of records retrieved

            data.records.forEach( obj => {                          // Iterate over the RelatedList of records retrieved

                console.log( 'obj is', JSON.stringify( obj ) );
                let tempRecord = {};                                //Empty variable to which record field's value are added
                tempRecord.Name = obj.fields.Name.value;
                tempRecord.StageName = obj.fields.StageName.value;
                tempRecords.push( tempRecord );                     // push local variable to Array variable global to this method

            } );

            this.recordsOpp = tempRecords;
            
            console.log( 'Records are ' + JSON.stringify( this.recordsCon ) );
        } else if (error) {
            this.error = error;
            this.recordsOpp = undefined;
        }
    }
}


import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import GoogleApi from '@salesforce/resourceUrl/GoogleApi';


export default class GoogleMeet extends LightningElement {
    GoogleApiInitialized = false
    eventName=''
    startTime=''
    endTime=''
    location=''
    Description=''

    renderedCallback() {
        if (this.GoogleApiInitialized) {
            return;
        }
        this.GoogleApiInitialized = true

        Promise.all([
            loadScript(this, GoogleApi),
        ]).then(() => {
            this.GoogleApiinitialize();
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading GoogleApi',
                    message: error.message,
                    variant: 'error'
                })
            );
        });
    }
}
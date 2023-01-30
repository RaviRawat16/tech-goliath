import { LightningElement, api , track, wire} from 'lwc';
import googleMeet from '@salesforce/apex/GoogleCalendarMeet.googleMeet'

export default class GoogleCalendarMeet extends LightningElement {

    @api recordId
    @track StartTime = ' '
    @track EndTime = ' '
    @track ST 
    @track ET 

    startingTime(event) {
        this.StartTime = event.detail.value;
    }

    endingTime(event) {
        this.EndTime = event.detail.value;
    }

    handleClick(){
        
        this.ST = this.StartTime
        this.ET = this.EndTime
    }

    @ wire(googleMeet , {recordId : '$recordId', startTime: '$ST', endTime: '$ET'})
    wiredResult({data, error}){
        if(data){
            console.log(data)
        }
        if(error){
            console.log(error)
        }
    }


    
}
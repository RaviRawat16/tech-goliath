import { LightningElement } from 'lwc';


export default class HelloChamp extends LightningElement {
    DisplayMessage
    eventSuccessful(){
        this.DisplayMessage="Hello Champ!"
    }
}
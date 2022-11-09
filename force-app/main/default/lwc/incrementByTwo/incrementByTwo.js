import { LightningElement } from 'lwc';

export default class IncrementByTwo extends LightningElement {
    Counter = "0"
    handleClick(){       
            this.Counter=Number(this.Counter)+2
            console.log(type(this.Counter))          
    }
    
}
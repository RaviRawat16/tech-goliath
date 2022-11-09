import { LightningElement, api } from 'lwc';

export default class DivideInputs extends LightningElement {

    @api InputSeven
    @api InputEight
    @api Result4=0

    @api divideClick(){
        this.Result4 = Number(this.InputSeven) / Number(this.InputEight)
    }
}
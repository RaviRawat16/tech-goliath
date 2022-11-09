import { LightningElement,track,api } from 'lwc';

export default class AddInputs extends LightningElement {

    @api InputOne
    @api InputTwo
    @api Result1=0

    @api addClick(){
        this.Result1 = Number(this.InputOne) + Number(this.InputTwo)
    }
    
}
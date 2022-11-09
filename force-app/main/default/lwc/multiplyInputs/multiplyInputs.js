import { LightningElement ,api} from 'lwc';

export default class MultiplyInputs extends LightningElement {

    @api InputFive
    @api InputSix
    @api Result3=0

    
    @api multiplyClick(){
        this.Result3 = Number(this.InputFive) * Number(this.InputSix)
    }
    
}
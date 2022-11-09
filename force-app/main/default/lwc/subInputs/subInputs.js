import { LightningElement ,api} from 'lwc';

export default class SubInputs extends LightningElement {

    @api InputThree
    @api InputFour
    @api Result2=0
    
    @api subClick(){
        this.Result2 = Number(this.InputThree) - Number(this.InputFour)
    }
    
}
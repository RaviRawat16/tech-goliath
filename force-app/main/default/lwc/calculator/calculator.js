import { LightningElement ,api} from 'lwc';

export default class Calculator extends LightningElement {
    Input1=0
    Input2=0
    Input3=0
    Input4=0
    Input5=0
    Input6=0
    Input7=0
    Input8=0
    FirstValue(event){        
        this.Input1 = event.detail.value
    }

     SecondValue(event){
        this.Input2 = event.detail.value
    }
    
    ThirdValue(event){
        this.Input3 = event.detail.value
    }

    FourthValue(event){
        this.Input4 = event.detail.value
    }

    FifthValue(event){
        this.Input5 = event.detail.value
    }

    SixthValue(event){
        this.Input6 = event.detail.value
    }

    SevenValue(event){
        this.Input7 = event.detail.value
    }

    EightValue(event){
        this.Input8 = event.detail.value
    }

    Click1(){
        console.log(this.Input1)
        this.template.querySelector("c-add-inputs").addClick()
    }
    Click2(){
        this.template.querySelector("c-sub-inputs").subClick()
    }
    Click3(){
        this.template.querySelector("c-multiply-inputs").multiplyClick()
    }
    Click4(){
        this.template.querySelector("c-divide-inputs").divideClick()
    }
}
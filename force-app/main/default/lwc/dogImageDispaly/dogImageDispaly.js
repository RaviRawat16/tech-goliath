import { LightningElement, wire } from "lwc";
import Kennel from "@salesforce/apex/DogImageLwc.Kennel";


export default class dogImageDispaly extends LightningElement {

    imageURL;
    handleClick(){
        Kennel()
        .then((data)=>{
            this.imageURL=data
        })
    }
    
}
    
    
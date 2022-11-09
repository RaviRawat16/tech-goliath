import { LightningElement } from 'lwc';

export default class SayHello extends LightningElement {
testWords = false;
  Messages= "Hello from Account";
  changeHandler(event) {
    this.testWords = true;
}
}
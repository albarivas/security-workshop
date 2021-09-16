import { LightningElement } from "lwc";
export default class ReflectedXss extends LightningElement {
  handleInputChange(event) {
    eval(event.detail.value);
  }
}

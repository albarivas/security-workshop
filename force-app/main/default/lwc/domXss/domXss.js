import { LightningElement } from "lwc";
export default class DomXss extends LightningElement {
  handleInputChange(event) {
    eval(event.detail.value);
  }
}

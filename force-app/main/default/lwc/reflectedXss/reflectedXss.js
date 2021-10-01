import { LightningElement } from "lwc";
import getStringXSS from "@salesforce/apex/ContactController.getStringXSS";

export default class ReflectedXss extends LightningElement {
  handleInputChange(event) {
    getStringXSS(event.detail.value)
      .then((data) => {
        eval(data);
      })
      .catch((error) => {
        console.error(error);
      });
  }
}

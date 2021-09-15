import { LightningElement } from "lwc";
import getContactXSS from "@salesforce/apex/ContactController.getContactXSS";

export default class StoredXss extends LightningElement {
  handleButtonClick() {
    getContactXSS()
      .then((data) => {
        eval(data.Title);
      })
      .catch((error) => {
        console.error(error);
      });
  }
}

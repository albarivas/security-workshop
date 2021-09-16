import { LightningElement } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import createAccount from "@salesforce/apex/AccountController.createAccount";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class Csrf extends LightningElement {
  connectedCallback() {
    // TODO: move out from here!
    createAccount()
      .then((data) => {
        const toastEvent = new ShowToastEvent({
          title: "Account created",
          message: "Record ID: " + data.Id,
          variant: "success"
        });
        this.dispatchEvent(toastEvent);
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error creating account",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }

  createAccount() {
    // Move here the code that invokes the createAccount Apex method
  }
}

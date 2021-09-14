import { LightningElement, wire } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import createAccount from "@salesforce/apex/AccountController.createAccountStripInaccessible";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateStripInaccessible extends LightningElement {
  handleButtonClick() {
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
}

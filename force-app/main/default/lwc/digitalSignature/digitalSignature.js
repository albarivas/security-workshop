import { LightningElement } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import originDigitalSign from "@salesforce/apex/Encryption.originDigitalSignature";
import destinationDigitalSign from "@salesforce/apex/Encryption.destinationDigitalSignature";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class DigitalSignature extends LightningElement {
  originDigitalSignature;
  correct;

  handleOriginButtonClick() {
    originDigitalSign()
      .then((data) => {
        this.originDigitalSignature = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error generating origin digital signature",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }

  handleDestinationButtonClick() {
    destinationDigitalSign()
      .then((data) => {
        this.correct = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error generating destination digital signature",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }
}

import { LightningElement } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import originHashSHA512 from "@salesforce/apex/Encryption.originHashSHA512";
import destinationHashSHA512 from "@salesforce/apex/Encryption.destinationHashSHA512";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class Hash extends LightningElement {
  originHash;
  destinationHash;

  handleOriginButtonClick() {
    originHashSHA512()
      .then((data) => {
        this.originHash = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error generating hash in origin",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }

  handleDestinationButtonClick() {
    destinationHashSHA512()
      .then((data) => {
        this.destinationHash = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error generating hash in destination",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }
}

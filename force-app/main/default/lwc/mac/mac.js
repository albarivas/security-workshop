import { LightningElement } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import originMacHMAC512 from "@salesforce/apex/Encryption.originMacHMAC512";
import destinationMacHMAC512 from "@salesforce/apex/Encryption.destinationMacHMAC512";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class Mac extends LightningElement {
  originMac;
  destinationMac;

  handleOriginButtonClick() {
    originMacHMAC512()
      .then((data) => {
        this.originMac = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error generating origin mac",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }

  handleDestinationButtonClick() {
    destinationMacHMAC512()
      .then((data) => {
        this.destinationMac = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error generating destination mac",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }
}

import { LightningElement } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import encryptAES256 from "@salesforce/apex/Encryption.encryptAES256";
import decryptAES256 from "@salesforce/apex/Encryption.decryptAES256";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class Encryption extends LightningElement {
  encryptedValue;
  decryptedValue;

  handleEncryptButtonClick() {
    encryptAES256()
      .then((data) => {
        this.encryptedValue = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error encrypting data",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }
  handleDecryptButtonClick() {
    decryptAES256()
      .then((data) => {
        this.decryptedValue = data;
      })
      .catch((error) => {
        const toastEvent = new ShowToastEvent({
          title: "Error decrypting data",
          message: "Error: " + reduceErrors(error).join(","),
          variant: "error"
        });
        this.dispatchEvent(toastEvent);
      });
  }
}

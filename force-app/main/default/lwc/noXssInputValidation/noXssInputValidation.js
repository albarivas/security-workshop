import { LightningElement } from "lwc";
export default class NoXssInputValidation extends LightningElement {
  handleInputChange(event) {
    let input = event.detail.value;
    if (input.includes("alert(")) {
      console.log("Error: unsupported input");
    } else {
      eval(input);
    }
  }
}

import { LightningElement } from "lwc";
export default class NoXssBlocklisting extends LightningElement {
  handleInputChange(event) {
    let input = event.detail.value;
    if (input.includes("alert(")) {
      console.log("Error: unsupported input");
    } else {
      eval(input);
    }
  }
}

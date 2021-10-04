import { LightningElement } from "lwc";

export default class Exercise2 extends LightningElement {
  numbers;
  summary;

  handleInputChange(event) {
    this.numbers = event.detail.value;
    const expr = "[" + this.numbers + "]";
    const array = eval(expr);

    let summary = "These are the numbers: ";
    array.forEach((number) => {
      summary += number + " ";
    });

    this.summary = summary;
  }

  /**
   * Provide a solution that fixes the problem!
   */
  /* handleInputChangeNoXSS(event) {

  }*/
}

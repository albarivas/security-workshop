import { LightningElement } from "lwc";
export default class NoXssAllowlisting extends LightningElement {
    color;
    allowedColors = ["red", "blue", "green"];

    handleInputChange(event) {
        this.color = event.detail.value;
        if (this.allowedColors.includes(this.color)) {
        this.template.querySelector(
            "div.paint"
        ).style.backgroundColor = this.color;
        // This example wouldn't be a problem in LWC as we prevent this usage of eval
        // eval(`this.template.querySelector('div.paint').style.backgroundColor = ${this.color};`);
        }
    }
}

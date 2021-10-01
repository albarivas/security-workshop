import { wire, LightningElement } from "lwc";
import { CurrentPageReference } from "lightning/navigation";

export default class DomXss2 extends LightningElement {
  @wire(CurrentPageReference)
  getStateParameters(currentPageReference) {
    if (currentPageReference) {
      const myParam = currentPageReference.state.c__myParam;
      if (myParam) {
        eval(myParam);
      }
    }
  }

  get navigateToUrl() {
    return `${window.location.href}?c__myParam=alert('Malicious!')`;
  }
}

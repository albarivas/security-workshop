import { wire, LightningElement } from "lwc";
import { CurrentPageReference } from "lightning/navigation";

export default class NoXssOutputEncoding extends LightningElement {
  @wire(CurrentPageReference)
  getStateParameters(currentPageReference) {
    if (currentPageReference) {
      let myParam2 = currentPageReference.state.c__myParam2;

      if (myParam2) {
        myParam2 = myParam2.replace(/\(/g, "%28").replace(/\)/g, "%29");
        eval(myParam2);
      }
    }
  }

  get navigateToUrl() {
    return `${window.location.href}?c__myParam2=alert('Malicious!')`;
  }
}

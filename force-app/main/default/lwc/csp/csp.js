import { LightningElement } from "lwc";

export default class Csp extends LightningElement {
  test = 'javascript:alert("malicious")';
}

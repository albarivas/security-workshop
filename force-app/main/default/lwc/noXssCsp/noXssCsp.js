import { LightningElement } from "lwc";

export default class NoXssCsp extends LightningElement {
  test = 'javascript:alert("malicious")';
}

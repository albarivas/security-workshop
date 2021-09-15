import { LightningElement, wire } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import getFilteredLeadsInjection from "@salesforce/apex/Exercise1.getFilteredLeadsInjection";

const COLUMNS = [
  { label: "Lead Name", fieldName: NAME_FIELD.fieldApiName, type: "text" },
  { label: "Rating", fieldName: RATING_FIELD.fieldApiName, type: "text" }
];

export default class Exercise1 extends LightningElement {
  columns = COLUMNS;
  searchValue = "";

  @wire(getFilteredLeadsInjection, { searchValue: "$searchValue" })
  leads;

  get errors() {
    return this.leads.error ? reduceErrors(this.leads.error) : [];
  }

  handleInputChange(event) {
    this.searchValue = event.target.value;
  }
}

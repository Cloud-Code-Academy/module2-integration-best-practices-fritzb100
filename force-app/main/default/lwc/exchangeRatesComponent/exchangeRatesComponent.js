import { LightningElement } from 'lwc';
import ExchangeRateController from '@salesforce/apex/ExchangeRateController.getExchangeRates';

const columns = [
    { label: 'Base Currency', fieldName: 'Base_Currency__c' },
    { label: 'Target Currency', fieldName: 'Target_Currency__c'},
    { label: 'Rate', fieldName: 'Rate__c'},
    { label: 'Last Updated', fieldName: 'Last_Updated__c'}
];

export default class ExchangeRate extends LightningElement {

    // TODO: Add a property to hold the data
    // data = [];
    // columns = columns;

    // connectedCallback() {
    //     this.data = data;
    // }
}

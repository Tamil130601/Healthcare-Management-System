import { LightningElement } from 'lwc';
import searchPatients from '@salesforce/apex/patientSearchController.searchPatients';

export default class PatientSearch extends LightningElement {
    searchKey =' ';
    patients = [];
    noRecords = false;

    columns = [ { label: 'Patient Name', fieldName: 'patientName' },
             { label: 'Doctor Name', fieldName: 'doctorName' },
              { label: 'Appointment Date', fieldName: 'appointmentDate' }, 
              { label: 'Status', fieldName: 'status' } ];
    
    handleSearchKeyChange(event){
        this.searchKey = event.target.value;
    }
    handleSearch(){
        this.noRecords = false;
        if(!this.searchKey || this.searchKey.trim() === ''){
            this.patients = [];
            this.noRecords = true;
            return;
        }
    searchPatients({
         searchKey: this.searchKey
    })
    .then(result => {
        this.patients = result.map(record => {
            return{
                Id: record.Id,
                patientName: record.Patient_Name__r ? record.Patient_Name__r.Patient_Name__c : '' ,
                doctorName: record.Doctor_Name__r ? record.Doctor_Name__r.Doctor_Name__c : '',
                appointmentDate: record.Appointment_Date__c,
                
                status: record.Status__c
            };
        });
        this.noRecords = this.patients.length === 0;
    })
    .catch (error =>{
        console.error('Error:' , error);
        this.patients = [];
        this.noRecords = true;
    });
    }
}
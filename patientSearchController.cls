public with sharing class patientSearchController{
    @AuraEnabled (cacheable=true)
    public static List<Appointment__c> searchPatients(String searchKey){
        if(String.isBlank(searchKey)){
            return new List<Appointment__c>();
        }
        String searchValue = '%' + searchKey.trim() + '%';
        return [SELECT Id, Patient_Name__c,Patient_Name__r.Patient_Name__c,Doctor_Name__c, Doctor_Name__r.Doctor_Name__c, Appointment_Date__c, Status__c,Appointment_Time__c
                FROM Appointment__c WHERE Patient_Name__r.Patient_Name__c LIKE :searchValue  OR Patient_Name__r.Mobile__c LIKE :searchValue
                ORDER BY Appointment_Date__c DESC
                LIMIT 20];
    }
}

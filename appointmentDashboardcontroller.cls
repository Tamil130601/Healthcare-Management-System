public with sharing class appointmentDashboardcontroller{
    @AuraEnabled(cacheable=true)
    public static Integer todayAppointments (){
        Integer countToday=[SELECT COUNT() FROM Appointment__c  WHERE Appointment_Date__c = TODAY];
        return countToday;
    }

    @AuraEnabled(cacheable=true)
    public static Integer pendingAppointments (){
        Integer countpending=[SELECT COUNT() FROM Appointment__c WHERE Status__c='pending'];
        return countpending;
    }

    @AuraEnabled(cacheable=true)
    public static Integer totalAppointments(){
        Integer countTotal=[SELECT COUNT() FROM Appointment__c ];
        return countTotal;
    }
}
    
    
    


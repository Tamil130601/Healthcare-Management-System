@RestResource(urlMapping='/mobileAppointment/*')
global with sharing class MobileAppointmentAPI{

global class AppointmentRequest{
    public String patientName;
    public String mobile;
    public String email;
    public String doctorName;
    public String appointmentDate;
    public String appointmentTime;
    public String Reason;
}

global class AppointmentResponse{
        public Boolean success;
        public String Reason;
        public Id patientId;
        public Id appointmentId;

        public AppointmentResponse(
        Boolean success, 
        String Reason, 
        Id patientId,
        Id appointmentId
        ){
        this.success = success;
        this.Reason = Reason;
        this.patientId = patientId;
        this.appointmentId = appointmentId;
        }
}

@HttpPost
global static AppointmentResponse createAppointment(){
    try{
        RestRequest request = RestContext.request;
        String requestBody = request.requestBody.toString();

        AppointmentRequest data = (AppointmentRequest) JSON.deserialize(requestBody, AppointmentRequest.class);

        if(String.isBlank(data.patientName)){
            return new AppointmentResponse(false,'patient name is required',null,null);
        }
        if(String.isBlank(data.mobile)){
            return new AppointmentResponse(false,'mobile number is required',null,null);
        }

        List<Patient__c>existingPatients = [SELECT Id,Patient_Name__c,Email__c,Mobile__c FROM Patient__c WHERE Mobile__c = :data.mobile 
                                            LIMIT 1];
        Patient__c patient;
        if(existingPatients.isEmpty()){
        patient = new Patient__c();
        patient.Patient_Name__c = data.patientName;
        patient.Mobile__c = data.mobile;
        patient.Email__c = data.email;
        insert patient;
        }
        else{
            patient = existingPatients[0];
        }
        Appointment__c appointment = new Appointment__c ();
        appointment.Patient_Name__c = patient.Id;
        appointment.Reason__c = data.Reason;
        appointment.Doctor_Name__c = data.doctorName;

        if(!String.isBlank(data.appointmentDate)){
        appointment.Appointment_Date__c = Date.valueOf(data.appointmentDate);
        }
        if(!String.isBlank(data.appointmentTime)){
List<String> timeParts = data.appointmentTime.split(':');
Integer hour = Integer.valueOf(timeParts[0]);
Integer minute = Integer.valueOf(timeParts[1]);
Integer second = 0;
if(timeParts.size() > 2){
    second = Integer.valueOf(timeParts[2]);
}
appointment.Appointment_Time__c = Time.newInstance(
    hour,
    minute,
    second,
    0
);
}
        insert appointment;

        return new AppointmentResponse(true,'patient and appointment created successfully',patient.Id,appointment.Id);
    }
    catch(Exception e){
        return new AppointmentResponse(false,'Error: ' +e.getMessage(),null,null);
    }
}

}

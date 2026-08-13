import { LightningElement,wire } from 'lwc';
import todayAppointments from '@salesforce/apex/appointmentDashboardcontroller.todayAppointments';
import pendingAppointments from '@salesforce/apex/appointmentDashboardcontroller.pendingAppointments';
import totalAppointments from '@salesforce/apex/appointmentDashboardcontroller.totalAppointments';
export default class AppointmentDashboard extends LightningElement {
   
   todayAppointments;
   pendingAppointments;
   totalAppointments;

   @wire(todayAppointments)
   wiredtodayAppointments({data,error}){
    if(data){
        this.todayAppointments = data;
    }
    else if(error){
        console.error(error);
    }
    }

    @wire(pendingAppointments)
    wiredpendingAppointments({data,error}){
        if(data){
            this.pendingAppointments = data;
               }
            else if(error){
                console.error(error);
            }      
         }
        
     @wire(totalAppointments)
     wiredtotalAppointments({data,error}){
        if(data){
            this.totalAppointments = data;
        }
        else if(error){
            console.error(error);
        }
     }
    }
    

    

   

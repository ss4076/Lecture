package strategy.fcm;

import java.util.LinkedList;
import java.util.List;

public class Push {

    private String to;

    private String priority;

    private Notification notification;

    private List<String> registrationIds = new LinkedList<>();

    public Push(String priority, Notification notification, List<String> registrationds) {

        this.priority = priority;
        this.notification = notification;
        this.registrationIds = registrationds;
    }

    public Push(String to, String priority, Notification notification) {

        this.to = to;
        this.priority = priority;
        this.notification = notification;
    }

    public Push() {

    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public Notification getNotification() {
        return notification;
    }

    public void setNotification(Notification notification) {
        this.notification = notification;
    }

    public List<String> getRegistrationIds() {
        return registrationIds;
    }

    public void setRegistrationIds(List<String> registrationIds) {
        this.registrationIds = registrationIds;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

}
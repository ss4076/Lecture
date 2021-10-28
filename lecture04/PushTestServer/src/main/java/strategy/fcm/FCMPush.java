package strategy.fcm;

import com.google.gson.Gson;
import org.springframework.http.HttpEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.web.client.RestTemplate;
import strategy.dto.Body;
import util.PushDispatcher;
import strategy.dto.FirebaseResponse;
import strategy.dto.Notification;
import strategy.dto.Push;
import util.HeaderRequestInterceptor;

import java.util.ArrayList;

public class FCMPush implements PushDispatcher {

    private String fcmKey = "AAAALATmq94:APA91bGfMC7jhGraZOABhSuHYxPBjZJZTM079IYPSCbJcLEUampCBCvGNISyl8Fl32L6V9E3i-MPJtHtsiUL4bBSziY42CVMXwKewwit4bxhL_IZTIDGXeKjbf6PSAENb4z_ZFW1XeSC";
    private String fcmToken = "eblQS4qd2Eltnu9rudOTb-:APA91bGAr8i83TQXdazWKNG7BL76Av9XluwatMIEhuRdQ51zMJKL88Ccc69vkh9AcsbclQRRCElB-I0QeYPYvFJplFgO2jc6C0vmd0hsHPEXS7C1B53vl767rb0B7dVbGlwaLYJL4Yk6";

    private static final String FCM_API = "https://fcm.googleapis.com/fcm/send";

    public FCMPush() {

    }

    @Override
    public void sendNotification() {
// TODO Auto-generated method stub
        System.out.println("##############################");
        System.out.println("send FCM Notification ...");
        System.out.println("##############################");

        Gson gson = new Gson();

        Notification notification = new Notification("default", "FCM Notification", gson.toJson(new Body("lecture03", "fcmPush")));
        Push push = new Push(fcmToken, "high", notification);

        HttpEntity<Push> request = new HttpEntity<>(push);

        RestTemplate restTemplate = new RestTemplate();

        System.out.println("request: "+gson.toJson(request));
        ArrayList<ClientHttpRequestInterceptor> interceptors = new ArrayList<>();
        interceptors.add(new HeaderRequestInterceptor("Authorization", "key=" + fcmKey));
        interceptors.add(new HeaderRequestInterceptor("Content-Type", "application/json"));
        restTemplate.setInterceptors(interceptors);
//        System.out.println("request: "+gson.toJson(interceptors));
        FirebaseResponse firebaseResponse = restTemplate.postForObject(FCM_API, request, FirebaseResponse.class);
        System.out.println("firebaseResponse: " + firebaseResponse.toString());
    }
}

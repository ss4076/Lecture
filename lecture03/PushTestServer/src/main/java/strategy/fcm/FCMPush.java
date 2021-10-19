package strategy.fcm;

import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.converter.json.GsonBuilderUtils;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.client.RestTemplate;
import strategy.PushDispatcher;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

public class FCMPush implements PushDispatcher {

    private String fcmKey = "AAAALATmq94:APA91bGfMC7jhGraZOABhSuHYxPBjZJZTM079IYPSCbJcLEUampCBCvGNISyl8Fl32L6V9E3i-MPJtHtsiUL4bBSziY42CVMXwKewwit4bxhL_IZTIDGXeKjbf6PSAENb4z_ZFW1XeSC";
    private String fcmToken = "cSRwFGFbGUxPtzj3s-RMaA:APA91bHCSrSprwNsT6fX0fUmoq_Wz5GjWOaUel-Z_IhvpNTDzhpZTUevyN6iTUsp93P08WRItmGcuitq6euG-RnDwVFZl0D8K1JHbIPyC-xddU6EGuDdW3BmcjIiVDkPIe5qHWE6H35_";

    private static final String FCM_API = "https://fcm.googleapis.com/fcm/send";

    public FCMPush() {

    }

    @Override
    public void sendNotification() {
// TODO Auto-generated method stub
        System.out.println("##############################");
        System.out.println("send FCM Notification ...");
        System.out.println("##############################");

        Notification notification = new Notification("default", "My app", "Test!!!");
        Push push = new Push(fcmToken, "high", notification);

        HttpEntity<Push> request = new HttpEntity<>(push);

        RestTemplate restTemplate = new RestTemplate();
        Gson gson = new Gson();
        System.out.println("request: "+gson.toJson(request));
        ArrayList<ClientHttpRequestInterceptor> interceptors = new ArrayList<>();
        interceptors.add(new HeaderRequestInterceptor("Authorization", "key=" + fcmKey));
        interceptors.add(new HeaderRequestInterceptor("Content-Type", "application/json"));
        restTemplate.setInterceptors(interceptors);
        System.out.println("request: "+gson.toJson(interceptors));
        FirebaseResponse firebaseResponse = restTemplate.postForObject(FCM_API, request, FirebaseResponse.class);
        System.out.println("firebaseResponse: " + firebaseResponse.toString());
    }
}

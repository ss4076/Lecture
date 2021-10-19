package strategy.apns;

import com.eatthepath.pushy.apns.ApnsClient;
import com.eatthepath.pushy.apns.ApnsClientBuilder;
import com.eatthepath.pushy.apns.PushNotificationResponse;
import com.eatthepath.pushy.apns.auth.ApnsSigningKey;
import com.eatthepath.pushy.apns.util.ApnsPayloadBuilder;
import com.eatthepath.pushy.apns.util.SimpleApnsPayloadBuilder;
import com.eatthepath.pushy.apns.util.SimpleApnsPushNotification;
import com.eatthepath.pushy.apns.util.TokenUtil;
import com.eatthepath.pushy.apns.util.concurrent.PushNotificationFuture;
import strategy.PushDispatcher;

import java.io.File;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.concurrent.ExecutionException;

public class APNSPush implements PushDispatcher {

    SimpleApnsPushNotification pushNotification = null;

    public APNSPush() {

    }

    public void sendNotification() throws IOException {
        // TODO Auto-generated method stub
        System.out.println("##############################");
        System.out.println("send APNS Notification ...");
        System.out.println("##############################");

//        final ApnsClient apnsClient = new ApnsClientBuilder()
//                .setApnsServer(ApnsClientBuilder.DEVELOPMENT_APNS_HOST)
//                .setClientCredentials(new File("zkp_push_dev.p12"), "qwer1234!@")
//                .build();

        ApnsClient apnsClient = null;
        try {
            apnsClient = new ApnsClientBuilder()
                    .setApnsServer(ApnsClientBuilder.DEVELOPMENT_APNS_HOST)
                    .setSigningKey(ApnsSigningKey.loadFromPkcs8File(new File("AuthKey_98Z3WR4R8D.p8"),
                            "RXBUP6L48V", "98Z3WR4R8D"))
                    .build();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        }

        final ApnsPayloadBuilder payloadBuilder = new SimpleApnsPayloadBuilder();
        payloadBuilder.setAlertBody("Example!");

        final String payload = payloadBuilder.build();
        final String token = TokenUtil.sanitizeTokenString("2adf2a5f8118a8c913f9607428d51d25d2806bdfcad414941a64ff71aa962e1d");

        pushNotification = new SimpleApnsPushNotification(token, "com.raon.sdk.zkp.sample", payload);

        final PushNotificationFuture<SimpleApnsPushNotification, PushNotificationResponse<SimpleApnsPushNotification>>
                sendNotificationFuture = apnsClient.sendNotification(pushNotification);

        try {
            final PushNotificationResponse<SimpleApnsPushNotification> pushNotificationResponse =
                    sendNotificationFuture.get();

            if (pushNotificationResponse.isAccepted()) {
                System.out.println("Push notification accepted by APNs gateway.");
            } else {
                System.out.println("Notification rejected by the APNs gateway: " +
                        pushNotificationResponse.getRejectionReason());

                pushNotificationResponse.getTokenInvalidationTimestamp().ifPresent(timestamp -> {
                    System.out.println("\t…and the token is invalid as of " + timestamp);
                });
            }
        } catch (final ExecutionException | InterruptedException e) {
            System.err.println("Failed to send push notification.");
            e.printStackTrace();
        }
    }

}

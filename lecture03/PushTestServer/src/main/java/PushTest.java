import strategy.apns.APNSPush;
import strategy.PushHandler;
import strategy.fcm.FCMPush;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class PushTest {

    public static void main(String... args) {
        PushHandler pushHandler = PushHandler.getInstance();
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String line;
        try {

            while((line =br.readLine()) != null) {
                if(line.indexOf("exit") != -1) {
                    pushHandler.closePool();
                    System.exit(0);
                }

				if(line.indexOf("1") != -1) {
                    pushHandler.setPushDispatcher(new APNSPush());
                    pushHandler.performSendPush();
				}
				if(line.indexOf("2") != -1) {
					pushHandler.setPushDispatcher(new FCMPush());
					pushHandler.performSendPush();
				}
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block1
            e.printStackTrace();
        }
    }

}

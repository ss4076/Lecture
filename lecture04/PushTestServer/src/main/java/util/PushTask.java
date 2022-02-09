package util;

import java.io.IOException;

public class PushTask implements Runnable {
    public void run() {
        try {
            PushHandler.getInstance().getPushDispatcher().sendNotification();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

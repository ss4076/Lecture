package strategy;

import util.AleadyClosedException;
import util.ThreadPool;

public class PushHandler {
    private ThreadPool pool = null;
    private PushDispatcher pushDispatcher = null;

    private static PushHandler pushHandler;

    public static PushHandler getInstance() {
        if (pushHandler == null) {
            pushHandler = new PushHandler();
        }
        return pushHandler;
    }

    public PushHandler() {
        if (pool == null) {
            System.out.println("strategy.PushHandler()...");
            pool = new ThreadPool(1, 20, 1, 1);
        }
    }

    public PushDispatcher getPushDispatcher() {
        return this.pushDispatcher;
    }

    public void setPushDispatcher(PushDispatcher pushDispatcher) {
        this.pushDispatcher = pushDispatcher;
    }

    public void performSendPush() {
        try {
            pool.execute(new PushTask());
            try {
                Thread.currentThread();
                Thread.sleep(200);
            } catch (Exception ex) {
            }

//			pool.close();
        } catch (AleadyClosedException ex) {
            ex.printStackTrace();
        }
    }

    public void closePool() {
        try {
            pool.close();
        } catch (AleadyClosedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

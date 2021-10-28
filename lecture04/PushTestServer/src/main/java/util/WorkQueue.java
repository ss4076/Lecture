package util;

import java.util.LinkedList;


public class WorkQueue {
    private LinkedList  workList = new LinkedList();
    private boolean closed  = false;

    public synchronized void enQueue(Runnable work)
            throws AleadyClosedException {
        if (closed ) {
            throw new AleadyClosedException();
        }
        workList.addLast(work);
        notify();
    }

    public synchronized Runnable deQueue()
            throws AleadyClosedException, InterruptedException {
        while (workList.size() <= 0) {
            wait();
            if (closed ) {
                throw new AleadyClosedException();
            }
        }
        return (Runnable) workList.removeFirst();
    }

    public synchronized int size() {
        return workList.size();
    }

    public synchronized boolean isEmpty() {
        return workList.size() == 0;
    }

    public synchronized void close() {
        closed = true;
        notifyAll();
    }
}

package util;

public class AleadyClosedException extends Exception {
    public AleadyClosedException(String msg) {
        super(msg);
    }
    public AleadyClosedException() {
        super();
    }
}

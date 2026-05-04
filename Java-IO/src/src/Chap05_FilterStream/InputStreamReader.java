package Chap05_FilterStream;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.Reader;

public class InputStreamReader {
    public static void main(String[] args) throws Exception {
        InputStream is = System.in;
        Reader reader = new java.io.InputStreamReader(is);

        int readCharNo;
        char[] cbuf = new char[100];
        while ((readCharNo = reader.read(cbuf)) != -1) {
            String data = new String(cbuf, 0, readCharNo);
            System.out.println(data);
        }
        reader.close();
    }
}

package Chap05_FilterStream;

import java.io.*;
import java.io.InputStreamReader;

public class ButteredReaderEx {
    public static void main(String[] args) throws Exception {
        InputStream is = System.in;
        Reader reader = new InputStreamReader(is);
        BufferedReader br = new BufferedReader(reader);

        System.out.println("입력: ");
        String lineString = br.readLine();
        System.out.println("출력: " + lineString);
    }
}

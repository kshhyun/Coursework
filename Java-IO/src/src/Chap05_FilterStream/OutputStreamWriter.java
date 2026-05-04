package Chap05_FilterStream;

import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.Reader;
import java.io.Writer;

public class OutputStreamWriter {
    public static void main(String[] args) throws Exception {
        FileOutputStream fos = new FileOutputStream("test.txt");
        Writer writer = new java.io.OutputStreamWriter(fos);

        String data = "바이트 출력 스트림을 문자 출력 스트림으로 변환\n";
        writer.write(data);

        writer.flush();
        writer.close();
        System.out.println("파일 저장 완료");
    }
}

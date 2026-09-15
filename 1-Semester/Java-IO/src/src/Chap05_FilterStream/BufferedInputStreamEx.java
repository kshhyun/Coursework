package Chap05_FilterStream;

import java.io.BufferedInputStream;
import java.io.FileInputStream;

public class BufferedInputStreamEx {
    public static void main(String[] args) throws Exception {
        long start = 0;
        long end = 0;

        //기본 기준점(Working Directory)은 항상 프로젝트의 최상위 폴더인 Java-IO
        //따라서 /Users/hyun/.../Java-IO/까지는 다 생략 가능
        FileInputStream fis1 = new FileInputStream("src/forest.jpg");
        start = System.currentTimeMillis();
        while(fis1.read()!=-1){}
        end = System.currentTimeMillis();
        System.out.println("사용하지 않았을 때: " + (end-start) + "ms");
        fis1.close();

        FileInputStream fis2 = new FileInputStream("src/forest.jpg");
        BufferedInputStream bis = new BufferedInputStream(fis2);
        start = System.currentTimeMillis();
        while (bis.read() != -1) {}
        end = System.currentTimeMillis();
        System.out.println("사용했을 때: " + (end-start) + "ms");
        bis.close();
        fis2.close();
    }
}

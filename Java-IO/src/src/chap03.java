import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStream;
import java.io.Reader;

public class chap03 {
    public static void main(String[] args) throws Exception {
        // 1. Reader 객체 생성 (텍스트 파일을 읽기 위한 스트림)
        Reader reader = new FileReader("test.txt");

        int readCharNo;            // 실제로 읽어온 문자의 개수를 저장
        char[] cbuf = new char[4]; // 4칸짜리 문자 배열 생성 (초기값은 공백문자)

        /* * 2. 특정 위치에 데이터 읽기 (핵심)
         * cbuf 배열의 1번 인덱스부터 시작해서(off: 1),
         * 최대 2글자까지만(len: 2) 읽어서 저장합니다.
         * 읽어온 실제 문자 수는 readCharNo에 저장됩니다.
         */
        readCharNo = reader.read(cbuf, 1, 2);

        // 3. 배열 내용 출력 (문법 오류 수정: i를 for문 안에서 사용)
        for(int i=0; i<cbuf.length; i++) {
            System.out.println("cbuf[" + i + "]: " + cbuf[i]);
        }

        // 4. 스트림 닫기
        reader.close();
    }
}

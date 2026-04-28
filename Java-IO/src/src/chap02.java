import java.io.FileInputStream;
import java.io.InputStream;

public class chap02 {
    public static void main(String[] args) throws Exception {
        InputStream is = new FileInputStream("test.txt");
        byte[] buffer = new byte[100]; // 100바이트씩 담을 바구니(배열) 준비

        while (true) {
            int num = is.read(buffer); // 최대 100바이트를 읽고 읽은 개수를 리턴
            if (num == -1) break; // 파일 끝에 도달하면 종료

            // 읽은 개수(num)만큼만 반복하여 출력
            for(int i=0; i<num; i++) {
                System.out.print((char)buffer[i]);
            }
        }
        is.close();
    }
}

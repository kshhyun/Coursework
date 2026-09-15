import java.io.FileInputStream; // 파일로부터 바이트 단위로 읽어오기 위한 클래스
import java.io.InputStream;     // 모든 바이트 기반 입력 스트림의 최상위 클래스

public class chap01 {
    public static void main(String[] args) throws Exception {
        // 1. 입력 스트림 객체 생성 -> "test.txt" 파일을 읽기 위한 통로(Stream) 생성
        InputStream is = new FileInputStream("test.txt");

        // 2. 데이터를 담을 변수 선언 -> read() 메소드는 읽은 바이트를 int 타입으로 리턴
        int readByte;

        // 3. 반복해서 데이터 읽기
        while (true) {
            readByte = is.read(); // 1바이트씩 읽어옴 (더 이상 읽을 게 없으면 -1 리턴)

            if (readByte == -1) { // 파일의 끝(End of File)에 도달했는지 확인
                break;            // 반복문 탈출
            }

            // 4. 읽은 바이트를 문자로 변환하여 출력
            // readByte에는 아스키(ASCII) 코드값이 들어있으므로 (char)로 형변환이 필요
            System.out.print((char) readByte);
        }
        // 스트림 닫기 (매우 중요!)
        // 사용한 시스템 자원(파일 핸들 등)을 컴퓨터에 반납
        is.close();
    }
}
package Chap05_FilterStream;

import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

public class SerialVersionUID15 {
    public static void main(String[] args) throws Exception {
        FileOutputStream fos = new FileOutputStream("src/Object.dat");
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        ClassC classC = new ClassC();
        classC.field1 = 1;
        oos.writeObject(classC);
        oos.flush();
        oos.close();
        fos.close();
    }
}

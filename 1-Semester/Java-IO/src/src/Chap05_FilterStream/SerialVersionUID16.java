package Chap05_FilterStream;

import java.io.FileInputStream;
import java.io.ObjectInputStream;

public class SerialVersionUID16 {
    public static void main(String[] args) throws Exception{
        FileInputStream fis = new FileInputStream("src/Object.dat");
        ObjectInputStream ois = new ObjectInputStream(fis);
        ClassC classC = (ClassC) ois.readObject();
        System.out.println("field1" + classC.field1);
    }
}

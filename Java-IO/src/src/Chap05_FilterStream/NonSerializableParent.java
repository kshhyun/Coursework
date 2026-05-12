package Chap05_FilterStream;

import java.io.*;

public class NonSerializableParent {
    public static void main(String[] args) throws Exception {
        FileOutputStream fos = new FileOutputStream("src/Object.dat");
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        Child child = new Child();
        child.field1 = "홍길동";
        child.field2 = "홍삼원";
        oos.writeObject(child);
        oos.flush(); oos.close(); fos.close();

        FileInputStream fis = new FileInputStream("src/Object.dat");
        ObjectInputStream ois = new ObjectInputStream(fis);
        Child v =  (Child) ois.readObject();
        System.out.println("field1: " + v.field1);
        System.out.println("field2: " + v.field2);
        ois.close(); fis.close();
    }
}

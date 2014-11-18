import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
 

public class BrainWriter{
  private String place = "C:\\Users\\Justin\\Documents\\Arduino\\Experimental\\session1";
  private File file;
  public BrainWriter() {
    file = new File(place);
    try {
      if(!file.exists()){
       file.createNewFile();
     }
  } catch (IOException e) {
    System.err.println("Setup for BrainWriter failed");
    e.printStackTrace();
  }
    System.out.println("BrainWriter ready");
  }
  public void write(String data){
    try{
      FileWriter fw = new FileWriter(file.getAbsolutePath(),true);
      BufferedWriter bw = new BufferedWriter(fw);
      bw.write(data);
      bw.flush();
      bw.close();
    }catch(IOException e){
      e.printStackTrace();
      System.err.println("Write to file failed");
    }
    System.out.println("BrainWriter: Write successfull!");
  }
}

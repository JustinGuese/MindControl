import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.util.ArrayList;

import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;


public class MindControl {
  private JFrame frame;
  private JPanel top;
  private JPanel bottom;
  private JPanel panel;
  private JLabel [] texts;
  
  private ArrayList<int[]> data;
  private double [] average;
  private double [] var;
  
  public MindControl(){
    init();
  }
  private void init(){
    frame = new JFrame();
    frame.setTitle("MindControl by Justin Guese");
    frame.setSize(800, 600);
    panel = new JPanel();
    top = new JPanel();
    bottom = new JPanel();
    texts = new JLabel[11];
    for (int i = 0; i < texts.length; i++)
      texts[i]= new JLabel("No Data");
    frame.add(panel);
    panel.setLayout(new BorderLayout());
    panel.add(top,BorderLayout.NORTH);
    panel.add(bottom,BorderLayout.CENTER);
    bottom.setLayout(new BoxLayout(bottom, 1));
    frame.setDefaultLookAndFeelDecorated(true);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setVisible(true);
    for(int i = 0; i < texts.length; i++){
      bottom.add(texts[i]);
    }
    data = new ArrayList();
    average = new double[11];
    var = new double[11];
  }
  /*
  public static void main(String [] argv){
    MindControl mc = new MindControl();
    mc.update("1,2,3,4,5,6,7,8,9,10,11");
  }
  */
  public void update(String str){
    String [] a= str.split(",");
    int [] array = new int [11];
    for(int i = 0; i < array.length;i++){
      array[i]=Integer.parseInt(a[i]);
    }
    data.add(array);
    makeData();
  }
  private void makeData(){
    int[] sumArray = new int[11];
    for(int i = 0; i < data.size();i++){
      int [] temp = data.get(i);
      for(int j = 0; j < temp.length; j++){
        sumArray[j]+=temp[j];
      }
    }// Now make average 
    for(int i = 0; i < sumArray.length;i++){
      average[i] = sumArray[i]/sumArray.length;
    }// now we have the average value
    int [] sumArray2 = new int[11];
    for(int i = 0; i < data.size();i++){
      int [] temp = data.get(i);
      for(int j = 0; j < temp.length; j++){
        sumArray2[j]+=(temp[j]-average[j])*(temp[j]-average[j]);
      }
    }// now we have the top of variance
    for(int j = 0; j < var.length; j++){
      var[j]=sumArray2[j]/(var.length-1);
    }// varianz fertig
    drawData();
  }
  private void drawData(){
    texts[0].setText("Signal Strength: "+average[0]);
    texts[1].setText("Attention:       "+average[1]);
    texts[2].setText("Meditation:      "+average[2]);
    texts[3].setText("Delta:          "+average[3]);
    texts[4].setText("Theta:           "+average[4]);
    texts[5].setText("Low Alpha:       "+average[5]);
    texts[6].setText("High Alpha:      "+average[6]);
    texts[7].setText("Low Beta:        "+average[7]);
    texts[8].setText("High Beta:       "+average[8]);
    texts[9].setText("Low Gamma:       "+average[9]);
    texts[10].setText("High Gamma:      "+average[10]);

  }
}


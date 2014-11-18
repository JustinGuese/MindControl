import java.awt.BorderLayout;
import java.text.DecimalFormat;
import java.text.NumberFormat;

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
  
  private long [] waves_average;
  private long [] waves_current;
  private long [] waves_variance;
  private long [] waves_count;
  private long [] waves_max;
  private double [] waves_current_percentage;
  

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
    texts = new JLabel[12];
    for (int i = 0; i < texts.length; i++)
      texts[i]= new JLabel();
    frame.add(panel);
    panel.setLayout(new BorderLayout());
    panel.add(top,BorderLayout.NORTH);
    panel.add(bottom,BorderLayout.CENTER);
    bottom.setLayout(new BoxLayout(bottom, 1));
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setVisible(true);
    for(int i = 0; i < texts.length; i++){
      bottom.add(texts[i]);
    }
    // set all brain waves by default to zero
    waves_average = new long [11];
    waves_current = new long [11];
    waves_variance = new long [11];
    waves_count = new long [11];
    waves_max = new long [11];
    waves_current_percentage = new double [11];
    //first draw of text
    drawData();
  }
  

  public void update(int pos, int val){
    waves_current[pos]=val;
    waves_count[pos]++;
    waves_average[pos] += val;
    waves_average[pos] /= 2;
    waves_variance[pos] += (val-waves_average[pos])*(val-waves_average[pos]);
    waves_variance[pos] /= 2;
    //set the maximum 
    if(val > waves_max[pos]) waves_max[pos] = val;
    //now calculate the percentage of current
    waves_current_percentage[pos]=(val/(double)(waves_max[pos]/100));
    if(pos == 10)drawData();
  }
  private void drawData(){
  NumberFormat nf = NumberFormat.getNumberInstance();
    nf.setMaximumFractionDigits(2);
    texts[0].setText("Signal Strength: "+nf.format(waves_current_percentage[0])+"% "+waves_current[0]+" Average: "+waves_average[0]+" Variance: "+waves_variance[0]);
    texts[1].setText("Attention:       "+nf.format(waves_current_percentage[1])+"% "+waves_current[1]+" Average: "+waves_average[1]+" Variance: "+waves_variance[1]);
    texts[2].setText("Meditation:      "+nf.format(waves_current_percentage[2])+"% "+waves_current[2]+" Average: "+waves_average[2]+" Variance: "+waves_variance[2]);
    texts[3].setText("Delta:          "+nf.format(waves_current_percentage[3])+"% "+waves_current[3]+" Average: "+waves_average[3]+" Variance: "+waves_variance[3]);
    texts[4].setText("Theta:           "+nf.format(waves_current_percentage[4])+"% "+waves_current[4]+" Average: "+waves_average[4]+" Variance: "+waves_variance[4]);
    texts[5].setText("Low Alpha:       "+nf.format(waves_current_percentage[5])+"% "+waves_current[5]+" Average: "+waves_average[5]+" Variance: "+waves_variance[5]);
    texts[6].setText("High Alpha:      "+nf.format(waves_current_percentage[6])+"% "+waves_current[6]+" Average: "+waves_average[6]+" Variance: "+waves_variance[6]);
    texts[7].setText("Low Beta:        "+nf.format(waves_current_percentage[7])+"% "+waves_current[7]+" Average: "+waves_average[7]+" Variance: "+waves_variance[7]);
    texts[8].setText("High Beta:       "+nf.format(waves_current_percentage[8])+"% "+waves_current[8]+" Average: "+waves_average[8]+" Variance: "+waves_variance[8]);
    texts[9].setText("Low Gamma:       "+nf.format(waves_current_percentage[9])+"% "+waves_current[9]+" Average: "+waves_average[9]+" Variance: "+waves_variance[9]);
    texts[10].setText("High Gamma:      "+nf.format(waves_current_percentage[10])+"% "+waves_current[10]+" Average: "+waves_average[10]+" Variance: "+waves_variance[10]);
    texts[11].setText("Count: "+waves_count[0]);
  }
}


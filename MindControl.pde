import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridLayout;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;


public class MindControl {
  private double BORDER = 20;  
  
  private JFrame frame;
  private JPanel top;
  private JPanel bottom;
  private JPanel panel;
  private JLabel [] texts;
  private JButton [] buttons;
  private JSlider slider;
  
  private long [] waves_average;
  private long [] waves_current;
  private double [] waves_variance;
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
    buttons = new JButton[15];
    for (int i = 0; i < texts.length; i++)
      texts[i]= new JLabel();
    frame.add(panel);
    panel.setLayout(new BorderLayout());
    panel.add(top,BorderLayout.NORTH);
    panel.add(bottom,BorderLayout.CENTER);
    top.setLayout(new BoxLayout(top, 1));
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setVisible(true);
    for(int i = 0; i < texts.length; i++){
      top.add(texts[i]);
    }
    bottom.setLayout(new GridLayout(2,6));
    buttons[0] = new JButton("Signal");
    buttons[1] = new JButton("Attention");
    buttons[2] = new JButton("Meditation");
    buttons[3] = new JButton("Delta");
    buttons[4] = new JButton("Theta");
    buttons[5] = new JButton("Low Alpha");
    buttons[6] = new JButton("High Alpha");
    buttons[7] = new JButton("Low Beta");
    buttons[8] = new JButton("High Beta");
    buttons[9] = new JButton("Low Gamma");
    buttons[10] = new JButton("High Gamma");
    buttons[11] = new JButton("Sleepy");
    buttons[12] = new JButton("Relaxed");
    buttons[13] = new JButton("Alert");
    buttons[14] = new JButton("Multi Sensory");
    for(int i = 0; i < buttons.length; i++){
      bottom.add(buttons[i],i);
    }
    slider = new JSlider(JSlider.VERTICAL, 0, 100, (int)BORDER);
    slider.setLabelTable(slider.createStandardLabels(10));
    
    
    bottom.add(slider,15);
    // set all brain waves by default to zero
    waves_average = new long [11];
    waves_current = new long [11];
    waves_variance = new double [11];
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
    waves_variance[pos] =  Math.sqrt(waves_variance[pos]);
    //set the maximum 
    if(val > waves_max[pos]) waves_max[pos] = val;
    //now calculate the percentage of current
    waves_current_percentage[pos]=(val/(double)(waves_max[pos]/100));
    if(pos == 10){
      activateButtons();
      drawData();
    }
  }
  private void drawData(){
    texts[0].setText("Signal Strength: "+waves_current_percentage[0]+"% "+waves_current[0]+" Average: "+waves_average[0]+" Variance: "+waves_variance[0]);
    texts[1].setText("Attention:       "+waves_current_percentage[1]+"% "+waves_current[1]+" Average: "+waves_average[1]+" Variance: "+waves_variance[1]);
    texts[2].setText("Meditation:      "+waves_current_percentage[2]+"% "+waves_current[2]+" Average: "+waves_average[2]+" Variance: "+waves_variance[2]);
    texts[3].setText("Delta:          "+waves_current_percentage[3]+"% "+waves_current[3]+" Average: "+waves_average[3]+" Variance: "+waves_variance[3]);
    texts[4].setText("Theta:           "+waves_current_percentage[4]+"% "+waves_current[4]+" Average: "+waves_average[4]+" Variance: "+waves_variance[4]);
    texts[5].setText("Low Alpha:       "+waves_current_percentage[5]+"% "+waves_current[5]+" Average: "+waves_average[5]+" Variance: "+waves_variance[5]);
    texts[6].setText("High Alpha:      "+waves_current_percentage[6]+"% "+waves_current[6]+" Average: "+waves_average[6]+" Variance: "+waves_variance[6]);
    texts[7].setText("Low Beta:        "+waves_current_percentage[7]+"% "+waves_current[7]+" Average: "+waves_average[7]+" Variance: "+waves_variance[7]);
    texts[8].setText("High Beta:       "+waves_current_percentage[8]+"% "+waves_current[8]+" Average: "+waves_average[8]+" Variance: "+waves_variance[8]);
    texts[9].setText("Low Gamma:       "+waves_current_percentage[9]+"% "+waves_current[9]+" Average: "+waves_average[9]+" Variance: "+waves_variance[9]);
    texts[10].setText("High Gamma:      "+waves_current_percentage[10]+"% "+waves_current[10]+" Average: "+waves_average[10]+" Variance: "+waves_variance[10]);
    texts[11].setText("Count: "+waves_count[0]);
  }
  private void activateButtons(){
    BORDER = slider.getValue();
    System.out.println("Border: "+(double)(BORDER/100));
    for(int wave = 0; wave < waves_current.length; wave++){
      if(waves_current[wave] > (waves_average[wave]+((double)(BORDER/100) * waves_average[wave]))){
        // if it is over BORDER
        buttons[wave].setBackground(Color.green);
      }
      else if(waves_current[wave] < (waves_average[wave]-((double)(BORDER/100) * waves_average[wave]))){
        // if it is below BORDER
        buttons[wave].setBackground(Color.red);
      }
      else{
        // if it is in Border
        buttons[wave].setBackground(Color.WHITE);
      }
    }
  }
}


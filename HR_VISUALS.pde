import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer jingle;
FFT fft;
AudioInput in;
float[] angle;
float[] y, x;
int it, grow;
 
void setup()
{
  size(displayWidth, displayHeight, P3D);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  reset();
  frameRate(240);
}

void reset(){
      y = new float[fft.specSize()];
      x = new float[fft.specSize()];
      angle = new float[fft.specSize()];
      grow = 1;
}
 
void draw()
{
  background(0);
  fft.forward(in.mix);
  doubleAtomicSprocket();
}
 
void doubleAtomicSprocket() {
  if (keyPressed) {
    if (key == 'r'){ reset(); }
  }
  
  /*
  if (it < 1000 && grow == 1){ it++; }
  else{
   it--;
   grow = -1;
   if(it == 0){ grow = 1; }
  }    
  System.out.println(it);
  */
  noStroke();
  pushMatrix();
  
  // Inner Circle
  translate(width/2, height/2);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + grow * fft.getBand(i)/85;
    x[i] = x[i] + grow * fft.getFreq(i)/85;
    angle[i] = angle[i] + grow * fft.getFreq(i)/1000;
    rotateX(sin(angle[i]/2));
    rotateY(cos(angle[i]/2));
    stroke(fft.getFreq(i)*2,0,fft.getBand(i)*2);
    fill(fft.getFreq(i)/3, 0, fft.getBand(i)/2);
    pushMatrix();
    translate((x[i]+40)%width/2, (y[i]+40)%height/2);
    box(fft.getBand(i)/5+fft.getFreq(i)/5);
    popMatrix();
  }
  popMatrix();
  pushMatrix();
  
  // Right Circle
  translate(width/2, height/2, 0);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + grow * fft.getBand(i)/1000;
    x[i] = x[i] + grow * fft.getFreq(i)/1000;
    angle[i] = angle[i] + grow * fft.getFreq(i)/10000;
    rotateX(sin(angle[i]));
    //rotateY(cos(angle[i]));
    stroke(fft.getFreq(i),0,fft.getBand(i));
    fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i));
    pushMatrix();
    translate((x[i]+250)%width, (y[i]+250)%height);
    box(fft.getBand(i)/4+fft.getFreq(i)/4);
    popMatrix();
  }
  popMatrix();
  pushMatrix();
  
  // Left
  translate(width/2, height/2, 0);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + grow * fft.getBand(i)/1000;
    x[i] = x[i] + grow * fft.getFreq(i)/1000;
    angle[i] = angle[i] + grow * fft.getFreq(i)/10000;
    rotateX(sin(angle[i]));
    //rotateY(cos(angle[i]));
    stroke(fft.getFreq(i),0,fft.getBand(i));
    fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i));
    pushMatrix();
    translate((-1 * x[i]-250)%width, (y[i]-250)%height);
    box(fft.getBand(i)/450+(fft.getFreq(i)/4) % 30);
    popMatrix();
  }
  popMatrix();
  pushMatrix();
  
  // Top
  translate(width/2, height/2, 0);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + grow * fft.getBand(i)/1000;
    x[i] = x[i] + grow * fft.getFreq(i)/1000;
    angle[i] = angle[i] + grow * fft.getFreq(i)/10000;
    //rotateX(sin(angle[i]));
    rotateY(cos(angle[i]));
    stroke(fft.getFreq(i),0,fft.getBand(i));
    fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i));
    pushMatrix();
    translate((x[i]-250)%width, (y[i]-250)%height);
    box(fft.getBand(i)/8+fft.getFreq(i)/8);
    popMatrix();
  }
  popMatrix();
  pushMatrix();
  
  // Bottom
  translate(width/2, height/2, 0);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + grow * fft.getBand(i)/1000;
    x[i] = x[i] + grow * fft.getFreq(i)/1000;
    angle[i] = angle[i] + grow * fft.getFreq(i)/10000;
    //rotateX(sin(angle[i]));
    rotateY(sin(angle[i]));
    stroke(fft.getFreq(i),0,fft.getBand(i));
    fill(0, i * 5 % 255, i * 7 % 255);
    pushMatrix();
    translate((x[i]+250)%width, (y[i]+250)%height);
    box(fft.getBand(i)/8+fft.getFreq(i)/8);
    popMatrix();
  }
   popMatrix();
}
 
void stop()
{
  // always close Minim audio classes when you finish with them
  jingle.close();
  minim.stop();
 
  super.stop();
}



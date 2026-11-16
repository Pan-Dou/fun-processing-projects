float[] frequencies = new float[100];  //centre is 50

float maximum(float[] array){
  float m = 0;
  for(int i=0; i<array.length; i++){
    m = (m<array[i]) ? array[i] : m; 
  }
  return m;
}

float randomDisplacement(float range){
  return random(-range,range);
}

float randomValue(int iterations){
  float x=0;
  for (int i=0; i<iterations; i++){
    x += randomDisplacement(1);
  }
  return x;
}

void setupDistribution(float[] values, int variables, int iterations, int mid /*in array*/, float scaling){ // this has to be a pointer
  float x;
  int X;
  float seg = values.length;
  for(int i=0; i<variables; i++){
    x = randomValue(iterations);
    X = (int) (mid + scaling*x/seg);
    if(0 <= X && X < seg){
      values[X]++;
    }
  }
}

void resetDistribution(float[] values){
  for(int i=0; i<values.length; i++){
    values[i] = 0;
  }
}

void renderValues(float[] values){
  int seg = values.length;
  float max = maximum(values);
  float x;
  background(20);
  noStroke();
  fill(100);
  for(int i=0; i<seg;i++){
    x = values[i]*height/max/2;
    rect(width*i/seg,height,width/seg,-x);
  }
}

void setup(){
  size(800,600);
  background(20);
  /*
  for(int i=0; i<100; i++){
    print(randomValue(20)+"\n");
  }*/
  //setupDistribution(frequencies, 1000, 20, 50, 500);
  //renderValues(frequencies);
  frameRate(10);
}

void draw(){
  //resetDistribution(frequencies);
  setupDistribution(frequencies, 10000, 40, 50, 500); //1000 and 100 are gud
  renderValues(frequencies);
}

float f[] = new float[500];
float v[] = new float[500];
int segments = 500;
int wall = 300;
int d = 100;
//int pluck = 150;
float t=0;
boolean running = true;

void initial(){ //INITIAL CONDITIONS
  for(int i=0; i<segments; i++){
    f[i]=0;
    v[i]=0;
    //f[i]=100*(sin(.0025*(i*PI))+sin(.005*(i*PI))/2+sin(.01*(i*PI))/3+sin(.04*(i*PI))/4);
    //f[i]=100*(sin(.01*(i*PI)+sin(.03*int(i*PI))));
    /*
    if(i<=pluck){
      f[i]=i*100/pluck;
    }else{
      f[i]=(segments-i)*100/(segments-pluck);
    }
    */
  }
  //f[50]=50;
}

void update_v(){
  for(int i=1; i<segments-1; i++){
    //without friction
    v[i]+=1*(f[i-1]+f[i+1]-2*f[i]); //.5 factor OG
    //with friction
    //v[i]=.999*v[i];
    //wall friction
    //*
    if(wall<=i && i<=wall+d){
      v[i]=.99*v[i];
    }
    //*/
  }
}
void update_f(){
  for(int i=1; i<segments-1; i++){
    //f[i]+=v[i];
    if(i<wall||i>=wall+d){
      f[i]+=v[i];
    }else{
      f[i]+=.25*v[i];
    }
  }
}

void setup(){
  size(1000,400);
  //frameRate(40);
  background(150);
  //fill(150,50);
  fill(150);
  initial();
}

void draw(){
  rect(-1,-1,width+1,height+1);
  //background(150);
  if(running){
    if(t<10){ //20 for packet, 8 for wavelet
    t+=.1;
    f[0]=25*(sin(t*PI)-sin(.8*t*PI)); //.9 for a packet, 1 for a wavelet  <<<<<<<<<< WAVELET
    ///////f[0]=-100*sin(.25*t*PI);
    }
    update_v();
    update_f();
  }
  strokeWeight(1);
  stroke(130);
  for(int i=1; i<20; i++){line(0,height*i/20,width,height*i/20);}
  line(wall*width/segments,0,wall*width/segments,height);line((wall+d)*width/segments,0,(wall+d)*width/segments,height);
  stroke(0);
  for(int i=0; i<segments-1; i++){
    line((width*i/segments),height/2+f[i],(width*(i+1)/segments),height/2+f[i+1]);
    if(i==wall){
      strokeWeight(2);
    }else if(i==wall+d){
      strokeWeight(1);
    }
  }
}

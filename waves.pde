int midX,midY;
int dist;
float r,g,b;
float d1,d2;
float blur;
float s1,s2; //scale factor
float X,Y;

void setup(){
  size(1500,500);
  background(0);

  midX = width/2;
  midY = height/2;
  dist = 0;
  
  r=.09;
  g=.095;
  b=.1;

  s1=.05;
  s2=.09;
  
  for(int x = 0; x <= width; x++){
    for(int y = 0; y <= height; y++){
        d1 = s1*(x-midX);
        d2 = s2*(y-midY);
        //colorMode(HSB, 100);
        //stroke((0.7+0.3*(  sin(.5*d1)/2+sin(.5*d2)/2  ))*255);
        colorMode(RGB, 100);
        //stroke(60+40*cos(r*d1) + blur,60+40*cos(g*d1)+ blur,60+40*cos(b*d1)+ blur);
        
        if(d1!=0){
          X=sq(sin(d1)/(d1));
        }else{X=1;}
        if(d2!=0){
          Y=sq(sin(d2)/(d2));
        }else{Y=1;}
        
        stroke(10*log(10000*X*Y));
        
        point(x,y);
      }
    }
    print("done!");
}

void draw(){

}

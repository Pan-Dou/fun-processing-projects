float x_h = 400; //position of hook
float y_h = 300;
float x = 300; //position
float y = 500;
float v_x = 0; //velocities
float v_y = 0; 
float r,m,k,dt; //radius, mass, spring constant and time step
float F,W; //forces
float dist;
float wall; //absorbtion of walls
boolean hooked = true;

void mousePressed(){
  if(mouseButton == LEFT){
    hooked = true;
    x_h = mouseX;
    y_h = mouseY;
  }else{
    hooked = false;
  }
}

void setup(){
  size(800,600);
  frameRate(20);
  stroke(255);
  
  W = 20;
  k = 1;
  r = 200;
  m = 10;
  wall = 0.6;
  dt = 2*4/frameRate;
}

float d(float x1, float y1, float x2, float y2){
  return sqrt(sq(x1-x2)+sq(y1-y2));
}

void simulate(){
  dist = d(x_h,y_h,x,y);
  if(dist>r && hooked){
    F = (dist - r)*k;
  }else{
    F=0;
  }
  v_x += m*F*(x_h-x)/dist*dt;
  v_y += m*F*(y_h-y)/dist*dt + W;
  
  v_x *= 0.98;
  v_y *= 0.98;
  
  //bounds
  if(x<0&&v_x<0){v_x=wall*abs(v_x);}else if(x>width&&v_x>0){v_x=-wall*abs(v_x);}
  if(y<0&&v_y<0){v_y=wall*abs(v_y);}else if(y>height&&v_y>0){v_y=-wall*abs(v_y);}
  
  x += v_x*dt;
  y += v_y*dt;
}

void draw(){
  background(0);
  simulate();
  stroke(255-F);
  if(hooked) line(x,y,x_h,y_h);
  ellipse(x,y,10,10);
}

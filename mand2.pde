int midX,midY;
//double z_a,z_b;
double zoom = .001;
int iteration;
int max_iteration;
Complex z = new Complex(0,0);
Complex c = new Complex(0,0);
Complex centre = new Complex(0,0);

class Complex{
  public double r,i;
  public Complex(double a, double b){
    r=a;
    i=b;
  }
  public double MagnitudeSquared(){
    return (r*r+i*i);
  }
  public void Set(double a, double b){
    this.r=a;
    this.i=b;
  }
}

Complex square(Complex a){
  return new Complex(a.r*a.r - a.i*a.i, 2*a.i*a.r);
}

Complex addition(Complex a, Complex b){
  return new Complex(a.r+b.r, a.i+b.i);
}

void renderFractal(){
  midX = (int)(centre.r/zoom) + width/2;
  midY = (int)(centre.i/zoom) + height/2;
  colorMode(HSB, 100, 100, 100);
  background(0);
  for(int x = 0; x <= width; x++){
    for(int y = 0; y <= height; y++){
      iteration = 0;
      z.Set(0,0);
      c.Set((x-midX)*zoom,(y-midY)*zoom);
      //print((sqrt_db(z_a*z_a + z_b*z_b))*zoom);
      while(z.MagnitudeSquared() < 4){
        //print("aa");
        //mandelbrot stuff
        z = addition(square(z),c);
        
        if(iteration>max_iteration){
          break;
        }
        iteration++;
      }
      //colouring
      //print(iteration,x,y);
      if(iteration!=0){
        //print(iteration,x,y,"\n");
        
        //stroke((iteration*5)%100,80,50+50*sin(iteration*5*2*PI/20));
        if(iteration>max_iteration){
          stroke(0,0,0);
        }else{
          //stroke((iteration*5)%100,80, (float) (255.0*Math.tanh((double) iteration/100)));//rainbow
          stroke((iteration*5)%100, 50+40*sin(((iteration*5)*2*PI + PI/2)/50), 70+30*sin(((iteration*5)*2*PI + PI/2)/100));//orange-blue
        }
        point(x,y);
      }
    }
  }
}

void setup(){
  //size(2000,2000); //big
  size(300,300); //test
  background(0);
  
  ////////////////////////////////////////////// INITIAL POSITION ////////////////////////////////////////////////////////////////////////////////
  centre.Set(1,0); zoom = .01; max_iteration = 200;
  
  /* ~~~ INTERESTING LOCATIONS ~~~                                                                                 ~~~ INTERESTING LOCATIONS ~~~
  Complex centre = new Complex(1.5,0); zoom = .0005; max_iteration = 80;
  Complex centre = new Complex(0.81,0.2); zoom = .0001; max_iteration = 120; //somewhere in horseshoe valley
  Complex centre = new Complex(0.02,1); zoom = .00005; max_iteration = 120; //wing
  centre.Set(0.01661,1.006); zoom = .000001; max_iteration = 120; //crossroads
  centre.Set(-0.322602401204795,0.0356199662866441); zoom = .000007999999979801942; max_iteration = 200; //crossroads
  */
  
  renderFractal();
  
  saveFrame();
  print("done!");
}

void draw(){}

void keyPressed(){
  boolean ismoving = false;
  double jump = zoom*50;
  double zoomjump = 2;
  if (key == CODED){
    if (keyCode == UP){ismoving = true; centre.Set(centre.r,centre.i+jump);} 
    else if (keyCode == DOWN){ismoving = true; centre.Set(centre.r,centre.i-jump);}
    else if (keyCode == LEFT){ismoving = true; centre.Set(centre.r+jump,centre.i);}
    else if (keyCode == RIGHT){ismoving = true; centre.Set(centre.r-jump,centre.i);}
  } else if (key == '+'){zoom = zoom/zoomjump; ismoving = true;} 
  else if (key == '-'){zoom = zoom*zoomjump; ismoving = true;}
  if(ismoving){renderFractal(); ismoving = false; print("c = "+centre.r+" + i"+centre.i+", zoom: "+zoom+"\n");}
}

int[] v1 = {0,0};
int[] v2 = {0,0};
PVector temp1 = new PVector(0,0);
PVector temp2 = new PVector(0,0);
PVector temp3 = new PVector(0,0);
float sin60 = 1/sqrt(2);
int size = 25; //size of inner grid
int scale = size*8;

color cy,cg,cb,cr;
color cly,clg,clb,cw;

void g2r(int gx, int gy){ //grid space to screen space
  temp1.set(size*gx+size*gy/2, (size*sin60*gy));
}

void setColor(int cmode, int posx, int posy){
  color c;
  float x = map(posx,0,width,0,1);
  float y = map(posy,0,height,0,1);
  if(cmode==1){
    //c=color((40*(cmode)+(posx/2+posy/3))%360,50,100);
    //c=lerpColor(cr,cw,y);
    c=lerpColor(cr,cy,x);
    c=lerpColor(c,clg,y);
  }else if(cmode==2){
    //c=lerpColor(c1,c4,y);
    c=lerpColor(clb,cly,x);
    c=lerpColor(c,clg,y);
  }else if(cmode==3){
    //c=lerpColor(c2,c4,y);
    c=lerpColor(cb,cr,x);
    c=lerpColor(c,cg,y);
  }else{
    //c=lerpColor(cy,cw,y);
    c=lerpColor(cr,cr,x);
    c=lerpColor(c,cg,y);
  }
  fill(c);
}

int[][] scoords = {{1,/**/ 0,0,0,4,1,4,1,1,3,1,4,0},
                   {2,/**/ 1,1,1,2,3,2,3,1},
                   {3,/**/ 1,2,1,4,2,4,2,2},
                   {2,/**/ 2,3,2,4,4,4,6,2,6,4,7,4,7,1,6,1,4,3},
                   {4,/**/ 6,2,4,4,6,4},
                   {1,/**/ 2,2,2,3,3,3,5,1,4,1,3,2},
                   {4,/**/ 4,0,3,1,3,2,4,1,5,1,3,3,4,3,7,0},
                   {3,/**/ 7,0,6,1,7,1,7,4,8,4,8,0}
                  };

void shape(int[] r, int[] d, char mode){ //n:normal, y:mirrored y, x:mirrored x
  int mx; //mirror scaling
  int my; //mirror scaling
  int scoordsilen;
  int sumx;
  int sumy;
  switch(mode){
    case 'm':
      mx = -1;
      my = -1;
      break;
    case 'x':
      mx = -1;
      my = 1;
      break;
    case 'y':
      mx = 1;
      my = -1;
      break;
    default:
      mx = 1;
      my = 1;
      break;
  }
  for(int i=0; i<scoords.length; i++){
    beginShape();
    scoordsilen = scoords[i].length;
    sumx = 0;
    sumy = 0;
    for(int j=1; j<scoordsilen; j+=2){
      g2r(scoords[i][j],scoords[i][j+1]);
      temp3.x = (temp1.x)*mx + r[0]*d[0];
      temp3.y = (temp1.y)*my + r[1]*d[1];
      vertex(temp3.x, temp3.y);
      sumx += temp3.x;
      sumy += temp3.y;
    }
    //(scoords[i][0]-1+(mx-1))%4+1
    setColor(int(random(4)), sumx/(scoordsilen-1)*2, sumy/(scoordsilen-1)*2);
    endShape(CLOSE);
  }
}

void tile(int[] d, int[] n){
  v2[0] = scale; //x tiling distance
  v2[1] = int(scale*sin60); //y tiling distance
  for(int i=0; i<n[0]; i++){
    for(int j=0; j<n[1]; j++){
      v1[0] = i; 
      v1[1] = j;
      shape(v1,v2,'n');
      shape(v1,v2,'m');
    }
  }
}

void setup(){
  size(800,800);
  noStroke();
  //colorMode(HSB, 360, 100, 100);
  background(0);
  fill(50,50,100);
  
  cb=color(350,54,72);//(248,44,72);//blue
  cg=color(20,57,69);//(104,37,69);//green
  cy=color(43,41,85);//yellow
  clb=color(350,54,50);//(248,44,50);//light blue
  clg=color(20,57,50);//(104,37,50);//light green
  cly=color(43,41,70);//light yellow
  cw=color(43,0,100);//white
  cr=color(104,0,50);//gray
}

void draw(){
  v1[0] = 0;
  v1[1] = 0;
  
  v2[0] = 12;
  v2[0] = 12;
  
  tile(v1,v2);
}

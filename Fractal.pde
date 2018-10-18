int numd = 1000;
int iter = 300;
float a = 2;
float cdl = 10;
float ctrx = 500;
float ctry = 300;
float unit = 120; 
float windowx = 1000;
float windowy = 600;
float[] cordx = new float[iter];
float[] cordy = new float[iter];
float[] ani = new float [iter];
float[] aci = new float [iter];
float[] pixlx = new float[(int)windowx];
float[] pixly = new float[(int)windowy];
//boolean inside = false;

//all points connect to this point
float ipx = 1;
//invert sign y because down is positive and up is negative
float ipy = 0;

//the magnitude the of the shift
float nii = -0.8;
float cii = 0.16;

//this will be gone and replaced with the i and j for loop
float rpx = 1;
//invert sign y because down is positive and up is negative
float rpy = 0.5;

float r = 2;
float xi, jy;
float grad = 0;
int xop, yop;
int cop;
void setup() {
  size(1000, 600);
  //fullScreen();
  background(0);
 //frameRate(200);
  ani[0]=ipx;
  aci[0]=ipy;
}
void draw() {
  background(100);
  noFill();
  stroke(255);
  ellipse(ctrx, ctry, unit*(2+r), unit*(2+r));
  cordinate();
  control();
  port();
  //tr(ipx, ipy, (rpx*rpx) - (rpy*rpy) + nii, (rpx*rpy) + (rpx*rpy) + cii);
  moneyshot();
}
void moneyshot(){
for (int i = 0; i<windowx; i++) {
      for (int j = 0; j<windowy; j++) {
        stroke(grad, grad, 0);
        point(pixlx[i]*unit + ctrx, pixly[j]*unit+ctry);
        //println(pixlx[i]*unit + ctrx + ", " + pixly[j]*unit + ctry);
      }
    }
}
void port(){
if (pixlx[pixlx.length-1] == 0 || pixly[pixly.length-1] == 0) {
    ani[0]=ipx;
    aci[0]=ipy;
   for(float k = -2; k<=2; k+=0.02){
   for(float l = -2; l<=2; l+=0.02){
    ani[1]= k;
    aci[1]= l;
    for (int i=0; i<(ani.length-2) && ani[i] <= 2 && aci[i] <= 2; i++) {
      ani[i+2]=outx(ani[i], aci[i], ani[i+1], aci[i+1], i);
      aci[i+2]=outy(ani[i], aci[i], ani[i+1], aci[i+1], i);
      //fill(i,i,0);
     //tr(ani[i], aci[i], ani[i+1], aci[i+1]);
      // println(ani[1] + ", " + aci[1]);
//      if (inside(aci[i], aci[i], acos(((ani[i]*ani[i+1])+(aci[i+1]*aci[i+1]))))) {
        //if (ani[i] <= 2*cos(acos(((ani[i]*ani[i+1])+(aci[i+1]*aci[i+1])))) && aci[i] <= 2*sin(cos(acos(((ani[i]*ani[i+1])+(aci[i+1]*aci[i+1]))))) && ani[i] >= -2*cos(acos(((ani[i]*ani[i+1])+(aci[i+1]*aci[i+1])))) && aci[i] >= -2*sin(acos(((ani[i]*ani[i+1])+(aci[i+1]*aci[i+1]))))) {
          if(ani[i+2] >= -2 && aci[i+2] >= -2 && ani[i+2] <= 2 && aci[i+2] <= 2){
          pixlx[(int)(k*unit+ctrx)]=ani[1];
        pixly[(int)(l*unit+ctry)]=aci[1];
          }
        //println(cos(acos(((ani[i]*ani[i+1])+(aci[i+1]*aci[i+1])))));
        grad = i;
      }}
   }}}

boolean inside(float o, float p, float a) {
//if (o*cos(a) <= 2 && o*cos(a) >= -2 && p*sin(a) >= -2 && p*sin(a) <= 2) {
  if (o <= 2 && o >= -2 && p >= -2 && p <= 2) {  
    return true;
  } else {
    return false;
  }
}
float outx(float gipx, float gipy, float grpx, float grpy, int iterr) {
  float nx;
  float d1, d2;
  d1 = distance(gipx, gipy, 0, 0);
  d2 = distance(grpx, grpy, 0, 0);
  nx = cos(acos(((gipx*grpx)+(gipy*grpy))/(d1*d2))*(2+iterr))*d2*d2/d1;{
  return nx+nii;
  }
}
float outy(float gipx, float gipy, float grpx, float grpy, int iterr) {
  float ny;
  float d1, d2;
  d1 = distance(gipx, gipy, 0, 0);
  d2 = distance(grpx, grpy, 0, 0);
  ny = sin(acos(((gipx*grpx)+(gipy*grpy))/(d1*d2))*(2+iterr))*d2*d2/d1;
  return ny+cii;
}
void control() {
  if (keyPressed && key == ']') {
    unit++;
  }
  if (keyPressed && key == '[') {
    unit--;
  }
  if (mousePressed) {
    ctrx = ctrx + mouseX-pmouseX;
    ctry = ctry + mouseY-pmouseY;
  }
}
void cordinate() {
  stroke(255);
  line(ctrx, 0, ctrx, windowy);
  line(0, ctry, windowx, ctry);
  for (int i = -numd; i<=numd; i++) {
    //horizontal
    line(ctrx-(i*unit), ctry - (windowy-cdl/2) + windowy, ctrx-(i*unit), ctry - (windowy+cdl/2)+ windowy);
    //vetical
    line(ctrx - (windowx-cdl/2)+windowx, (i*unit)+ctry, ctrx - (windowx+cdl/2) +windowx, (i*unit)+ctry);
  }
}
float distance(float ipox, float ipoy, float px, float py) {
  return sqrt(((px-ipox)*(px-ipox))+((py-ipoy)*(py-ipoy)));
}
void tr(float ni, float ci, float n, float c) {
  triangle(ctrx, ctry, ctrx + ni * unit, ctry + ci * unit, ctrx + n * unit, ctry + c * unit);
}
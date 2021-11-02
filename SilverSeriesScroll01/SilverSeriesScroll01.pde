import themidibus.*;
import java.io.*;

/* NEXT STEPS
> Make function or object of loading
> Load more than one image
> Discard image when out of view
*/

PGraphics pg;
PImage img; 

float tilesX = 400;
float tilesY = 5;
float tileSizeX;
float tileSizeY;

color c;
float brightness;

int imgX = width;
int imgY = 0;
int imgSpeed = 1;

/*
MidiBus myBus;
int channel = 1;
int pitch = 64;
int velocity = 127;
*/

void setup() {
  size(800, 800);
  
  /*
  MidiBus.list();
  myBus = new MidiBus(this, -1, "Bus 1");
  */
  
  String userHome = System.getProperty("user.home");
  println(userHome);
  println();
  File fMountains = new File(dataPath(""), "/Mountains/");
  String[] listMountains = fMountains.list();
  
  pg = createGraphics(800, 800);
  println(fMountains.list());
  
  img = loadImage(dataPath("")+ "/Mountains/" + listMountains[int(random(listMountains.length))]);
  img.resize(800, 800);

  tileSizeX = width/tilesX;
  tileSizeY = width/tilesY;

}

void draw() {
  background(0);
  fill(255);
  noStroke(); 
  image(img,imgX,0);
  
  pg.beginDraw();
  pg.clear();
  /*
  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {
      c = get(int(x*tileSizeX),int(y*tileSizeY)); 
      //println(c);
      brightness = brightness(c);
      //println(brightness);
      if ((brightness > 80)) {
        pg.fill(#FFFFFF); 
      } else {
        pg.fill(#000000);
      }
      pg.rect(x*tileSizeX, y*tileSizeY, tileSizeX, tileSizeY);
    }
  }
  */
  pg.endDraw();
  image (pg,0,0);
  int x = 1;

  /*
  if ((frameCount % 10) == 0) {
    
    for (int y = 0; y < tilesY; y++) {
      c = get(int(x),int(y*tileSizeY+2)); 
      brightness = brightness(c);
      float sizeY = 2 * map(brightness,0,255,0,tileSizeY);    
      println("check " + c);
      
      //pitch = int(map(y, 0, tiles, 32, 100));
      //pitch = 60;
      
      if (brightness >= 50) {
        ellipse(x*tileSizeX, y*tileSizeY, sizeY*1.1, sizeY*1.1);
        
        println(pitch);
        myBus.sendNoteOn(1, pitch, velocity); // Send a Midi noteOn
        delay(20);
        myBus.sendNoteOff(1, pitch, velocity); // Send a Midi nodeOff
        //delay(20);
      }
    }
  }
  */
  imgX -=0.1;
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

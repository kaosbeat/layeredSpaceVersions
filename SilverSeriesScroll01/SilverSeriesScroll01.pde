import netP5.*;
import oscP5.*;

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

OscP5 oscP5;
NetAddress pureData;

ParticleSystem mountains;


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
int count = 0;
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
  File fMountains = new File(dataPath(""), "/05-Mountains/");
  String[] listMountains = fMountains.list();
  
  pg = createGraphics(800, 800);
  println(fMountains.list());
  
  img = loadImage(dataPath("")+ "/05-Mountains/" + listMountains[int(random(listMountains.length))]);
  img.resize(800, 800);

  tileSizeX = width/tilesX;
  tileSizeY = width/tilesY;
  
  // particles
  mountains = new ParticleSystem(new PVector(width/2, 50), "05-Mountains/", fMountains.list());  


}

void draw() {
  background(0);
  fill(255);
  noStroke(); 
  
  count++;
  clear();
  mountains.run(); //verplicht iedere frame
  if ( count % 10 == 0) {
    mountains.addParticle(); ///naar eigen logic
  }
  
  
  
  
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

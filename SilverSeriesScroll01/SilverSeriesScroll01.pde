import netP5.*;
import oscP5.*;
// import codeanticode.syphon.*;
import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus


OscP5 oscP5;
NetAddress pureData;
// SyphonServer server;

PImage[] planetImgs = new PImage[1];
PImage[] skyImgs = new PImage[1];
PImage[] mountainImgs = new PImage[1];
PImage[] backgroundImgs = new PImage[1];
PImage[] foregroundImgs = new PImage[1];

ParticleSystem mountains;
ParticleSystem skys;
ParticleSystem planets;
ParticleSystem backgrounds;
ParticleSystem foregrounds;

import themidibus.*;
import java.io.*;


color c;
float brightness;
float globalscrollspeed;
int count = 0;
/*
MidiBus myBus;
 int channel = 1;
 int pitch = 64;
 int velocity = 127;
 */

void setup() {
  size(1920, 1080, P3D);
  MidiBus.list();
  myBus = new MidiBus(this, "SLIDER/KNOB", 0);
  //String userHome = System.getProperty("user.home");
  //println(userHome);
  //println();

  globalscrollspeed = 1.0;


  File fSkys = new File(dataPath(""), "/00-Sky/");
  File fPlanets = new File(dataPath(""), "/02-Planets/");
  File fMountains = new File(dataPath(""), "/05-Mountains/");
  File fBackgrounds = new File(dataPath(""), "/10-Background/");
  File fForegrounds = new File(dataPath(""), "/20-Foreground/");

  for (int i = 0; i < fSkys.list().length; i++) {
    PImage skyImg = loadImage("00-Sky/"+fSkys.list()[i]);
    skyImgs = (PImage[]) append(skyImgs, skyImg);
  }
  for (int i = 0; i < fPlanets.list().length; i++) {
    PImage planetImg = loadImage("02-Planets/"+fPlanets.list()[i]);
    planetImgs = (PImage[]) append(planetImgs, planetImg);
  }
  for (int i = 0; i < fMountains.list().length; i++) {
    PImage mountainImg = loadImage("05-Mountains/"+fMountains.list()[i]);
    mountainImgs = (PImage[]) append(mountainImgs, mountainImg);
  }
  for (int i = 0; i < fBackgrounds.list().length; i++) {
    PImage backgroundImg = loadImage("10-Background/"+fBackgrounds.list()[i]);
    backgroundImgs = (PImage[]) append(backgroundImgs, backgroundImg);
  }
  for (int i = 0; i < fForegrounds.list().length; i++) {
    PImage foregroundImg = loadImage("20-Foreground/"+fForegrounds.list()[i]);
    foregroundImgs = (PImage[]) append(foregroundImgs, foregroundImg);
  }
  // particles
  float scrollspeed = 1.0;
  skys = new ParticleSystem(new PVector(width, 0), skyImgs, new PVector(-1*scrollspeed, 0));  
  planets = new ParticleSystem(new PVector(width, 0), planetImgs, new PVector(-2*scrollspeed, 0));  
  ////mountains = new ParticleSystem(new PVector(width, 0), "05-Mountains/", fMountains.list(), new PVector(-3*scrollspeed, 0));  
  //mountains = new ParticleSystem(new PVector(width, 0), mountainImgs, new PVector(-4, 0));
  //backgrounds = new ParticleSystem(new PVector(width, height/2), backgroundImgs, new PVector(-4*scrollspeed, 0));  
  //foregrounds = new ParticleSystem(new PVector(width, height/2), foregroundImgs, new PVector(-5*scrollspeed, 0));  



  skys.addParticle();
  planets.addParticle();

  //mountains.addParticle(); ///naar eigen logic

  //backgrounds.addParticle();
  //foregrounds.addParticle();
  // server = new SyphonServer(this, "de portables");
}

void draw() {
  background(0);
  fill(255);
  noStroke(); 
  count++;
  clear();

  if ( count % 300 == 0) {
    //mountains.addParticle(); ///naar eigen logic
    planets.addParticle();
    skys.addParticle();
    //backgrounds.addParticle();
    //foregrounds.addParticle();
  }
  /// draw lkayers in correct oprder (bottom first)
  skys.run();
  planets.run();

  //mountains.run(); //verplicht iedere frame

  //backgrounds.run();
  //foregrounds.run();

  // server.sendScreen();
}


void controllerChange(ControlChange change) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+change.channel());
  println("Number:"+change.number());
  println("Value:"+change.value());
  globalscrollspeed = (change.value() / 64) + 0.2;
}



void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

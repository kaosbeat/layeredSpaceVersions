// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin, pspeed;
  StringList sprites;
  PImage[] imgs;

  //ParticleSystem(PVector position, String path, String[] spriteList, PVector speed) {
  ParticleSystem(PVector position, PImage[] imgList, PVector speed, String systype) {
    //sprites = new StringList();
    imgs = imgList;
    origin = position.copy();
    particles = new ArrayList<Particle>();
    pspeed = speed.copy();
    if (systype == "planet") {
      pspeed.x = pspeed.x - random(10);
      pspeed.y = pspeed.y + random(10)/20;
    }
    //for (int i = 0; i < spriteList.length; i++) {
    //  sprites.append(path+spriteList[i]);
    //}
  }

  void addParticle() {
    PVector speed = new PVector(pspeed.x * 1, pspeed.y);
    //particles.add(new Particle(origin, sprites, speed));
    int rx = int(random(0, imgs.length-1));
    PImage img = imgs[rx];
    particles.add(new Particle(origin, img, speed));
  }

  void run() {
    if (particles.size() > 0) {
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle p = particles.get(i);
        p.run();
        if (p.isDead()) {
          particles.remove(i);
        }
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PImage img;
  float lifespan;
  StringList imgs;


  //Particle(PVector l,StringList sprites, PVector speed) {
  Particle(PVector l, PImage sprite, PVector speed) {
    //imgs = sprites;
    img = sprite;
    acceleration = new PVector(0, 0);
    velocity = speed.copy();
    position = l.copy();
    lifespan = 255.0;
    //int rx = int(random(0, imgs.size()));
    //img = loadImage(imgs.get(rx));
    //img = loadImage("05-Mountains/silvergold.png");
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    //stroke(255, lifespan);
    //fill(255, lifespan);
    //ellipse(position.x, position.y, 8, 8);
    //tint(255,lifespan);
    //println(img);
    if (img != null) {
      image(img, position.x, position.y);
    }
  }  

  // Is the particle still useful?
  boolean isDead() {
    if (img != null) {
      //if (lifespan < 0.0) {
      if (position.x + img.width < 0) {
        //println(position.x);
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

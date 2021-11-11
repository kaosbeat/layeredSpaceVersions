// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin, pspeed;
  StringList sprites;
  PImage[] imgs;
  String systemtype ;

  //ParticleSystem(PVector position, String path, String[] spriteList, PVector speed) {
  ParticleSystem(PVector position, PImage[] imgList, PVector speed, String systype) {
    //sprites = new StringList();
    imgs = imgList;
    origin = position.copy();
    particles = new ArrayList<Particle>();
    pspeed = speed.copy();
    systemtype = systype;
    //for (int i = 0; i < spriteList.length; i++) {
    //  sprites.append(path+spriteList[i]);
    //}
  }

  void addParticle() {
    PVector speed = new PVector(pspeed.x, pspeed.y);
    if (systemtype == "planet") {
      speed.x = pspeed.x - random(10);
      speed.y = pspeed.y + random(10)/20;
    }
    //particles.add(new Particle(origin, sprites, speed));
    int rx = int(random(0, imgs.length-1));
    PImage img = imgs[rx];
    if (img != null) {
      particles.add(new Particle(origin, img, speed, systemtype));
    }
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
  float rotation;
  float rotationspeed;
  PImage img;
  float lifespan;
  float scale;
  StringList imgs;
  float offsetY;


  //Particle(PVector l,StringList sprites, PVector speed) {
  Particle(PVector l, PImage sprite, PVector speed, String systemtype) {
    //imgs = sprites;
    img = sprite;
    acceleration = new PVector(0, 0);
    velocity = speed.copy();
    position = l.copy();
    lifespan = 5255.0;
    
    if (systemtype == "planet") {
      rotationspeed = (random(0, 0.5) - 0.25) / 10 ;
      scale = 1.0;
      offsetY = 0;
    } else if (systemtype == "mountain") {
      scale = float(height) / float(img.height) * 5.0/8.0;
      offsetY = height * 3.0/8.0;
    } else if (systemtype == "background") {
      float r = random(0,1);
      scale = float(height) / float(img.height) * r;
      //scale =   1;
      println(scale*img.height );
      offsetY = height-img.height;
      
      //offsetY = height * 1-r;
    //} else if (systemtype == "foreground") {
    //  float r = random(0,1);
    //  scale = float(height) / float(img.height) * r;
    //  scale =1;
    //  offsetY = height * 1-r;
    } else {
      offsetY = 0;
      scale = 1.0;
      rotationspeed = 0;
    }
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
    rotation = rotation + rotationspeed;
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
 
    if (img != null) {
      pushMatrix();
      translate(position.x + img.width/2, position.y+img.height/2);
      rotateZ(rotation);
      translate(-img.width/2, -img.height/2);
      image(img, 0, offsetY, img.width*scale, img.height*scale);
      popMatrix();
    }
  }  

  // Is the particle still useful?
  boolean isDead() {
    if (img != null) {
      if (lifespan < 0.0) {
      //if (position.x + 3*img.width < 0) {
        println(position.x - img.width ) ;
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

import processing.video.*;
PImage img;
Table table;

Capture cam;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
     if (keyPressed == true) {
      saveFrame("./data/pic.jpg");
  print("clik");
   cam.stop();
  
  int h = 28;
  int w = 28;
  //background(255);
  delay(1000);
  img = loadImage("./data/pic.jpg");
  print("img");
  loadPixels(); 
  
  String[] data = new String[h*w];
  String[] image = new String[h*w];
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  
 table = new Table();
          for (int j = 0; j < h; j++) {
                   for (int i = 0; i < w; i++) {

             float datar = 0;
             float datag = 0;
             float datab = 0;
             
             float datargb = 0;
             
             table.addColumn();

 
                for (int y = j*img.height/h; y < (j+1)*img.height/h; y++) {
                   for (int x = i*img.width/w; x < (i+1)*img.width/w; x++) {       
               
                    int disploc = x + y*img.width;
                 
                    datar = datar + red(img.pixels[disploc]);
                    datag = datag + green(img.pixels[disploc]);
                    datab = datab + blue(img.pixels[disploc]);
                    
                    datargb = datargb + color(img.pixels[disploc]);
                  
     
                    }
                  }
                  
  int dim=(img.height*img.width)/( h *w);
  float r = datar/dim-datar%dim/dim;
  float g = datag/dim-datag%dim/dim;
  float b = datab/dim-datab%dim/dim;
  
  float rgb = datargb/dim;
  
  pixels[i+j*w]=color(r,g,b);  

  image[i+j*w] = str(abs(color(r,g,b)));
  data[i+j*w] = str((r+g+b)/3.0);

  table.setInt(j,i, round((r+g+b)/3.0));

      }
  }
  updatePixels();
  saveTable(table, "data/new.csv");
  saveStrings("nouns.txt", data);
  saveStrings("image.txt", image);
  print(" ok!");
  } 
  }
  image(cam, 0, 0);
 
}

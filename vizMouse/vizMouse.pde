import java.util.Map;

BufferedReader reader, readerStill;
String line;

IntDict hm = new IntDict();
IntDict hms = new IntDict();
int max, maxStill;
int current = 0;

void setup() {
  size(1440, 900, P2D);
  reader = createReader("positions-2014-3-4.txt");
  readerStill = createReader("positions-2014-3-4-still.txt");
  try{
    line = reader.readLine();
    while(line != null){
      hm.add(line, 1);
      line = reader.readLine();
    }
    line = readerStill.readLine();
    while(line != null) {
      hms.add(line, 1);
      line = readerStill.readLine();
    }
  } catch(IOException e) {
    e.printStackTrace();
  }
  max = max(hm.valueArray());
  maxStill = max(hms.valueArray());
  println(max);
  println(maxStill);
}

void draw() {
  background(0);
  int i = 0, j = 0;
  for(i = 0; i < width; i++) {
    for(j = 0; j < height; j++){
      String toLook = i +","+ j;
      int amount = current == 0 ? hm.get(toLook) : hms.get(toLook);
      stroke(amount * 255 / (current == 0 ? max : maxStill));
      point(i,j);
      //println(i+","+j);
    }
  }
}

boolean sketchFullScreen() {
  return true;
}

void keyPressed() {
  if(key == 'p') {
    save("image-"+current+".jpg");
  } else {
    current = (current + 1) % 2;
  }
}

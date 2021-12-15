import ipcapture.*; //importamos la librería que usaremos para 
import processing.video.*; //importamos la librería para video basada en GStreamer
import opencv.*; //importamos la librería de computer vision (aunque seguramente no la usaremos)

IPCapture cam; //declaramos cámara con la clase específica de la librería (cámara en IP)

void setup() {
  size(600, 400); //ajustamos la ventana a nuestro display final
  background(255,255,255);  //definimos un fondo en blanco sobre el que se compondrá la imagen
  cam = new IPCapture(this, "http://172.20.10.6", "", ""); //creamos nueva instancia de objeto para nuestra captura, añadiendo el IP como parámetro (los siguientes corresponderían a usuario y password)
  cam.start();
}

void draw() {
 tint(0, 20,255);
  if (cam.available() == true) { //definimos que si hay una cámara disponible se lean las imágenes y se carguen en Processing
    cam.read(); 
    cam.loadPixels();
    
    for (int i = 0; i < 2500; i++) { //recorremos con un bucle todos los píxeles de la imagen para usarlos para manipular la imagen
    float x = random(width);
    float y = random(height);
    color c = cam.get(int(x),int(y)); //guardamos en variables los valores de nuestra imagen (igual que en una estática, aunque aquí usamos video streaming)
    
      if (brightness(c) > 200) { //definimos que las zonas muy próximas del blanco total en luminosidad estén vacías (así simulamos el blanco de fondo de los azulejos)
         noStroke(); // 
         noFill();
      }  
      else if (brightness(c) < 40){ //definimos que las zonas más oscuras presenten más concentración de negro y un tinte más azulado
      tint(0, 10); // para customizar nuestro propio contraste/luminosidad, como en Curvas o Niveles de photoshop
      fill(0,0,15,65); 
      ellipse(x,y,2,10);
 
      }
      else { //para el resto de luminosidad capturada entre estas dos fronteras, aplicamos:
      stroke(0, 30, 200,80); //borde azul en la elipse para no comprometer la luminosidad y simular bordes de pincelada
      strokeWeight(0.1);
      colorMode(RGB, 110,255,200);
     
      float value = brightness(c);  // almacenamos la luminosidad de la captura en una variable
      fill(value); //para aplicarla como relleno a las elipses
      ellipse(x,y,2,8); // una elipse por cada píxel con su respectivo tamaño
      colorMode(RGB,10,70,255); //con colorMode podemos alternar entre RGB y HSB para alterar los valores
       ellipse(x,y,2,8); //creamos las elipses con un tamaño suficiente para retener definición sin perder el aspecto difuso
      } // la intención conceptual/usabilidad del proyecto define estos aspectos por encima del realismo en "pintura sobre azulejo"
  } 
  }
}


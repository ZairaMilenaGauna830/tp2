//Zaira Milena Gauna, comisión 5
//OpArt Gemini 1966 de Edna Andrade

PImage refImg;
boolean invertColors = false;
int numSpokes = 32;
float angleOffset = 0;

void setup() {
  size(800, 400);
  refImg = loadImage("opart.jpg");
}

void draw() {
  background(255);

  // Mostrar imagen a la izquierda
  image(refImg, 0, 0, 400, 400);
  
  // Dibujar a la derecha
  drawPattern(400, 0); // x = 400 porque empieza la segunda mitad
}

void drawPattern(int startX, int startY) {
  int gridSize = 2;
  int circleSize = 200;
  
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      float centerX = startX + j * circleSize + circleSize/2;
      float centerY = startY + i * circleSize + circleSize/2;

      // Alternar color de centro según posición
      boolean isLightCenter = (i + j) % 2 == 0;

      drawSpiral(centerX, centerY, circleSize, numSpokes, isLightCenter);
    }
  }
}

// ✅ Función que *no retorna valor*, recibe parámetros
void drawSpiral(float cx, float cy, float size, int spokes, boolean lightCenter) {
  float r = size / 2;
  float angleStep = TWO_PI / spokes;

  pushMatrix();
  translate(cx, cy);
  rotate(angleOffset);

  for (int i = 0; i < spokes; i++) {
    float a1 = i * angleStep;
    float a2 = (i + 1) * angleStep;

    float x1 = cos(a1) * r;
    float y1 = sin(a1) * r;
    float x2 = cos(a2) * r;
    float y2 = sin(a2) * r;

    if (i % 2 == 0) {
      fill(0);
    } else {
      fill(255);
    }

    if (invertColors) fill(255 - red(get(0, 0)));

    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(x1, y1);
    vertex(x2, y2);
    endShape(CLOSE);
  }

  // Centro
  if (lightCenter) {
    fill(255);
  } else {
    fill(0);
  }
  ellipse(0, 0, 10, 10);

  popMatrix();
}

//  Función que *retorna valor*, se usa para calcular el radio según distancia al mouse
float getRadiusFromMouse(float x, float y) {
  float d = dist(mouseX, mouseY, x, y);
  return map(d, 0, width, 40, 100);
}

// Evento de teclado
void keyPressed() {
  if (key == ' ') {
    invertColors = !invertColors;  // Invertir colores al presionar espacio
  }
  if (key == 'r') {
    resetSketch();  // Reiniciar al presionar 'r'
  }
  if (key == 'a') {
    angleOffset += 0.1; // Girar espirales
  }
  if (key == 's') {
    angleOffset -= 0.1;
  }
}

// ✅ Reinicio de variables
void resetSketch() {
  invertColors = false;
  numSpokes = 32;
  angleOffset = 0;
}

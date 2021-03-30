import processing.core.PApplet;
import de.bezier.guido.*;
  public final static int numrows = 20;
  public final static int numcols = 20;
  private Life[][] buttons; //2d array of Life buttons each representing one cell
  private boolean[][] buffer; //2d array of booleans to store state of buttons array
  private boolean running = true; //used to start and stop program

  public void settings() {
    size(400, 400);
  }

  public void setup () {
    
    frameRate(6);
    // make the manager
    Interactive.make( this );
    buttons = new Life[numrows][numcols];
    for(int i = 0; i<numrows; i++){
    for(int j = 0; j<numcols; j++){
      buttons[i][j] = new Life(i,j);
    }
  }
    buffer = new boolean[numrows][numcols];
  }

  public void draw () {
    background( 0 );
    if (running == false) //pause the program
      return;
    copyFromButtonsToBuffer();

    for(int i = 0; i<numrows; i++){
    for(int j = 0; j<numcols; j++){
      if(countNeighbors(i,j) == 3){
        buffer[i][j] = true;
      }
      else if(countNeighbors(i,j) == 2 && buttons[i][j].getLife() == true){
        buffer[i][j] = true;
      }
      else{
        buffer[i][j] = false;
      }
    }
  }
    copyFromBufferToButtons();
  }

  public void keyPressed() {
    if(key == 'x'){
      if(running == true){
        running = false;
      }
      else{
        running = true;
      }
    }
  }

  public void copyFromBufferToButtons() {
  for(int i = 0; i < numrows; i++){
  for(int j = 0; j < numcols; j++){
      if(buffer[i][j] == true){
        buttons[i][j].setLife(true);
  }
      else{
        buttons[i][j].setLife(false);
    }
   } 
  }
}

  public void copyFromButtonsToBuffer() {
  for(int i = 0; i < numrows; i++){
  for(int j = 0; j < numcols; j++){
      if(buttons[i][j].getLife() == true){
        buffer[i][j] = true;
  }
      else{
        buffer[i][j] = false;
      }
    }
  }
}

  public boolean isValid(int i, int j) {
      if(numrows > i  && numcols > j && i >= 0 && j >= 0){
        return true;
      }
    return false;
  }

  public int countNeighbors(int row, int col) {
    
  int neighbors = 0;
  if(isValid(row,col-1) == true && buttons[row][col-1].getLife() == true){
    neighbors++;
  }
  if(isValid(row-1,col) == true && buttons[row-1][col].getLife() == true){
    neighbors++;
  }
  if(isValid(row-1,col-1) == true && buttons[row-1][col-1].getLife() == true){
    neighbors++;
  }
  if(isValid(row,col+1) == true && buttons[row][col+1].getLife() == true){
    neighbors++;
  }
  if(isValid(row+1,col) == true && buttons[row+1][col].getLife() == true){
    neighbors++;
  }
  if(isValid(row+1,col+1) == true && buttons[row+1][col+1].getLife() == true){
    neighbors++;
  }
  if(isValid(row+1,col-1) == true && buttons[row+1][col-1].getLife() == true){
    neighbors++;
  }
  if(isValid(row-1,col+1) == true && buttons[row-1][col+1].getLife() == true){
    neighbors++;
  }
    return neighbors;
  }

  public class Life {
    private int myRow, myCol;
    private float x, y, width, height;
    private boolean alive;

    public Life (int row, int col) {
      width = 400/numcols;
      height = 400/numrows;
      myRow = row;
      myCol = col; 
      x = myCol*width;
      y = myRow*height;
      alive = Math.random() < .5; // 50/50 chance cell will be alive
      Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () {
      alive = !alive; //turn cell on and off with mouse press
    }
    public void draw () {    
      if (alive != true)
        fill(0);
      else 
      fill( 150 );
      rect(x, y, width, height);
    }
    public boolean getLife() {
      if(alive == true){
        return true;
      }
      return false;
    }
    public void setLife(boolean living) {
      if(living == true){
        alive = true;
      }
      else{
        alive = false;
      }
    }
  }

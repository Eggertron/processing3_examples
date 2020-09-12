class Cells {
  Cell head; // keep this one null, sentinal
  
  public Cells(int x, int y) {
    head = new Cell(null, null);
    head.next = new Cell(head, null);
    head.next.pos.x = x;
    head.next.pos.y = y;
  }
  
  public void draw() {
    Cell tmp = head.next;
    while (tmp != null) {
      moveCell(tmp);
      checkAge(tmp);
      checkHealth(tmp);
      ellipse(tmp.pos.x, tmp.pos.y,
              tmp.size * tmp.reproduce, tmp.size * tmp.reproduce);
      tmp = tmp.next;
    }
  }
  
  private void moveCell(Cell cell) {
    cell.pos.x += random(-cell.speed, cell.speed);
    cell.pos.y += random(-cell.speed, cell.speed);
    if (cell.pos.x > width) cell.pos.x = width;
    else if (cell.pos.x < 0) cell.pos.x = 0;
    if (cell.pos.y > height) cell.pos.y = height;
    else if (cell.pos.y < 0) cell.pos.y = 0;
  }
  
  private void checkAge(Cell cell) {
    if (cell.age > 500) {
      cell.addCell(cell.pos);
      cell.age = 0;
      cell.reproduce++;
    }
    else {
      cell.age++;
    }
    if (cell.reproduce > 4) {
      cell.isAlive = false;
    }
  }
  
  private void checkHealth(Cell cell) {
    if (!cell.isAlive) {
      cell.removeCell();
    }
  }
  
  class Cell {
    Cell next, prev;
    int age, size, reproduce, speed;
    boolean isAlive;
    PVector pos;
    
    public Cell(Cell p, Cell n) {
      pos = new PVector();
      prev = p;
      next = n;
      size = 10;
      speed = 2;
      reproduce = 1;
      age = 0;
      isAlive = true;
    }
    
    public void addCell(PVector xy) {
      next = new Cell(this, next);
      if (next.next != null) next.next.prev = next;
      next.pos.x = xy.x;
      next.pos.y = xy.y;
    }
    
    public void removeCell() {
      if (prev != null) prev.next = next;
      if (next != null) next.prev = prev;
    }
    
  } // end of Cell class
}
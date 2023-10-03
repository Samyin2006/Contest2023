import java.util.PriorityQueue;
import java.util.LinkedList;

class Node implements Comparable<Node> {
  int x, y;
  int distance;
  Node parent;

  Node(int x, int y, int distance, Node parent) {
    this.x = x;
    this.y = y;
    this.distance = distance;
    this.parent = parent;
  }

  public int compareTo(Node other) {
    return Integer.compare(this.distance, other.distance);
  }
}

void setup() {
  int[][] maze = {
    {1, 0, 0, 1, 1, 1, -1},
    {1, 1, 1, 1, 0, 0, 0},
    {1, 1, 1, 0, 0, 1, 0},
    {1, 1, 1, 0, 1, 0, 0},
    {1, 1, 1, 0, 1, 0, 1},
    {-2, 0, 0, 0, 0, 0, 1}
  };

  aStar(maze, 0, 5, 6, 0);
}

void aStar(int[][] maze, int startX, int startY, int endX, int endY) {
  PriorityQueue<Node> queue = new PriorityQueue<Node>();
  queue.add(new Node(startX, startY, 0, null));

  int rows = maze.length;
  int cols = maze[0].length;

  boolean[][] visited = new boolean[rows][cols];
  visited[startY][startX] = true;

  int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {1, 1}, {-1, 1}, {1, -1}};

  while (!queue.isEmpty()) {
    Node current = queue.poll();

    if (current.x == endX && current.y == endY) {
      printPath(current);
      return;
    }

    for (int i = 0; i < 8; i++) {
      int newX = current.x + dirs[i][0];
      int newY = current.y + dirs[i][1];

      if (newX >= 0 && newY >= 0 && newX < cols && newY < rows && !visited[newY][newX] && maze[newY][newX] != 1) {
        visited[newY][newX] = true;
        Node nextNode = new Node(newX, newY, current.distance + 1, current);
        queue.add(nextNode);
      }
    }
  }
}

void printPath(Node node) {
  LinkedList<Node> path = new LinkedList<Node>();
  Node current = node;

  while (current != null) {
    path.addFirst(current);
    current = current.parent;
  }

  for (Node n : path) {
    println("[" + n.x + ", " + n.y + "]");
  }
}

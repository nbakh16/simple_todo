class Todo {
  String title;
  String description;
  bool isDone;

  Todo(this.title, this.description, this.isDone);

  void toggleDone() {
    isDone = !isDone;
  }
}
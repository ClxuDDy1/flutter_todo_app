class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      // these elements were used before I created the add and remove methods

      // ToDo(id: '01', todoText: 'playing final fantasy', isDone: true),
      // ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      // ToDo(id: '03', todoText: 'Do push-ups'),
      // ToDo(id: '04', todoText: 'Team Meeting'),
      // ToDo(id: '05', todoText: 'k!ll or be k!lled by firebase'),
      // ToDo(id: '06', todoText: 'Dinner with Jane in slumberland '),
    ];
  }
}

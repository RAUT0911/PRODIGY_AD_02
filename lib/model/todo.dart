class ToDo {
  String ? id;
  String? todoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone=false,
  });
  static List<ToDo> todoList ()
  {
    return [
      ToDo(id: '01', todoText:'Morning Exercise',isDone: true),
      ToDo(id: '02', todoText:'Buy Groceries',isDone: true),
      ToDo(id: '03', todoText:'Check Mails',),
      ToDo(id: '04', todoText:'Team Metting',),
      ToDo(id: '05', todoText:'Work on Mobile apps 2hr',),
      ToDo(id: '06', todoText:'Doing Study',),
      ToDo(id: '07', todoText:'Dinner with Jenny',),
      ToDo(id: '08', todoText:'Daily Revision',),
    ];
  }
}

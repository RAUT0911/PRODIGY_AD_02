import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';
import '../widget/todo_item.dart';
class Home extends StatefulWidget {
  final String title;
  Home({Key? key ,required this.title}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  //create Variabler
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo =[];
  final _todoController = TextEditingController();

  get tfBGColor => null;

  get tfBlue => null;

  get tfGrey => null;
  @override
  void initState ()
  {
    _foundToDo = todoList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tfBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50,bottom: 20,),
                          child: Text("All ToDo's ",style: TextStyle(fontSize:
                          30,fontWeight:FontWeight.w400 ),),
                        ),
                        for(ToDo todoo in _foundToDo.reversed)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange ,
                            onDeleteItem: _deleteToDoItem ,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 20,right: 20),
                      child : ElevatedButton(
                        child: Text("+",style: TextStyle(fontSize:40, ),),
                        onPressed: () {
                          _addToDoItem(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tfBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10,
                        ),
                      )
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
  //Own Functions
  void _handleToDoChange(ToDo todo)
  {
    setState(() {
      todo.isDone =! todo.isDone;
    });
  }
  void _deleteToDoItem(String id)
  {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }
  void _addToDoItem(String toDo )
  {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo
      ));
      _todoController.clear();
    });
  }
  void _runFilter(String enterdKeyword)
  {
    List<ToDo>results =[];
    if(enterdKeyword.isEmpty)
    {
      results=todoList;
    }
    else{
      results =todoList.where((item) =>
          item.todoText!.toLowerCase().contains(enterdKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo=results;
    });
  }
  Widget searchBox() {
    return(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: tdBlack,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,minWidth: 25
                ),
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: tfGrey)
            ),
          ),
        )
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tfBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 45,
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20
              ),
              child: Image.asset("assets/photos/boys.jpg"),
            ),
          )
        ],
      ), // Use the title property in the AppBar.
    );
  }
}
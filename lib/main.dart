import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'models/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pizzeria'),
    );
  }
}

class MyHomePage extends StatelessWidget{
  String title;
  MyHomePage({required this.title, Key? key}) : super(key: key);

  var _menus  =[
    Menu(1, 'Entrées', 'entree.png', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizza.png', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.png', Colors.brown),
    Menu(1, 'Boissons', 'boisson.png', Colors.lightBlue),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarWidget(title),
      body: Center(
        child: ListView.builder(
          itemCount: _menus.length,
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              switch (_menus[index].type) {
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PizzaList()),
                  );
                  break;
              }
            },
            child: _buildRow(_menus[index]),
          ),
          itemExtent: 180,
        ),
      ),
    );
  }
  _buildRow(Menu menu) {
    return Container(
        height: 180,
        decoration: BoxDecoration(
          color: menu.color,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/images/menus/${menu.image}',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 50,
              child: Center(
                child: Text(
                  menu.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}


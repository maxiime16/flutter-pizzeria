import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key : key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            title: Text('Panier'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text('Pizza 1'),
                    Text('Pizza 2'),
                    Text('Pizza 3'),
                  ],
                ),
              ),
              Row(
                children: [
                  Text('Total'),
                  Text('30 €'),
                ],
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Valider'),
                  onPressed: () {
                    print('Valider');
                  },
                ),
              )
            ],
          ),
        );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/services/pizzeria_service.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget._cart.totalItems(),
              itemBuilder: (context, index) {
                var cartItem = widget._cart.getCartItem(index);
                return ListTile(
                  title: Row(
                    children: [
                      Image.network(
                        '${PizzeriaService.uri}/static/images/pizzas/${cartItem.pizza.image}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.pizza.title),
                            _buildQuantityColumn(cartItem),
                            Text('Sous-total: ${cartItem.pizza.price * cartItem.quantity} €', style: PizzeriaStyle.priceSubTotalTextStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildTotalRow(),
          SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text('Valider', style: TextStyle(color: Colors.white)),
              onPressed: () {
                print('VALIDER LE PANNIER');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityColumn(CartItem cartItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${cartItem.pizza.price} €'),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (cartItem.quantity > 1) {
                      cartItem.quantity--;
                    }
                  });
                },
              ),
              Text('${cartItem.quantity}'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    cartItem.quantity++;
                  });
                },
              ),
            ],
          )],
        ),
      ],
    );
  }

  Widget _buildTotalRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prix HT:'),
              Text('TVA:'),
              Text('Prix TTC:', style: PizzeriaStyle.priceTotalTextStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${(widget._cart.calculateTotal() * 0.8).toStringAsFixed(2)} €'),
              Text('${(widget._cart.calculateTotal() * 0.2).toStringAsFixed(2)} €'),
              Text('${widget._cart.calculateTotal().toStringAsFixed(2)} €', style: PizzeriaStyle.priceTotalTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
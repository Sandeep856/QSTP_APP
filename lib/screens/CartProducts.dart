import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var Cart_Products = [
    {
      'name': 'Blazer',
      'picture': 'assets/blazzer1.png',
      'price': '2000',
      'Size': 'XL',
      'Color': 'blue',
      'Quantity': '2',
    },
    {
      'name': 'Moblie Phone',
      'picture': 'assets/phone1.png',
      'price': '15000',
      'Size': '15',
      'Color': 'blue',
      'Quantity': '1',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Cart_Products.length,
        itemBuilder: (context, index) {
          return Sing_Cart(
              product_name: Cart_Products[index]['name'],
              product_picture: Cart_Products[index]['picture'],
              product_price: Cart_Products[index]['price'],
              Color: Cart_Products[index]['Color'],
              Quantity: Cart_Products[index]['Quantity'],
              Size: Cart_Products[index]['Size']);
        });
  }
}

class Sing_Cart extends StatefulWidget {
  final product_name;
  final product_picture;
  final product_price;
  final Size;
  final Color;
  final Quantity;
  Sing_Cart(
      {required this.product_name,
      required this.product_picture,
      required this.product_price,
      required this.Color,
      required this.Quantity,
      required this.Size});

  @override
  _Sing_CartState createState() => _Sing_CartState();
}

class _Sing_CartState extends State<Sing_Cart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: ListTile(
          leading: Container(
            child: Image.asset(
              widget.product_picture,
              width: 100.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Cart Product'),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Size:'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(widget.Size),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Color:'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(widget.Color),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_drop_up),
                        ),
                        Text('1'),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 7),
                alignment: Alignment.topLeft,
                child: Text(widget.product_price),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

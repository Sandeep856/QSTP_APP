import 'package:flutter/material.dart';
import 'package:qstp_app/Constants/constants.dart';
import 'package:qstp_app/screens/product_page.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCard(
      {required this.imageUrl,
      required this.productId,
      required this.onPressed,
      required this.price,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productid: productId,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageUrl",
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regularHeadings,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.yellow[900],
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

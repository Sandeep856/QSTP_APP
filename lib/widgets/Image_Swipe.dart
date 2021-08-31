import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List Images;
  ImageSwipe({required this.Images});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;
  int _pageview = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      height: 200,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _pageview = num;
              });
            },
            children: [
              for (var i = 0; i < widget.Images.length; i++)
                Container(
                  color: Colors.white,
                  child: Image.network(
                    '${widget.Images[i]}',
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 30.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.Images.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 7.0,
                    ),
                    padding: EdgeInsets.only(bottom: 10.0),
                    width: _pageview == i ? 30.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

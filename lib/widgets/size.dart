import 'package:flutter/material.dart';

class SizeofP extends StatefulWidget {
  final List Sizes;
  final Function(String) onselect;
  SizeofP({required this.Sizes, required this.onselect});

  @override
  _SizeofPState createState() => _SizeofPState();
}

class _SizeofPState extends State<SizeofP> {
  int select = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (var i = 0; i < widget.Sizes.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  widget.onselect('${widget.Sizes[i]}');
                  setState(() {
                    select = i;
                  });
                },
                child: Container(
                    height: 30.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: select == i ? Colors.blue : Colors.grey[200],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.Sizes[i]}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: select == i ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}

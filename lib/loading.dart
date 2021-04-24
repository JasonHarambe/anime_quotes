import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * .2),
        Expanded(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * .3,
              decoration: BoxDecoration(
                  color: Colors.redAccent[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 5),
                    )
                  ]),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: 120,
            height: 50,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

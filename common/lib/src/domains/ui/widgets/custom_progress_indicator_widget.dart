import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomProgressIndicatorWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CustomProgressIndicator extends StatelessWidget
    implements CustomProgressIndicatorWidgetInterface {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Color.fromARGB(100, 105, 105, 105),
        ),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: CupertinoActivityIndicator(radius: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

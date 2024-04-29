import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String? label;

  const LoadingIndicatorWidget({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
          ),
          CircularProgressIndicator.adaptive(
            backgroundColor: Colors.lightGreen,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            label ?? '',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

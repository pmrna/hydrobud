import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String? label;

  const LoadingIndicatorWidget({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 120,
          ),
          const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.lightGreen,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            label ?? '',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

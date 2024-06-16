import 'package:flutter/material.dart';

class IrrigationCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color borderColor;
  final VoidCallback onTap;

  const IrrigationCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 115,
          decoration: BoxDecoration(
              color: borderColor,
              border: Border.all(
                color: borderColor,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 4),
                ),
              ]),
          child: Text(
            title,
            style: const TextStyle(
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

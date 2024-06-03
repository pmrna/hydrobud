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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          alignment: Alignment.center,
          height: 140,
          decoration: BoxDecoration(
            color: borderColor,
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

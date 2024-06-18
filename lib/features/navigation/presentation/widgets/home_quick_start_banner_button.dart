import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';
import 'package:hydrobud/features/navigation/presentation/pages/wrapper.dart';

class QuickStartBannerButton extends StatelessWidget {
  const QuickStartBannerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Wrapper(initialIndex: 2),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 4,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: AppPallete.textColorGray,
                size: 30,
              ),
              Text(
                'Click here to start irrigation',
                style: TextStyle(color: AppPallete.textColorBlack3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

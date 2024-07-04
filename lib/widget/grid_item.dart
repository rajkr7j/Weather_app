import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
  });
  final String title;
  final String data;
  final String icon;

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 43, 59),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(131, 255, 255, 255), fontSize: 15),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: (width - 100) / 4,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      data,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    icon,
                    fit: BoxFit.cover,
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

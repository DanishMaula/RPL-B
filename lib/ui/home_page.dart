import 'package:flutter/material.dart';
import 'package:rpl_b/utils/style_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [

        // Header

        Row(
          children: [
            Column(
              children: [
                Text(
                  "Miqmeq",
                  style: getBlackTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "For RPL B Exhibition",
                  style: getBlackTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Container(
              width: 45,
              height: 45,
              child: Image.asset(""),
            ),
          ],
        ),
      ],
    ));
  }
}



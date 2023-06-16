// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rpl_b/utils/style_manager.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    this.onLogout,
  }) : super(key: key);

  final void Function()? onLogout;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure to logout?',
              style: getBlackTextStyle(),
            ),
            SizedBox(height: 16.0),
            LottieBuilder.asset(
                'assets/lottie/logout_lottie.json'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: getBlackTextStyle(),
                  ),
                ),
                TextButton(
                  onPressed: onLogout,
                  child: Text(
                    'Logout',
                    style: getBlackTextStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

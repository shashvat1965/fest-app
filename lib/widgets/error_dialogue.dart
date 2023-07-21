import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/ui_utils.dart';
import '../widgets/OkButton.dart';

class ErrorDialog extends StatefulWidget {
  ErrorDialog(
      {Key? key, this.errorMessage, this.isFatalError, this.isSuccesspopup})
      : super(key: key);
  String? errorMessage;
  bool? isFatalError;
  bool? isSuccesspopup;

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {



  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        width: UIUtills().getProportionalWidth(width: 408),
        height: UIUtills().getProportionalHeight(
            height: widget.isSuccesspopup == true ? 450 : 650),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: UIUtills().getProportionalHeight(
                      height: widget.isSuccesspopup == true ? 100 : 80),
                  left: UIUtills().getProportionalWidth(width: 70),
                  right: UIUtills().getProportionalWidth(width: 70)),
              child: SvgPicture.asset(
                widget.isSuccesspopup == true
                    ? 'assets/images/greenTick.svg'
                    : 'assets/images/error.svg',
                height: UIUtills().getProportionalHeight(
                    height: widget.isSuccesspopup == true ? 100 : 335),
                width: UIUtills().getProportionalWidth(width: 268),
              ),
            ),
            SizedBox(
              height: UIUtills().getProportionalHeight(height: 32),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: UIUtills().getProportionalHeight(
                      height: widget.isSuccesspopup == true ? 50 : 35),
                  left: UIUtills().getProportionalWidth(width: 50),
                  right: UIUtills().getProportionalWidth(width: 50),
                  top: UIUtills().getProportionalHeight(height: 10)),
              child: Text(
                widget.errorMessage ?? 'Loading...',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            (widget.isFatalError == null || widget.isFatalError == false)
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: OkButton())
                : Container()
          ],
        ),
      ),
    );
  }
}

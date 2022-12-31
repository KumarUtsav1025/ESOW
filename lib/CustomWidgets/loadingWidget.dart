import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';

import '../Constants/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: LoadingAnimationWidget.threeArchedCircle(
                size: 200, color: C.gradientColor3,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Loading",
                  style: GoogleFonts.roboto(fontSize: 25.0, fontWeight: FontWeight.w800, color: C.gradientColor3),
                ),
                const SizedBox(width: 7.0,),
                LoadingAnimationWidget.prograssiveDots(
                  size: 50, color: C.gradientColor3,
                ),
              ],
            ),
          ],
        )
    );
  }
}

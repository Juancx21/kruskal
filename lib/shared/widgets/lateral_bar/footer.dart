import 'package:flutter/material.dart';
import 'package:kruskal/shared/utils/others/globalvariables.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 320,
      alignment: Alignment.bottomCenter,
      padding: UiSpacing.bottomMicromedium(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Juancx ©"),
          Container(margin: UiSpacing.xMicromedium(), child: const Text("|")),
          const Text("Make in"),
          const SizedBox(
            width: UiSpacing.microSpaceNormal,
          ),
          Image.asset(
            "${imgpath}flutter-logo.png",
            height: 12,
          )
        ],
      ),
    );
  }
}

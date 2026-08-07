
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/asset_path.dart';

//----This is Screen Background Widget (ScreenBG) ----------//

class ScreenBG extends StatelessWidget {
  final Widget child;
  const ScreenBG({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
           width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
            AssetPath.backgroundImg),child
      ],
    );
  }
}
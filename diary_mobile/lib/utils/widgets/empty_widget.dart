import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconAsset.icEmpty),
            const SizedBox(
              height: 27.56,
            ),
            Text(
              S.of(context).empty,
              style: StyleBkav.textStyleFW400(
                  AppColor.black22, 18),
            )
          ],
        ),
      ),
    );
  }
}
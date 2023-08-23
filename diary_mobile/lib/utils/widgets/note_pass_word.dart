
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';

class NotePassWord extends StatelessWidget {
  const NotePassWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).note,
              style: StyleOfit.textStyleFW700(AppColor.main, 14),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              S.of(context).pass_have,
              style: StyleOfit.textStyleFW400(AppColor.gray70, 12),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const CircleAvatar(
                  backgroundColor: AppColor.main,
                  radius: 3,
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        text: S.of(context).pass_have_length,
                        style: StyleOfit.textStyleFW400(AppColor.gray70, 12),
                        children:  <TextSpan>[
                          TextSpan(
                            text: S.of(context).pass_have_length_8,
                            style:  StyleOfit.textStyleFW700(AppColor.gray70, 12),
                          )
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const CircleAvatar(
                  backgroundColor: AppColor.main,
                  radius: 3,
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: S.of(context).pass_have_not_contain_space,
                        style: StyleOfit.textStyleFW700(AppColor.gray70, 12),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children:  [
                const CircleAvatar(
                  backgroundColor: AppColor.main,
                  radius: 3,
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: S.of(context).pass_have_have,
                        style: StyleOfit.textStyleFW700(AppColor.gray70, 12),
                        children:  <TextSpan>[
                          TextSpan(
                            text: S.of(context).pass_have_special,
                            style:  StyleOfit.textStyleFW400(AppColor.gray70, 12),
                          )
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              S.of(context).pass_have_vd,
              style: StyleOfit.textStyleFW400(AppColor.gray70, 12),
            ),
          ],
        ));
  }
}

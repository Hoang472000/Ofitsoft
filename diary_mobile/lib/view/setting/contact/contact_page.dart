import 'package:diary_mobile/utils/widgets/view_page_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(const ContactPage(), true);
  }

  @override
  State<StatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>  with TickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.97, end: 1.03).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack));
    _animationController.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _animationController.reverse();
      else if (status == AnimationStatus.dismissed)
        _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColor.background,
          appBar: OfitAppBar(
            context,
            showDefaultBackButton: true,
            centerTitle: true,
            title: Text(
              S.of(context).contact,
              style: StyleOfit.textStyleFW700(AppColor.whiteF2, 20),
            ),
            //backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
         /*   decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAsset.imageOfitsoftText),
                  fit: BoxFit.scaleDown
              ),
              color: AppColor.whiteF2,
              //color: AppColor.orangeF8,
            ),*/
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    //margin: const EdgeInsets.symmetric(vertical: 15),
                    //padding: const EdgeInsets.all(10),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                        AssetImage(ImageAsset.imageTeamSupport),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.darken
                        ),),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RotationTransition(
                            turns: _animation,
                            child: const Image(
                              image: AssetImage(ImageAsset.imageOfitsoftText),/* opacity: const AlwaysStoppedAnimation(.9),*/ height: 100,)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hỗ trợ hỏi đáp 24/7",
                            style:
                            StyleOfit.textStyleFW600(Colors.white, 18),
                          ),
                        ),
                          ],
                    )),
                Expanded(
                  child: Container(
                    width: double.infinity,
                  /*  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          AssetImage(ImageAsset.imageContactBackgroundBottom),
                          fit: BoxFit.fill),
                    ),*/
                    margin: const EdgeInsets.only(top: 10),
                    //padding: const EdgeInsets.only(top: 75),
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(left: 16, right: 18),
                      child: SingleChildScrollView(
                        physics:
                        const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: SvgPicture.asset(IconAsset.icPhone, color: AppColor.main, width: 25,),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16,),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Utils.launchPhoneUrl("+84 989426911");
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10.0),
                                                  child: Text(
                                                    "Liên hệ kỹ thuật:",
                                                    style: StyleOfit.textStyleFW400(
                                                        AppColor.main, 15),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0,
                                                      bottom: 10),
                                                  child: Text(
                                                    "+84 989426911",
                                                    style: StyleOfit
                                                        .textStyleFW400(
                                                        AppColor.black22,
                                                        15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const Divider(color: AppColor.grayE8,thickness: 1,),
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: DottedLine(dashColor: AppColor.gray9B,),
                            ),
                            const SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Utils.launchMailUrl("info@ofitsoft.com");
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //SvgPicture.asset(IconAsset.icEmail, color: AppColor.red11,),
                                      Icon(Icons.mail_outline, color: AppColor.red11, size: 25,),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16),
                                          child: Text(
                                              "info@ofitsoft.com",
                                              style: StyleOfit.textStyleFW400(
                                                  AppColor.black22, 15, overflow: TextOverflow.visible)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // const Divider(color: AppColor.grayE8,thickness: 1,),
                            const SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Utils.launchInBrowser("https://ofitsoft.vn/");
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(IconAsset.icWebsite, color: AppColor.blue15, width: 25,),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16),
                                          child: Text(
                                              "ofitsoft.vn",
                                              style: StyleOfit.textStyleFW400(
                                                  AppColor.black22, 15, overflow: TextOverflow.visible)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Utils.launchInBrowser("https://www.facebook.com/profile.php?id=61550762402696");
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(IconAsset.icFacebook, color: AppColor.blue15, width: 25,),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16),
                                          child: Text(
                                              "https://www.facebook.com/ofitsoft",
                                              style: StyleOfit.textStyleFW400(
                                                  AppColor.black22, 15, overflow: TextOverflow.visible)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: DottedLine(dashColor: AppColor.gray9B,),
                            ),
                            const SizedBox(height: 8,),
                            InkWell(
                              onTap: () {
                                Utils.launchInBrowser("https://masothue.com/0110264534-cong-ty-co-phan-phan-mem-nong-nghiep-toi-uu");
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(ImageAsset.imageOfitsoft),
                                      width: 25,
                                      fit: BoxFit.contain,
                                    ),
                                    //SvgPicture.asset(IconAsset.ic, color: AppColor.red11, width: 25,),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 16),
                                        child: Text(
                                          "CÔNG TY CỔ PHẦN PHẦN MỀM NÔNG NGHIỆP TỐI ƯU",
                                          style: const TextStyle(
                                              color: AppColor.black22,
                                              fontSize: 15,
                                              height: 1.2,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            InkWell(
                              onTap: () {
                                Utils.launchMapUrl("số 4 ngõ 12 phố Lương Khánh Thiện, phường Tương Mai, quận Hoàng Mai, Hà Nội");
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(IconAsset.icHome2, color: AppColor.red11, width: 25,),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 16),
                                        child: Text(
                                          "số 4/12 phố Lương Khánh Thiện, phường Tương Mai, quận Hoàng Mai, Hà Nội",
                                          style: const TextStyle(
                                              color: AppColor.black22,
                                              fontSize: 15,
                                              height: 1.2,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

}

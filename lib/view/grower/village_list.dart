import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/village_list_controller.dart';
import 'package:dwarikesh/model/villagewise_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VillagewiseList extends StatelessWidget {
  VillageWiseListController _controller = Get.put(VillageWiseListController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: Toolbar(
          title: 'grower_list'.tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            GetBuilder<VillageWiseListController>(builder: (controller) {
              if (_controller.responseCode == '200')
                return _controller.resListData.length > 0
                    ? Padding(
                        padding: EdgeInsets.all(15),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2,
                          children: List.generate(
                              _controller.resListData.length, (index) {
                            var data = _controller.resListData[index];
                            return villageTile(
                              model: data,
                            );
                          }),
                        ),
                      )
                    : ErrorMessage(
                        errorCode: '403',
                      );
              else if (_controller.responseCode == '404')
                return ErrorMessage(
                  errorCode: '404',
                );
              else if (_controller.responseCode == '500')
                return ErrorMessage(
                  errorCode: '500',
                );
              else
                return ErrorMessage(
                  errorCode: '403',
                );
            })
          ]),
        ),
      ),
    );
  }
}

class villageTile extends StatelessWidget {
  Data? model;
  villageTile({this.model});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Prefs.setString(VILLAGE_ID, model!.villageid.toString());
        Get.toNamed(ROUTE_GROWER_LIST);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            titleMessage(context, 'village'.tr,
                model!.villagename!.capitalizeFirst!, 16.0, 16.0),
            titleMessage(context, 'growers'.tr, model!.growercount.toString(),
                20.0, 20.0),
          ],
        ),
      ),
    );
  }

  Widget titleMessage(BuildContext context, String title, String message,
      var titleSize, var msgSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
                fontSize: titleSize,
                fontWeight: TextUtils.titleTextWeight)),
        SizedBox(
          height: 4.h,
        ),
        Text(message,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: msgSize,
                color: primaryColor,
                fontWeight: TextUtils.titleTextWeight)),
      ],
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}

import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/grower_list_controller.dart';
import 'package:dwarikesh/model/gower_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GrowerList extends StatelessWidget {
  GrowerListController _controller = Get.put(GrowerListController());

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
            GetBuilder<GrowerListController>(builder: (controller) {
              if (_controller.responseCode == '200')
                return _controller.resListData.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _controller.resListData.length,
                        itemBuilder: (context, index) {
                          var data = _controller.resListData[index];
                          return GowerTile(
                            model: data,
                          );
                        })
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

class GowerTile extends StatelessWidget {
  Data? model;

  GowerTile({this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Prefs.setString(GROWER_ID, model!.id.toString());
        Get.toNamed(ROUTE_CFA_REPORT_GROWER_DETAIL,
            arguments: model!.id.toString());
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x1f000000),
              offset: Offset(0, 3),
              blurRadius: 14,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              '${model!.growername} - ${model!.growercode}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16, color: textColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '${model!.fathername} ',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: textColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              ' ${'plot'.tr} : ${model!.culturableareaha}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: textColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '${model!.village!.capitalizeFirst}  - ${model!.district}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: textColor),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '${model!.state}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: textColor),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          launch("tel://" + model!.phonenumber!);
                        },
                        child: Container(
                          width: 56,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 1,
                                    offset: Offset(0, 3))
                              ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'call'.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../controller/form2_controller.dart';
import '../../controller/form1_controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/textUtils.dart';
import '../../widgets/Prograssbar.dart';

class Form2 extends StatefulWidget {
  const Form2({Key? key}) : super(key: key);

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final form2Controller = Get.put(Form2Controller());
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Demo Activities Update"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: GetBuilder<Form2Controller>(
        builder: ((controller) => controller.isLoading.value ||
                controller.autofillData.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: true,
                            enabled: false,
                            focusNode: controller.node1,
                            style: TextStyle(
                              color: textColor,
                              fontSize: TextUtils.hintTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                            controller: controller.villageCodeText,
                            decoration: InputDecoration(
                                // suffixIcon: controller.searchVillage.value
                                //     ? InkWell(
                                //         child: Icon(
                                //           Icons.search,
                                //           color: Colors.grey,
                                //         ),
                                //         onTap: () async {
                                //           Get.dialog(Progressbar());
                                //           controller.callVillageApi(
                                //               controller.villageCodeText.text);
                                //           controller.update();
                                //         },
                                //       )
                                //     : null,
                                labelText: 'Village Code',
                                labelStyle: TextStyle(fontSize: 14)),
                            // onChanged: (value) {
                            //   if (value.length != 0)
                            //     controller.villageBoolChange();
                            //   controller.update();
                            // },
                          ),
                        ),
                        Container(
                          width: 240,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(
                              color: textColor,
                              fontSize: TextUtils.hintTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                            controller: controller.villageNameText,
                            // ..text = controller.villageName.value,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Village Name",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            // onChanged: (pattern) async {
                            //   if (response.statusCode == 200) {
                            //     Map<String, dynamic> userss =
                            //         json.decode(response.body);
                            //     List<dynamic> users = userss["items"];

                            //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                            //     //  final nameLower = user.title!.toLowerCase();
                            //     //  final queryLower = query.toLowerCase();
                            //     //  return nameLower.contains(queryLower);
                            //     //  }).toList();
                            //   } else {
                            //     throw Exception();
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        focusNode: controller.node2,
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerCodeText,
                        decoration: InputDecoration(
                            // suffixIcon: controller.searchFarmer.value
                            //     ? InkWell(
                            //         child: Icon(
                            //           Icons.search,
                            //           color: Colors.black,
                            //         ),
                            //         onTap: () async {
                            //           Get.dialog(Progressbar());
                            //           controller.callGrowerApi(
                            //               controller.growerCodeText.text);
                            //           controller.update();
                            //         },
                            //       )
                            //     : null,
                            labelText: 'Farmer Code',
                            labelStyle: TextStyle(fontSize: 14)),
                        // onChanged: (value) async {
                        //   if (value.length != 0) controller.farmerBoolChange();
                        //   controller.update();
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerNameText,
                        // ..text = controller.farmerName.value,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        // onChanged: (pattern) async {
                        //   if (response.statusCode == 200) {
                        //     Map<String, dynamic> userss =
                        //         json.decode(response.body);
                        //     List<dynamic> users = userss["items"];

                        //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                        //     //  final nameLower = user.title!.toLowerCase();
                        //     //  final queryLower = query.toLowerCase();
                        //     //  return nameLower.contains(queryLower);
                        //     //  }).toList();
                        //   } else {
                        //     throw Exception();
                        //   }
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerFatherNameText,
                        // ..text = controller.fatherName.value,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Father Name",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        // onChanged: (pattern) async {
                        //   if (response.statusCode == 200) {
                        //     Map<String, dynamic> userss =
                        //         json.decode(response.body);
                        //     List<dynamic> users = userss["items"];

                        //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                        //     //  final nameLower = user.title!.toLowerCase();
                        //     //  final queryLower = query.toLowerCase();
                        //     //  return nameLower.contains(queryLower);
                        //     //  }).toList();
                        //   } else {
                        //     throw Exception();
                        //   }
                        // },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 180,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: true,
                            enabled: false,
                            style: TextStyle(fontSize: 18),
                            focusNode: controller.node3,
                            controller: controller.varietyCodeText,
                            decoration: InputDecoration(
                              // suffixIcon: controller.searchVeriety.value
                              //     ? InkWell(
                              //         child: Icon(
                              //           Icons.search,
                              //           color: Colors.black,
                              //         ),
                              //         onTap: () async {
                              //           Get.dialog(Progressbar());
                              //           controller.callVarietyApi(
                              //               controller.varietyCodeText.text);
                              //           controller.update();
                              //         },
                              //       )
                              //     : null,
                              labelText: 'Variety Code',
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            // onChanged: (value) async {
                            //   if (value.length != 0)
                            //     controller.verietyBoolChange();
                            //   controller.update();
                            // },
                          ),
                        ),
                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controller.varietyNameText,
                            // ..text = controller.varietyName.value,
                            readOnly: true,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: "Variety Name",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            // onChanged: (pattern) async {
                            //   if (response.statusCode == 200) {
                            //     Map<String, dynamic> userss =
                            //         json.decode(response.body);
                            //     List<dynamic> users = userss["items"];

                            //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                            //     //  final nameLower = user.title!.toLowerCase();
                            //     //  final queryLower = query.toLowerCase();
                            //     //  return nameLower.contains(queryLower);
                            //     //  }).toList();
                            //   } else {
                            //     throw Exception();
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),

                    Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: controller.cropTypeText,
                          // ..text = controller.varietyName.value,
                          readOnly: true,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Crop Type",
                            labelStyle: TextStyle(fontSize: 14),
                          ),
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: DropdownButtonFormField(
                    //     hint: Text(
                    //       controller.cropType.value,
                    //       style: TextStyle(
                    //           // fontSize: 14,
                    //           // color:
                    //           //  growerController.currentFactoryName.value == "Crob Type"
                    //           //     ?
                    //           // Colors.grey[400],
                    //           // : textColor,
                    //           // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                    //           ),
                    //     ),
                    //     isExpanded: true,
                    //     icon: Icon(Icons.arrow_drop_down),
                    //     iconSize: 25,
                    //     style: TextStyle(color: textColor),
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     items: controller.cropTypeList.map(
                    //       (val) {
                    //         return DropdownMenuItem<String>(
                    //           value: val.name,
                    //           child: Text(
                    //             val.name!,
                    //             style: TextStyle(
                    //               color: textColor,
                    //               fontSize: TextUtils.hintTextSize,
                    //               fontWeight: TextUtils.titleTextWeight,
                    //               fontStyle: FontStyle.normal,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ).toList(),
                    //     onChanged: (val) {
                    //       controller.updateCropType(val);
                    //       print("val:    ${controller.cropType.value}");
                    //     },
                    //   ),
                    // ),
                    Row(
                      children: [
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            focusNode: controller.node4,
                            style: TextStyle(fontSize: 18),
                            controller: controller.plotEntityCodeText,
                            decoration: InputDecoration(
                                suffixIcon: controller.searchVillage.value
                                    ? InkWell(
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        onTap: () async {
                                          Get.dialog(Progressbar());
                                          controller.callEntityCodeApi(
                                              controller
                                                  .plotEntityCodeText.text);
                                          controller.update();
                                        },
                                      )
                                    : null,
                                labelText: 'Activity Code',
                                labelStyle: TextStyle(fontSize: 14)),
                            onChanged: (value) {
                              if (value.length != 0)
                                controller.villageBoolChange();
                              controller.update();
                            },
                          ),
                        ),
                        Container(
                          width: 240,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controller.plotEntityCodeNameText
                              ..text = controller.codeName.value,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Activity Name",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? date = DateTime.now();

                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          controller.dateText.value =
                              DateFormat("yyyy-MM-dd").format(date!);
                        },
                        controller: controller.valueDateText
                          ..text = controller.dateText.value,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Activity Date",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.valueString.value,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                //  growerController.currentFactoryName.value == "Crob Type"
                                //     ?
                                Colors.grey[400],
                            // : textColor,
                            // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: controller.valueCharList.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val.string,
                              child: Text(
                                val.string!,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.titleTextWeight,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.updateValueString(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                                controller: controller.valueNumberText,
                                decoration: InputDecoration(
                                  labelText: 'Input Qty',
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Text("Nos :"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: DropdownButtonFormField(
                                hint: Text(
                                  controller.unitString.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        //  growerController.currentFactoryName.value == "Crob Type"
                                        //     ?
                                        Colors.grey[400],
                                    // : textColor,
                                    // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                                  ),
                                ),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 25,
                                style: TextStyle(color: textColor),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                items: controller.measureList.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val.name,
                                      child: Text(
                                        val.name!,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: TextUtils.hintTextSize,
                                          fontWeight: TextUtils.titleTextWeight,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  controller.updateValueString(val);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        // enabled: false,
                        onTap: () {
                          bottomSheet(context, controller);
                        },
                        controller: controller.fileNameText
                          ..text = controller.fileName.value,
                        style: TextStyle(fontSize: 18),
                        // controller: controller.textController10,
                        decoration: InputDecoration(
                          labelText: "Photo Capture",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    controller.fileName.value != ""
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                                height: 100,
                                width: 100,
                                child: Image.file(controller.image!)),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        enabled: true,
                        controller: controller.plotGpsCoordinatesText
                          ..text = !controller.plotGpsCoordinates.isNull
                              ? "Lat : ${controller.plotGpsCoordinates!.latitude}, Long : ${controller.plotGpsCoordinates!.longitude}"
                              : "",
                        style: TextStyle(fontSize: 18),
                        // controller: controller.textController10,
                        decoration: InputDecoration(
                          labelText: "Plot GPS Coordinates",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        // readOnly: true,
                        controller: controller.remarksText,
                        style: TextStyle(fontSize: 18),
                        // controller: controller.textController11,
                        decoration: InputDecoration(
                          labelText: "Remarks (if any)",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () => (
                                  // controller
                                  //           .villageCodeText.text.isEmpty ||
                                  //       controller.villageCodeText.text == "" ||
                                  //       controller.villageName.value.isEmpty ||
                                  //       controller.villageName.value == "" ||
                                  //       controller.growerCodeText.text.isEmpty ||
                                  //       controller.growerCodeText.text == "" ||
                                  //       controller.growerNameText.text.isEmpty ||
                                  //       controller.growerNameText.text == "" ||
                                  //       controller
                                  //           .growerFatherNameText.text.isEmpty ||
                                  //       controller.growerFatherNameText.text == "" ||
                                  // controller.cropType.value.isEmpty ||
                                  //     controller.cropType.value ==
                                  //         "Crop Type" ||
                                  // controller.varietyCodeText.text.isEmpty ||
                                  // controller.varietyCodeText.text == "" ||
                                  // controller.varietyNameText.text.isEmpty ||
                                  // controller.varietyNameText.text == "" ||
                                  controller.plotEntityCodeText.text.isEmpty ||
                                      controller.plotEntityCodeText.text ==
                                          "" ||
                                      controller.plotEntityCodeNameText.text
                                          .isEmpty ||
                                      controller.plotEntityCodeNameText.text ==
                                          "" ||
                                      controller.dateText.value.isEmpty ||
                                      controller.dateText.value == "" ||
                                      controller.image.isNull ||
                                      controller.image == "" ||
                                      controller.plotGpsCoordinatesText.text
                                          .isEmpty ||
                                      controller.plotGpsCoordinatesText.text ==
                                          "")
                              ? Get.snackbar(
                                  "Error", "Fill All the Required Fields",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP)
                              : controller.onSubmit(),
                          // controller.villageCode.value,
                          // controller.villageName.value,
                          // controller.growerCodeText.text,
                          // controller.growerNameText.text,
                          // controller.growerFatherNameText.text,
                          // controller.cropType.value,
                          // controller.varietyCodeText.text,
                          // controller.varietyNameText.text,
                          // controller.plotEntityCodeText.text,
                          // controller.plotEntityCodeNameText.text,
                          // controller.dateText.value,
                          // controller.valueNumberText.text,
                          // controller.valueString.value ?? null,
                          // controller.image!,
                          // controller.remarksText.text,
                          // controller.plotGpsCoordinates!.latitude
                          //     .toString(),
                          // controller.plotGpsCoordinates!.longitude
                          //     .toString()),
                          child: Container(
                            color: primaryColor,
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              )),
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context, Form2Controller controller) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 140,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        controller.getImage(ImageSource.gallery);
                      },
                      child: Icon(Icons.insert_photo_outlined,
                          size: 40, color: Colors.white),
                    )
                    // onPressed: () {
                    // },
                    // child: Text("PICK FROM GALLERY"),
                    ),
                Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        controller.getImage(
                          ImageSource.camera,
                        );
                      },
                      child:
                          Icon(Icons.camera_alt, size: 40, color: Colors.white),
                    )
                    // onPressed: () {
                    // },
                    // child: Text("PICK FROM GALLERY"),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

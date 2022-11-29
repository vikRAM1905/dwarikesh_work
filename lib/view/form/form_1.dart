import 'dart:async';
import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../controller/form1_controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/textUtils.dart';
import '../../widgets/Prograssbar.dart';

class Form1 extends StatefulWidget {
  const Form1({Key? key}) : super(key: key);

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  final formController = Get.put(FormController());
  AutoCompleteTextField? searchTextField;
  AutoCompleteTextField? searchTextField2;
  AutoCompleteTextField? searchTextField3;
  final TextEditingController autocompleteTextfield = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final TextEditingController autocompleteTextfield2 = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  final TextEditingController autocompleteTextfield3 = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key3 = new GlobalKey();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Demo Plot Header Information"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: GetBuilder<FormController>(
        builder: ((controller) => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: searchTextField = AutoCompleteTextField<String>(
                        controller: controller.villageCodeText
                          ..text = controller.villageSelect.value,
                        key: key,
                        suggestions: controller.result,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: new InputDecoration(
                            // suffixIcon: Container(
                            //   width: 85.0,
                            //   height: 60.0,
                            // ),
                            // contentPadding:
                            //     EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            filled: true,
                            labelText: 'Village Code',
                            labelStyle: TextStyle(fontSize: 14)),
                        itemFilter: (item, query) {
                          return item
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            controller.villageSelect.value = item.toString();
                            searchTextField!.textField!.controller!.text =
                                item.toString();
                            controller.update();
                            controller.callGrowerApi();
                          });
                        },
                        itemBuilder: (context, item) {
                          return Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.symmetric(
                                    vertical: BorderSide(),
                                    horizontal: BorderSide.none,
                                  )),
                              child: Text(item,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)));
                        },
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TypeAheadField(
                    //       textFieldConfiguration: TextFieldConfiguration(
                    //           // autofocus: true,
                    //           // style: DefaultTextStyle.of(context)
                    //           //     .style
                    //           //     .copyWith(fontStyle: FontStyle.italic),
                    //           decoration:
                    //               InputDecoration(border: OutlineInputBorder()),
                    //           controller: controller.villageCodeText),
                    //       suggestionsCallback: (pattern) async {
                    //         Completer<List<String>> completer = new Completer();
                    //         completer.complete(controller.result);
                    //         return completer.future;
                    //       },
                    //       itemBuilder: (context, suggestion) {
                    //         return ListTile(title: Text(suggestion.toString()));
                    //       },
                    //       onSuggestionSelected: (suggestion) {
                    //         controller.villageCodeText.text =
                    //             suggestion.toString();
                    //       }),
                    // ),
                    // TypeAheadFormField(
                    //   textFieldConfiguration: TextFieldConfiguration(
                    //       controller: controller.villageCodeText,
                    //       decoration: InputDecoration(labelText: 'City')),
                    //   suggestionsCallback: (pattern) {
                    //     return controller.callVillageApi(pattern);
                    //   },
                    //   itemBuilder: (context, suggestion) {
                    //     return ListTile(
                    //       title: Text(suggestion.toString()),
                    //     );
                    //   },
                    //   transitionBuilder: (context, suggestionsBox, controller) {
                    //     return suggestionsBox;
                    //   },
                    //   onSuggestionSelected: (suggestion) {
                    //     controller.villageCodeText.text = suggestion.toString();
                    //   },
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please select a city';
                    //     }
                    //   },
                    //   onSaved: (value) => controller.selectedCity = value,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 150,
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: TextField(
                    //         focusNode: controller.node1,
                    //         style: TextStyle(
                    //           color: textColor,
                    //           fontSize: TextUtils.hintTextSize,
                    //           fontWeight: TextUtils.titleTextWeight,
                    //           fontStyle: FontStyle.normal,
                    //         ),
                    //         controller: controller.villageCodeText,
                    //         decoration: InputDecoration(
                    //             suffixIcon: controller.searchVillage.value
                    //                 ? InkWell(
                    //                     child: Icon(
                    //                       Icons.search,
                    //                       color: Colors.grey,
                    //                     ),
                    //                     onTap: () async {
                    //                       Get.dialog(Progressbar());
                    //                       // controller.callVillageApi(
                    //                       //     controller.villageCodeText.text);
                    //                       controller.update();
                    //                     },
                    //                   )
                    //                 : null,
                    //             labelText: 'Village Code',
                    //             labelStyle: TextStyle(fontSize: 14)),
                    //         onChanged: (value) {
                    //           if (value.length != 0)
                    //             controller.villageBoolChange();
                    //           controller.update();
                    //         },
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 240,
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: TextField(
                    //         style: TextStyle(
                    //           color: textColor,
                    //           fontSize: TextUtils.hintTextSize,
                    //           fontWeight: TextUtils.titleTextWeight,
                    //           fontStyle: FontStyle.normal,
                    //         ),
                    //         controller: controller.villageNameText
                    //           ..text = controller.villageName.value,
                    //         readOnly: true,
                    //         enabled: false,
                    //         decoration: InputDecoration(
                    //           labelText: "Village Name",
                    //           labelStyle: TextStyle(fontSize: 14),
                    //         ),
                    //         // onChanged: (pattern) async {
                    //         //   if (response.statusCode == 200) {
                    //         //     Map<String, dynamic> userss =
                    //         //         json.decode(response.body);
                    //         //     List<dynamic> users = userss["items"];

                    //         //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                    //         //     //  final nameLower = user.title!.toLowerCase();
                    //         //     //  final queryLower = query.toLowerCase();
                    //         //     //  return nameLower.contains(queryLower);
                    //         //     //  }).toList();
                    //         //   } else {
                    //         //     throw Exception();
                    //         //   }
                    //         // },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: searchTextField2 = AutoCompleteTextField<String>(
                        controller: controller.growerCodeText
                          ..text = controller.growerSelect.value,
                        key: key2,
                        suggestions: controller.growerCodeList,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: new InputDecoration(
                            // suffixIcon: Container(
                            //   width: 85.0,
                            //   height: 60.0,
                            // ),
                            // contentPadding:
                            //     EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            filled: true,
                            labelText: 'Grower Code',
                            labelStyle: TextStyle(fontSize: 14)),
                        itemFilter: (item, query) {
                          return item
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            controller.growerSelect.value = item.toString();
                            searchTextField2!.textField!.controller!.text =
                                item.toString();
                            controller.update();
                            controller
                                .getFatherName(controller.growerSelect.value);
                          });
                        },
                        itemBuilder: (context, item) {
                          return Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.symmetric(
                                    vertical: BorderSide(),
                                    horizontal: BorderSide.none,
                                  )),
                              child: Text(item,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)));
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     focusNode: controller.node2,
                    //     style: TextStyle(fontSize: 18),
                    //     controller: controller.growerCodeText,
                    //     decoration: InputDecoration(
                    //         suffixIcon: controller.searchFarmer.value
                    //             ? InkWell(
                    //                 child: Icon(
                    //                   Icons.search,
                    //                   color: Colors.black,
                    //                 ),
                    //                 onTap: () async {
                    //                   Get.dialog(Progressbar());

                    //                   controller.update();
                    //                 },
                    //               )
                    //             : null,
                    //         labelText: 'Farmer Code',
                    //         labelStyle: TextStyle(fontSize: 14)),
                    //     onChanged: (value) async {
                    //       if (value.length != 0) controller.farmerBoolChange();
                    //       controller.update();
                    //     },
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     style: TextStyle(fontSize: 18),
                    //     controller: controller.growerNameText
                    //       ..text = controller.farmerName.value,
                    //     readOnly: true,
                    //     enabled: false,
                    //     decoration: InputDecoration(
                    //       labelText: "Name",
                    //       labelStyle: TextStyle(fontSize: 14),
                    //     ),
                    //     // onChanged: (pattern) async {
                    //     //   if (response.statusCode == 200) {
                    //     //     Map<String, dynamic> userss =
                    //     //         json.decode(response.body);
                    //     //     List<dynamic> users = userss["items"];

                    //     //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                    //     //     //  final nameLower = user.title!.toLowerCase();
                    //     //     //  final queryLower = query.toLowerCase();
                    //     //     //  return nameLower.contains(queryLower);
                    //     //     //  }).toList();
                    //     //   } else {
                    //     //     throw Exception();
                    //     //   }
                    //     // },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerFatherNameText
                          ..text = controller.growerFatherSelect.value,
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
                          child: searchTextField3 =
                              AutoCompleteTextField<String>(
                            controller: controller.varietyCodeText
                              ..text = controller.varietySelect.value,
                            key: key3,
                            suggestions: controller.varietyCodeList,
                            style: new TextStyle(
                                color: Colors.black, fontSize: 16.0),
                            decoration: new InputDecoration(
                                // suffixIcon: Container(
                                //   width: 85.0,
                                //   height: 60.0,
                                // ),
                                // contentPadding:
                                //     EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                filled: true,
                                labelText: 'Variety Code',
                                labelStyle: TextStyle(fontSize: 14)),
                            itemFilter: (item, query) {
                              return item
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.compareTo(b);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                controller.varietySelect.value =
                                    item.toString();
                                searchTextField3!.textField!.controller!.text =
                                    item.toString();
                                controller.update();
                                controller.getVarietyName(
                                    controller.varietySelect.value);
                              });
                            },
                            itemBuilder: (context, item) {
                              return Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.symmetric(
                                        vertical: BorderSide(),
                                        horizontal: BorderSide.none,
                                      )),
                                  child: Text(item,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black)));
                            },
                          ),
                        ),
                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controller.varietyNameText
                              ..text = controller.varietyNameSelect.value,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.cropType.value,
                          style: TextStyle(
                              // fontSize: 14,
                              // color:
                              //  growerController.currentFactoryName.value == "Crob Type"
                              //     ?
                              // Colors.grey[400],
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
                        items: controller.cropTypeList.map(
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
                          controller.updateCropType(val);
                          print("val:    ${controller.cropType.value}");
                        },
                      ),
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
                              lastDate: DateTime.now());
                          controller.plantDate = date;
                          controller.dateText.value =
                              DateFormat("yyyy-MM-dd").format(date!);
                          controller.update();

                          // if (controller.hEndDate != null)
                          controller.calculateCrobDays(
                              controller.plantDate!, endDate!);
                          // controller.calculateProductionYield();
                          controller.update();
                        },
                        controller: controller.plantDateText
                          ..text = controller.dateText.value,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Date of Planting",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 18),
                        controller: controller.areaText,
                        decoration: InputDecoration(
                          labelText: 'Area(Ha.)',
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.plantingMethod.value,
                          style: TextStyle(
                              // fontSize: 14,
                              // color:
                              //  growerController.currentFactoryName.value == "Crob Type"
                              //     ?
                              // Colors.grey[400],
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
                        items: controller.plantingMethodList.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val.method,
                              child: Text(
                                val.method!,
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
                          controller.updatePlantingMethod(val);
                          print("val:    ${controller.plantingMethod.value}");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.intercrop.value,
                          style: TextStyle(
                            fontSize: 14,
                            // color:
                            //      growerController.currentFactoryName.value == "Crob Type"
                            //         ?
                            //     Colors.grey[400]
                            // : textColor,
                            // fontWeight: controller.intercrop.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: controller.interCropList.map(
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
                          controller.updateInterCrop(val);
                          print("val:    ${controller.intercrop.value}");
                        },
                      ),
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
                              initialDate: DateTime(controller.plantDate!.year,
                                  controller.plantDate!.month + 7),
                              firstDate: DateTime(controller.plantDate!.year,
                                  controller.plantDate!.month + 7),
                              lastDate:
                                  DateTime(controller.plantDate!.year + 2),
                              helpText: "Harvesting Start Date");
                          controller.startDateForHarvest.value =
                              DateFormat("yyyy-MM-dd").format(date!);
                          controller.hStartDate = date;
                          startDate = date;
                          controller.update();
                        },
                        controller: controller.harvestStartDateText
                          ..text = controller.startDateForHarvest.value,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Harvesting Start Date",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        // readOnly: true,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? date = DateTime.now();

                          date = await showDatePicker(
                            context: context,
                            initialDate: controller.hStartDate!,
                            firstDate: controller.hStartDate!,
                            lastDate: DateTime(
                              controller.hStartDate!.year + 1,
                            ),
                            helpText: "Harvesting End Date",
                            errorFormatText: 'Enter valid date',
                            errorInvalidText: 'Enter date in valid range',
                          );
                          controller.endDateForHarvest.value =
                              DateFormat("yyyy-MM-dd").format(date!);
                          endDate = date;
                          controller.calculateCrobDays(
                              controller.plantDate!, endDate!);
                          // controller.calculateProductionYield();
                          controller.update();
                        },
                        controller: controller.harvestEndDateText
                          ..text = controller.endDateForHarvest.value,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Harvesting End Date",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     style: TextStyle(fontSize: 18),
                    //     controller: controller.harvestStartDate,
                    //     decoration:
                    //         InputDecoration(labelText: 'Harvesting Start Dt'),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     style: TextStyle(fontSize: 18),
                    //     controller: controller.harvestEndDate,
                    //     decoration: InputDecoration(
                    //       labelText: "Harvesting End Dt ",
                    //       labelStyle: TextStyle(fontSize: 14),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        controller: controller.cropDaysText
                          ..text = controller.crobDays.value,
                        style: TextStyle(),
                        // controller: controller.textController10,
                        decoration: InputDecoration(
                          labelText: "Crop Days",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller.productionYieldText,
                        style: TextStyle(),
                        // controller: controller.textController11,
                        decoration: InputDecoration(
                          labelText: "Production",
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
                          onPressed: () => (controller
                                      .villageCodeText.text.isEmpty ||
                                  controller.villageCodeText.text == "" ||
                                  controller.villageName.value.isEmpty ||
                                  controller.villageName.value == "" ||
                                  controller.growerCodeText.text.isEmpty ||
                                  controller.growerCodeText.text == "" ||
                                  controller.growerNameText.text.isEmpty ||
                                  controller.growerNameText.text == "" ||
                                  controller
                                      .growerFatherNameText.text.isEmpty ||
                                  controller.growerFatherNameText.text == "" ||
                                  controller.cropType.value.isEmpty ||
                                  controller.cropType.value == "" ||
                                  controller.plantDateText.text.isEmpty ||
                                  controller.plantDateText.text == "" ||
                                  controller.areaText.text.isEmpty ||
                                  controller.areaText.text == "" ||
                                  controller.varietyCodeText.text.isEmpty ||
                                  controller.varietyCodeText.text == "" ||
                                  controller.varietyNameText.text.isEmpty ||
                                  controller.varietyNameText.text == "" ||
                                  controller.plantingMethod.value.isEmpty ||
                                  controller.plantingMethod.value == "")
                              ? Get.snackbar(
                                  "Error", "Fill All the Required Fields",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP)
                              : controller.onSubmit(),
                          //   controller.villageCodeText.text,
                          //   controller.villageName.value,
                          //   controller.growerCodeText.text,
                          //   controller.growerNameText.text,
                          //   controller.growerFatherNameText.text,
                          //   controller.cropType.value,
                          //   controller.plantDateText.text,
                          //   controller.areaText.text,
                          //   controller.varietyCodeText.text,
                          //   controller.varietyNameText.text,
                          //   controller.plantingMethod.value,
                          //   controller.intercrop.value,
                          //   controller.harvestStartDateText.text,
                          //   controller.harvestEndDateText.text,
                          //   controller.cropDaysText.text,
                          //   controller.productionYieldText.text,
                          // ),
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
}

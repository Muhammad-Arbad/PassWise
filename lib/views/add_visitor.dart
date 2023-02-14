import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/models/add_visitor_model.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/views/send_qr_code.dart';
import 'package:passwise_app_rehan_sb/widgets/bustom_bottom_sheet.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_button.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_cnic.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_field.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_phone_no.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AddVisitor extends StatefulWidget {
  bool? isEditing = false;
  String? id = "";

  AddVisitor(
      {Key? key,
      // required this.isEditing
      this.isEditing,
      this.id})
      : super(key: key);

  @override
  State<AddVisitor> createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor> {
  HttpRequest addVisitorRequest = HttpRequest();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  DateTime? dateTimeNow, selectedDate;
  File? visitorImage;
  AddVisitorModel? addVisitorModel;
  String? imgUrl;

  bool isLoading = false;

  int _currentHour = 0;
  int _currentMinute = 0;
  int _currentDate = 0;
  int _currentMonth = 0;
  int _currentYear = 0;

  int zeroForAM_OneForPM = 0;
  List<String> setPmAm = ['AM', 'PM'];

  List<String> setMonth = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  int setMonthIndex = 0;
  int currentHourOnlyTwelve = 0;

  void changeHour(int hour) {
    setState(() {
      //_currentHour = hour;
      currentHourOnlyTwelve = hour;
    });
  }

  void changeMinute(int minute) {
    setState(() {
      _currentMinute = minute;
    });
  }

  void changeAmPm(int ampm) {
    setState(() {
      zeroForAM_OneForPM = ampm;
    });
  }

  void changeDate(int date) {
    setState(() {
      _currentDate = date;
    });
  }

  void changeMonth(int month) {
    setState(() {
      setMonthIndex = month;
    });
  }

  void changeYear(int year) {
    setState(() {
      _currentYear = year + 2000;
    });
  }

  void getAddVisitorModel() async {
    print("getAddVisitorModel");
    setState(() {
      isLoading = true;
    });
    var response = addVisitorRequest.getSinglePass(widget.id ?? "");

    // if(response != null){
    //   setState((){
    //     isLoading = false;
    //   });
    // }
    addVisitorModel = AddVisitorModel.fromJson(jsonDecode(await response));

    nameController.text = addVisitorModel!.name ?? "";
    phoneNoController.text = addVisitorModel!.phoneNo ?? "";
    cnicController.text = addVisitorModel!.cnic ?? "";
    reasonController.text = addVisitorModel!.reason ?? "";
    imgUrl = addVisitorModel!.image ?? "";

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEditing ?? false) {
      // var response = addVisitorRequest.getSinglePass(widget.id??"");
      getAddVisitorModel();
    }

    dateTimeNow = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

    _currentHour = dateTimeNow!.hour;
    _currentMinute = dateTimeNow!.minute;
    _currentDate = dateTimeNow!.day;
    _currentMonth = dateTimeNow!.month;
    _currentYear = dateTimeNow!.year;

    //print(_currentYear.toString());

    _currentHour <= 12 ? zeroForAM_OneForPM = 0 : zeroForAM_OneForPM = 1;
    _currentHour <= 12
        ? currentHourOnlyTwelve = _currentHour
        : currentHourOnlyTwelve = _currentHour - 12;
    setMonthIndex = _currentMonth - 1;
  }

  @override
  Widget build(BuildContext context) {
    return OurScaffoldTemplate(
      resizeToAvoidBottomInset: false,
      appBarWidget: Column(
        children: [
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text("Add Visitor"),
            // bottom: PreferredSize(
            //   preferredSize: Size.fromHeight(0),
            //   child: Container(
            //       height: 2.0,
            //       width: 50.0,
            //       color:CustomColors().customGreenColor
            //   ),
            // ),
          ),
          Flexible(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: visitorImage == null
                    ? imgUrl == null
                        ? InkWell(
                            onTap: () {
                              selectOrCaptureImage(context);
                            },
                            child: Image.asset('assets/add_visitor.png'))
                        : InkWell(
                            onTap: () {
                              selectOrCaptureImage(context);
                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Container(
                                width: 200,
                                //height: 270,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/add_visitor.png"))),
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Container(
                                      child: Container(
                                        color: Colors.black,
                                        child: InteractiveViewer(
                                          maxScale: 10.0,
                                          child: Image.network(
                                            imgUrl!,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ]),
                          )
                    : InkWell(
                        onTap: () {
                          selectOrCaptureImage(context);
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            width: 200,
                            //height: 270,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/add_visitor.png"))),
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                  child: Container(
                                    color: Colors.black,
                                    child: InteractiveViewer(
                                      maxScale: 10.0,
                                      child: Image.file(
                                        visitorImage!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ]),
                        // Container(
                        //   color: Colors.black,
                        //   width: 200,
                        //   //height: 300,
                        //   child: InteractiveViewer(
                        //     maxScale: 10.0,
                        //     child: Image.file(
                        //       visitorImage!,
                        //       fit: BoxFit.contain,
                        //     ),
                        //   ),
                        // ),
                      )),
          ),
        ],
      ),
      showFAB: true,
      //bodyWidget: FormBody(),
      bodyWidget: !isLoading
          ? Scaffold(
              //backgroundColor: Colors.red,
              backgroundColor: CustomColors().customGreenColor,
              // backgroundColor: MediaQuery.of(context).viewInsets.bottom==0 ?
              // CustomColors().customGreenColor:
              // CustomColors().customWhiteColor,
              body: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                  color: CustomColors().customWhiteColor,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          50,
                          20,
                          50,
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? MediaQuery.of(context).size.height * 0.20
                              : 10),
                      child: Column(
                        children: [
                          TextFormFieldCustomerBuilt(
                            hintTxt: "Name",
                            icoon: Icons.person_outline,
                            controller: nameController,
                            isonAssetPath: "assets/person.png",
                          ),
                          TextFormFieldCustomerBuiltPhoneNumber(
                            textInputType: TextInputType.number,
                            isNumber: true,
                            hintTxt: "Phone no",
                            icoon: Icons.phone_android_outlined,
                            controller: phoneNoController,
                            isonAssetPath: "assets/phone.png",
                          ),
                          TextFormFieldCustomerBuiltCnic(
                            isNumber: true,
                            isCNIC: true,
                            textInputType: TextInputType.number,
                            hintTxt: "CNIC",
                            icoon: Icons.credit_card_sharp,
                            controller: cnicController,
                            isonAssetPath: "assets/cnic.png",
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                  AssetImage("assets/reason.png"),
                                  color: CustomColors().customGreenColor,
                                ),
                              ),
                              // Icon(
                              //   Icons.textsms_outlined,
                              //   color: CustomColors().customGreenColor,
                              // ),
                              Text("Reason"),
                            ],
                          ),
                          TextFormFieldCustomerBuilt(
                            controller: reasonController,
                            showSeparator: false,
                            maxLines: 3,
                          ),
                          widget.isEditing ?? false
                              ? IgnorePointer()
                              : GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    // print("Inside On Tap");
                                    _pickDateDialog(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: CustomColors()
                                                  .customGreenColor,
                                            ),
                                            child: IgnorePointer(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  singleNumberPicker(
                                                      currentHourOnlyTwelve,
                                                      // _currentHour <= 12
                                                      //     ? _currentHour
                                                      //     : _currentHour - 12,
                                                      12,
                                                      Colors.white,
                                                      Colors.black,
                                                      changeHour,
                                                      0,
                                                      _currentHour <= 12
                                                          ? _currentHour
                                                              .toString()
                                                              .padLeft(2, "0")
                                                          : (_currentHour - 12)
                                                              .toString()
                                                              .padLeft(2, "0")),
                                                  singleNumberPicker(
                                                      _currentMinute,
                                                      59,
                                                      Colors.white,
                                                      Colors.black,
                                                      changeMinute,
                                                      0,
                                                      _currentMinute
                                                          .toString()
                                                          .padLeft(2, "0")),
                                                  singleStringPicker(
                                                      0,
                                                      1,
                                                      setPmAm,
                                                      _currentHour <= 12
                                                          ? 0
                                                          : 1,
                                                      changeAmPm,
                                                      30,
                                                      CustomColors()
                                                          .customGreenColor,
                                                      Colors.white),
                                                ],
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: CustomColors()
                                                  .customGreenColor,
                                            ),
                                            child: IgnorePointer(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  singleNumberPicker(
                                                      _currentDate,
                                                      31,
                                                      Colors.white,
                                                      Colors.black,
                                                      changeDate,
                                                      1,
                                                      _currentDate
                                                          .toString()
                                                          .padLeft(2, "0")),
                                                  singleStringPicker(
                                                      0,
                                                      11,
                                                      setMonth,
                                                      //setMonthIndex,
                                                      _currentMonth - 1,
                                                      changeMonth,
                                                      50,
                                                      Colors.white,
                                                      Colors.black),
                                                  singleNumberPicker(
                                                      _currentYear - 2000,
                                                      50,
                                                      CustomColors()
                                                          .customGreenColor,
                                                      Colors.white,
                                                      changeYear,
                                                      0,
                                                      _currentYear
                                                          .toString()
                                                          .substring(2)),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: CustomColors().customGreenColor,
              ),
            ),
      bottomSheet: CustomBottomSheet(home: () {
        Navigator.pop(context);
      }, addVisitor: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }),
      fabOnPress: addVisitorFunction,
    );
  }

  void addVisitorFunction() async {
    //---------------------------------------------------------------------------------------------
    if (widget.isEditing ?? false) {
      AddVisitorModel addVisitorModel;

      final isValid = formKey.currentState?.validate();
      if (isValid!) {
        setState(() {
          isLoading = true;
        });

        String newImageUrl;
        if (imgUrl != null && visitorImage == null) {
          log("INSIDE IF");
          newImageUrl = imgUrl ?? "";
        } else {
          log("INSIDE ELSE");
          newImageUrl = await addVisitorRequest.uploadImage(visitorImage!.path);
        }

        if (await newImageUrl != "null") {
          String imgUrl1;
          if (newImageUrl != imgUrl) {
            imgUrl1 = jsonDecode(newImageUrl)['imageUrl'];
          } else {
            imgUrl1 = imgUrl ?? "";
          }

          print('IMAGE URL = ' + imgUrl1);

          addVisitorModel = AddVisitorModel(
              name: nameController.text,
              phoneNo: phoneNoController.text,
              cnic: cnicController.text,
              reason: reasonController.text,
              image: imgUrl1);

          String response = await addVisitorRequest.updateVisitor(
              addVisitorModel, widget.id ?? "");

          if (response == "updated") {
            Fluttertoast.showToast(
                msg: nameController.text + " Updated",
                backgroundColor: CustomColors().customGreenColor,
                gravity: ToastGravity.CENTER);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SendQRCode(qrCode: addVisitorModel.qrcode ?? "")));
          } else {
            Fluttertoast.showToast(
                msg: "Error in updating",
                backgroundColor: Colors.red,
                gravity: ToastGravity.CENTER_RIGHT);
          }

          setState(() {
            isLoading = false;
          });
        }
      }
    }

//----------------------------------------------------------------------------------------------------
    else {
      int selectedHourInTwentyFourFormat = 0;
      zeroForAM_OneForPM == 0
          ? selectedHourInTwentyFourFormat = currentHourOnlyTwelve
          : selectedHourInTwentyFourFormat = currentHourOnlyTwelve + 12;

      DateTime today = DateTime.now();
      // String selectedDate = _currentYear.toString() +
      //     "-" +
      //     (setMonthIndex + 1).toString() +
      //     "-" +
      //     _currentDate.toString() +
      //     "T" +
      //     selectedHourInTwentyFourFormat.toString() +
      //     ":" +
      //     _currentMinute.toString() +
      //     ":00.000Z";

      String selectedDate = _currentYear.toString() +
              "-" +
              _currentMonth.toString() +
              "-" +
              _currentDate.toString() +
              "T" +
              _currentHour.toString() +
              ":" +
              _currentMinute.toString();

      //String sd = selectedDate.toString();

      log("SELECTED DATE = " + selectedDate);
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm").parse(selectedDate);
      // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(selectedDate);
      log("SELECTED PARSE DATE = " + parseDate.toString());
      // print("Parsed Date = "+parseDate.toString());
      // print(today.toString());

      String qrCode = cnicController.text + DateTime.now().toString();
      // print(qrCode);

      AddVisitorModel addVisitorModel;

      final isValid = formKey.currentState?.validate();
      if (isValid!) {
        if (parseDate.compareTo(today) < 0) {
          Fluttertoast.showToast(
              msg: "Previous date not Allowed",
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER_RIGHT);
        } else if (visitorImage == null) {
          Fluttertoast.showToast(
              msg: "Add Visitor Image",
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER_RIGHT);
        } else {
          setState(() {
            isLoading = true;
          });

          String imageUrl =
              await addVisitorRequest.uploadImage(visitorImage!.path);
          // print("imageUrl"+imageUrl);

          if (await imageUrl != "null") {
            String imgUrl = jsonDecode(imageUrl)['imageUrl'];
            print('IMAGE URL = ' + imgUrl);
            addVisitorModel = AddVisitorModel(
                name: nameController.text,
                phoneNo: phoneNoController.text,
                cnic: cnicController.text,
                reason: reasonController.text,
                date: parseDate.toString(),
                // date: selectedDate,
                qrcode: qrCode,
                image: imgUrl);
            // image: imageUrl);

            // print("After Image URL");

            String? response =
                await addVisitorRequest.addVisitor(addVisitorModel);

            if (response == "allowed") {
              Fluttertoast.showToast(
                  msg: nameController.text + " added",
                  backgroundColor: CustomColors().customGreenColor,
                  gravity: ToastGravity.CENTER);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SendQRCode(qrCode: qrCode)));
            } else {
              Fluttertoast.showToast(
                  msg: response!,
                  backgroundColor: Colors.red,
                  gravity: ToastGravity.CENTER_RIGHT);
            }

            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }
  }

  // singleNumberPicker(start, maxValue, bgColor, txtColor,
  //     void Function(int value) changeTime, minValue) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       boxShadow: kElevationToShadow[4],
  //       color: bgColor,
  //     ),
  //     height: 30,
  //     width: 30,
  //     alignment: Alignment.center,
  //     child: Stack(
  //       children: [
  //         Center(
  //           child: NumberPicker(
  //               zeroPad: true,
  //               itemHeight: 30,
  //               itemWidth: 30,
  //               value: start,
  //               minValue: minValue,
  //               maxValue: maxValue,
  //               step: 1,
  //               itemCount: 1,
  //               axis: Axis.vertical,
  //               selectedTextStyle: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: txtColor,
  //               ),
  //               onChanged: (value) => changeTime(value)),
  //         ),
  //         Center(
  //           child: Divider(
  //             thickness: 2,
  //             color: CustomColors().customGreenColor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // singleStringPicker(
  //     int minNumber,
  //     int maxNumber,
  //     List<String> list,
  //     int changingValue,
  //     void Function(int value) changeString,
  //     double width,
  //     Color bgColor,
  //     Color txtColor) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       boxShadow: kElevationToShadow[4],
  //       color: bgColor,
  //     ),
  //     height: 30,
  //     width: width,
  //     alignment: Alignment.center,
  //     child: Stack(
  //       children: [
  //         Stack(
  //           children: [
  //             IgnorePointer(
  //               child: Center(
  //                 child: Text(
  //                   list[changingValue],
  //                   style: TextStyle(
  //                     fontSize: 17,
  //                     fontWeight: FontWeight.bold,
  //                     color: txtColor,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             NumberPicker(
  //               itemHeight: 30,
  //               itemWidth: width,
  //               value: changingValue,
  //               minValue: minNumber,
  //               maxValue: maxNumber,
  //               step: 1,
  //               itemCount: 1,
  //               axis: Axis.vertical,
  //               textStyle: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.transparent,
  //               ),
  //               selectedTextStyle: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.transparent,
  //               ),
  //               onChanged: (value) {
  //                 changeString(value);
  //               },
  //             ),
  //           ],
  //         ),
  //         Center(
  //           child: Divider(
  //             thickness: 2,
  //             color: CustomColors().customGreenColor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _pickDateDialog(BuildContext context) async {
    await showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: CustomColors().customGreenColor, // <-- SEE HERE
                    onPrimary: CustomColors().customWhiteColor, // <-- SEE HERE
                    onSurface: Colors.black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: Colors.black, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(2000),
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2050)) //what will be the up to supported date in picker
        .then((pickedDate) async {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      } else {
        selectedDate = pickedDate;
        TimeOfDay? selectedTime = await showTimePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: CustomColors().customGreenColor, // <-- SEE HERE
                    onPrimary: CustomColors().customWhiteColor, // <-- SEE HERE
                    onSurface: Colors.black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: Colors.black, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialTime: TimeOfDay.now());

        if (selectedTime != null) {
          DateTime dateTimeSelected = DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              selectedTime!.hour,
              selectedTime!.minute);

          setState(() {
            selectedDate = dateTimeSelected;
            _currentHour = selectedDate!.hour;
            _currentMinute = selectedDate!.minute;
            _currentYear = selectedDate!.year;
            _currentMonth = selectedDate!.month;
            _currentDate = selectedDate!.day;
          });

          // print("Selected Date Time = "+selectedDate.toString());
          // print("Current hour = "+_currentHour.toString());
          // print("Current hour = "+_currentMinute.toString());
          // print("Current hour = "+_currentYear.toString());
          // print("Current hour = "+_currentMonth.toString());
          // print("Current hour = "+_currentDate.toString());

        }
      }
    });
  }

  singleNumberPicker(start, maxValue, bgColor, txtColor,
      void Function(int value) changeTime, minValue, String value) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        color: bgColor,
      ),
      height: 30,
      width: 30,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
              child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: txtColor,
            ),
          )),
          Center(
            child: Divider(
              thickness: 2,
              color: CustomColors().customGreenColor,
            ),
          ),
        ],
      ),
    );
  }

  singleStringPicker(
      int minNumber,
      int maxNumber,
      List<String> list,
      int changingValue,
      void Function(int value) changeString,
      double width,
      Color bgColor,
      Color txtColor) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        color: bgColor,
      ),
      height: 30,
      width: width,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Stack(
            children: [
              IgnorePointer(
                child: Center(
                  child: Text(
                    list[changingValue],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
                  ),
                ),
              ),
              // NumberPicker(
              //   itemHeight: 30,
              //   itemWidth: width,
              //   value: changingValue,
              //   minValue: minNumber,
              //   maxValue: maxNumber,
              //   step: 1,
              //   itemCount: 1,
              //   axis: Axis.vertical,
              //   textStyle: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.transparent,
              //   ),
              //   selectedTextStyle: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.transparent,
              //   ),
              //   onChanged: (value) {
              //     changeString(value);
              //   },
              // ),
            ],
          ),
          Center(
            child: Divider(
              thickness: 2,
              color: CustomColors().customGreenColor,
            ),
          ),
        ],
      ),
    );
  }

  void selectOrCaptureImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Select Image source"),
              actions: [
                TextButton(
                    onPressed: () async{

                      var status = await Permission.camera.request();

                      if(status.isGranted){
                        imagePicker(ImageSource.camera);
                      }

                      if (status.isDenied){
                        Fluttertoast.showToast(
                            msg: "Allow Camera to proceed",
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.CENTER_RIGHT);
                      }



                    },
                    child: Text(
                      "Camera",
                      style: TextStyle(color: CustomColors().customGreenColor),
                    )),
                TextButton(

                    onPressed: () async{

                      var status = await Permission.storage.request();

                      if(status.isGranted){
                        imagePicker(ImageSource.gallery);
                      }

                       if (status.isDenied){
                        Fluttertoast.showToast(
                            msg: "Allow Storage to proceed",
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.CENTER_RIGHT);
                      }


                    },
                    child: Text(
                      "Gallery",
                      style: TextStyle(color: CustomColors().customGreenColor),
                    )),
                // CustomButtonWidget(btntext: "Capture",btnonPressed: (){imagePicker(ImageSource.camera);},borderRadius: 10),
                // CustomButtonWidget(btntext: "Gallery",btnonPressed: (){imagePicker(ImageSource.gallery);},borderRadius: 10),
              ],
            ));
  }

  imagePicker(ImageSource source) async {
    Navigator.pop(context);
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (image != null) {
      final tempStorage = File(image.path);
      setState(() {
        this.visitorImage = tempStorage;
      });
    }
  }
}

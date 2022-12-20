import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/views/send_qr_code.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_field.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';
import 'package:numberpicker/numberpicker.dart';

class AddVisitor extends StatefulWidget {
  const AddVisitor({Key? key}) : super(key: key);

  @override
  State<AddVisitor> createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  DateTime? dateTimeNow;

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

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
      //print("Current Hour = "+_currentHour.toString());
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTimeNow = DateTime.now();

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
              child: Image.asset('assets/add_visitor.png'),
            ),
          ),
        ],
      ),
      showFAB: true,
      //bodyWidget: FormBody(),
      bodyWidget: !isLoading
          ? Scaffold(
        backgroundColor: CustomColors().customWhiteColor,
        body: SingleChildScrollView(
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
                    textInputType: TextInputType.emailAddress,
                    hintTxt: "Name",
                    icoon: Icons.person_outline,
                    controller: nameController,
                  ),
                  TextFormFieldCustomerBuilt(
                    textInputType: TextInputType.emailAddress,
                    hintTxt: "Phone no",
                    //icoon: Icons.email,
                    icoon: Icons.phone_android_outlined,
                    controller: phoneNoController,
                  ),
                  TextFormFieldCustomerBuilt(
                    textInputType: TextInputType.emailAddress,
                    hintTxt: "CNIC",
                    icoon: Icons.credit_card_sharp,
                    controller: cnicController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.textsms_outlined,
                        color: CustomColors().customGreenColor,
                      ),
                      Text("Reason"),
                    ],
                  ),
                  TextFormFieldCustomerBuilt(
                    isOptional: false,
                    controller: reasonController,
                    showSeparator: false,
                    maxLines: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              color: CustomColors().customGreenColor,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                                    1),
                                singleNumberPicker(
                                    _currentMinute,
                                    59,
                                    Colors.white,
                                    Colors.black,
                                    changeMinute,
                                    0),
                                singleStringPicker(
                                    0,
                                    1,
                                    setPmAm,
                                    zeroForAM_OneForPM,
                                    changeAmPm,
                                    30,
                                    CustomColors().customGreenColor,
                                    Colors.white),
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            color: CustomColors().customGreenColor,
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              singleNumberPicker(
                                  _currentDate,
                                  31,
                                  Colors.white,
                                  Colors.black,
                                  changeDate,
                                  1),
                              singleStringPicker(
                                  0,
                                  11,
                                  setMonth,
                                  setMonthIndex,
                                  changeMonth,
                                  50,
                                  Colors.white,
                                  Colors.black),
                              singleNumberPicker(
                                  _currentYear - 2000,
                                  50,
                                  CustomColors().customGreenColor,
                                  Colors.white,
                                  changeYear,
                                  0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: kElevationToShadow[4],
              color: CustomColors().customGreenColor,
              // image: DecorationImage(
              //     image: AssetImage('assets/Ultralight-S.png')),
            ),
            child: IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: kElevationToShadow[4],
              color: CustomColors().customGreenColor,
            ),
            child: IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      fabOnPress: addVisitorFunction,
    );
  }

  void addVisitorFunction() {
    print("Inside add visitor function");

    int selectedHourInTwentyFourFormat = 0;
    zeroForAM_OneForPM == 0
        ? selectedHourInTwentyFourFormat =
        currentHourOnlyTwelve
        : selectedHourInTwentyFourFormat =
        currentHourOnlyTwelve + 12;

    DateTime today = DateTime.now();
    String selectedDate = _currentYear.toString() +
        "-" +
        (setMonthIndex + 1).toString() +
        "-" +
        _currentDate.toString() +
        "T" +
        selectedHourInTwentyFourFormat.toString() +
        ":" +
        _currentMinute.toString() +
        ":00.000Z";

    DateTime parseDate =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(selectedDate);
    print(parseDate.toString());
    print(today.toString());

    if (parseDate.compareTo(today) < 0) {
      print("Not Allowed");
      Fluttertoast.showToast(
          msg: "Previous time not Allowed");
    }

    // final isValid = formKey.currentState?.validate();
    // if (isValid!){
    //   setState(() {
    //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>SendQRCode()));
    //     //isLaoding = true;
    //   });
    // }
  }

  singleNumberPicker(start, maxValue, bgColor, txtColor,
      void Function(int value) changeTime, minValue) {
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
            child: NumberPicker(
                zeroPad: true,
                itemHeight: 30,
                itemWidth: 30,
                value: start,
                minValue: minValue,
                maxValue: maxValue,
                step: 1,
                itemCount: 1,
                axis: Axis.vertical,
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: txtColor,
                ),
                onChanged: (value) => changeTime(value)),
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
              NumberPicker(
                itemHeight: 30,
                itemWidth: width,
                value: changingValue,
                minValue: minNumber,
                maxValue: maxNumber,
                step: 1,
                itemCount: 1,
                axis: Axis.vertical,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent,
                ),
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent,
                ),
                onChanged: (value) {
                  changeString(value);
                },
              ),
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
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/models/visitor_details_Model.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/sharedPreferences/user_preferences.dart';
import 'package:passwise_app_rehan_sb/views/add_visitor.dart';
import 'package:passwise_app_rehan_sb/views/sign_in_up.dart';
import 'package:passwise_app_rehan_sb/widgets/bustom_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_search.dart';
import 'package:table_calendar/table_calendar.dart';

class VisitorList extends StatefulWidget {


  VisitorList({Key? key}) : super(key: key);

  @override
  State<VisitorList> createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {
  int selectedIndex = 0, currentPageDate = 0, previousIndex = 0;
  bool isLoading = false;
  HttpRequest getPassesHttp = HttpRequest();
  DateTime selectedDate = DateTime.now();
  int selectedDateFromCalendar = DateTime.now().day;
  List<VisitorsDetailModel> sortedVisitorsList = [];
  List<VisitorsDetailModel> allVisitorsList = [];
  bool showSearchBar = false,showUpdateDeleteIcons = false;
  String searchString = "", companyName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyName = UserPreferences.getCompanyName() ?? "Office Name";
    getAllPasses();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        color: CustomColors().customGreenColor,
        padding: const EdgeInsets.only(left: 10),
        child: Scaffold(
          backgroundColor: CustomColors().customWhiteColor,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.logout_outlined,
                    size: 30, color: CustomColors().customGreenColor),
                onPressed: () {
                  wahtToLogOut(context);
                  // UserPreferences.setUserToken("null");
                  // // UserPreferences.clearAllPreferences();
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => Sign_In_Up()));
                  // Fluttertoast.showToast(msg: "Loged Out",gravity: ToastGravity.CENTER,backgroundColor: CustomColors().customGreenColor);
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: !showSearchBar
                      ? CustomColors().customGreenColor
                      : CustomColors().customWhiteColor,
                ),
                onPressed: () {
                  setState(() {
                    showSearchBar = true;
                    sortedVisitorsList = allVisitorsList;
                  });
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Visitor List",
                      style: TextStyle(
                          color: CustomColors().customGreenColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                  height: 2.0,
                  width: 50.0,
                  color: CustomColors().customGreenColor),
            ),
          ),
          body: !isLoading
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      //   child: CalendarAppBar(),
                      // ),
                      Container(
                          //height: 400,
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: showSearchBar
                              ? showSearchField()
                              : horizontalCalendar()),
                      Expanded(
                        child: ListView.builder(
                          itemCount: sortedVisitorsList.length,
                          itemBuilder: (context, index) {
                            return singleVisitorTile(
                                sortedVisitorsList[index], index);
                          },
                        ),
                      ),
                    ],
                  ),
                  color: CustomColors().customWhiteColor,
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: CustomColors().customGreenColor,
                )),
          bottomSheet: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            color: CustomColors().customWhiteColor,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
                color: CustomColors().customGreenColor,
              ),
              child: CustomBottomSheet(
                  addVisitor: addVisitor,
                  home: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (showSearchBar == true || showUpdateDeleteIcons == true) {
      sortByDate();
      setState(() {
        showUpdateDeleteIcons = false;
        showSearchBar = false;
      });
      return await false;
    } else {
      return await true;
    }
  }

  void getAllPasses() async {
    //print(DateTime.now());

    setState(() {
      isLoading = true;
    });

    List data = await getPassesHttp.getAllPasses();
    for (int i = 0; i < data.length; i++) {
      print("For LOOP CALLING");
      allVisitorsList.add(VisitorsDetailModel.fromJson(data[i]));
      // sortedVisitorsList.add(VisitorsDetailModel.fromJson(data[i]));
    }
    print("LENGTH = " + allVisitorsList.length.toString());
    sortedVisitorsList = allVisitorsList;
    sortByDate();
  }

  Widget singleVisitorTile(VisitorsDetailModel visitorsDetail, int index) {
    previousIndex = index - 1;
    return GestureDetector(
      onLongPress: (){

        setState((){
          showUpdateDeleteIcons = true;
          selectedIndex = index;
          currentPageDate = selectedDate.day;
        });

      },
      onTap: () => setState(
        () {
          selectedIndex = index;
          currentPageDate = selectedDate.day;
          showUpdateDeleteIcons = false;
        },
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  previousIndex >= 0
                      ? Column(
                          children: [
                            Text(
                                int.parse(displayOnlyHours(visitorsDetail.date)) <=
                                        12
                                    ? displayOnlyHours(visitorsDetail.date)
                                    : (int.parse(displayOnlyHours(
                                                visitorsDetail.date)) -
                                            12)
                                        .toString(),
                                style: TextStyle(
                                    color: int.parse(displayOnlyHours(
                                                sortedVisitorsList[index]
                                                    .date)) ==
                                            int.parse(displayOnlyHours(
                                                sortedVisitorsList[previousIndex].date))
                                        ? CustomColors().customWhiteColor
                                        : CustomColors().customTextGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                int.parse(displayOnlyHours(
                                            visitorsDetail.date)) <=
                                        12
                                    ? "AM"
                                    : "PM",
                                style: TextStyle(
                                    color: int.parse(displayOnlyHours(
                                                sortedVisitorsList[index]
                                                    .date)) ==
                                            int.parse(displayOnlyHours(
                                                sortedVisitorsList[
                                                        previousIndex]
                                                    .date))
                                        ? CustomColors().customWhiteColor
                                        : CustomColors().customTextGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                                int.parse(displayOnlyHours(
                                            visitorsDetail.date)) <=
                                        12
                                    ? displayOnlyHours(visitorsDetail.date)
                                    : (int.parse(displayOnlyHours(
                                                visitorsDetail.date)) -
                                            12)
                                        .toString(),
                                style: TextStyle(
                                    color: CustomColors().customTextGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                int.parse(displayOnlyHours(
                                            visitorsDetail.date)) <=
                                        12
                                    ? "AM"
                                    : "PM",
                                style: TextStyle(
                                    color: CustomColors().customTextGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      (selectedIndex == index &&
                              currentPageDate == selectedDateFromCalendar)
                          ? Container(
                              child: CustomPaint(
                                size: Size(13, 13),
                                painter: CirclePainterFilled(),
                              ),
                            )
                          : CustomPaint(
                              size: Size(13, 13),
                              painter: CirclePainter(),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: (selectedIndex == index &&
                            currentPageDate == selectedDateFromCalendar)
                        ? CustomColors().customGreenColor
                        : CustomColors().customTileColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: kElevationToShadow[4],
                  ),
                  //padding: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded(
                          // flex: 1,
                          // child:
                          Icon(
                            Icons.calendar_month_outlined,
                            color: CustomColors().customWhiteColor,
                          ),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          // flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    visitorsDetail.reason!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: (selectedIndex == index &&
                                              currentPageDate ==
                                                  selectedDateFromCalendar)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    displayHourAndMinutes(visitorsDetail.date),
                                    style: TextStyle(
                                      color: (selectedIndex == index &&
                                              currentPageDate ==
                                                  selectedDateFromCalendar)
                                          ? Colors.white
                                          : CustomColors().customTextGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(visitorsDetail.name ?? "",
                                      style: TextStyle(
                                        //color: CustomColors().customTextGrey,
                                        fontSize: 12,
                                        color: (selectedIndex == index &&
                                                currentPageDate ==
                                                    selectedDateFromCalendar)
                                            ? Colors.white
                                            : CustomColors().customTextGrey,
                                      )),
                                  Text(visitorsDetail.phoneNo ?? "",
                                      style: TextStyle(
                                          //color: CustomColors().customTextGrey,
                                          color: (selectedIndex == index &&
                                                  currentPageDate ==
                                                      selectedDateFromCalendar)
                                              ? Colors.white
                                              : CustomColors().customTextGrey,
                                          fontSize: 12)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    companyName,
                                    style: TextStyle(
                                        color: (selectedIndex == index &&
                                                currentPageDate ==
                                                    selectedDateFromCalendar)
                                            ? Colors.white
                                            : CustomColors().customTextGrey,
                                        //color: CustomColors().customTextGrey,
                                        fontSize: 12),
                                  ),

                                  // if(selectedIndex == index && showUpdateDeleteIcons)
                                  //     Row(
                                  //       children: [
                                  //         Icon(Icons.update_outlined),
                                  //         Icon(Icons.delete_outline),
                                  //       ],
                                  //     )
                                ],
                              ),
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      if(selectedIndex == index && showUpdateDeleteIcons)
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  print("Update");
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => AddVisitor()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle
                                  ),

                                  child: Icon(Icons.update_outlined,color: Colors.deepPurple,),
                                ),
                              ),
                              SizedBox(height: 5,),
                              GestureDetector(
                                onTap: (){
                                  wahtToDelete(context,visitorsDetail);

                                  // getPassesHttp.deleteVisitor(visitorsDetail.sId??"");
                                  // setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle
                                  ),

                                  child: Icon(Icons.delete_outline,color: Colors.red,),
                                ),
                              )

                            ],
                          ),

                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String displayHourAndMinutes(String? date) {
    // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm").parse(date!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.Hm().format(inputDate);
    return outputDate;
  }

  String displayOnlyHours(String? date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm").parse(date!);
    // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.H().format(inputDate);
    return outputDate;
  }

  String displayOnlyDate(String? date) {
    // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm").parse(date!);
    var inputDate = DateTime.parse(parseDate.toString());
    // print("inputDate" + inputDate.toString());
    //var outputDate = DateFormat.H().format(inputDate);
    var outputDate = DateFormat.d().format(inputDate);
    // print("outputDate"+outputDate);
    return outputDate;
  }

  DateTime stringToDateTime(String? date) {
    // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm").parse(date!);
    return parseDate;
  }

  horizontalCalendar() {
    return SingleChildScrollView(
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(
          markerBuilder: ((context, day, events) {
            if (day.day == selectedDate.day &&
                day.month == selectedDate.month &&
                day.year == selectedDate.year) {
              return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 3.0,
                  width: 23.0,
                  color: CustomColors().customGreenColor);
            }
          }),
          defaultBuilder: (context, dateTime, datetime) {
            if (dateTime.day == selectedDate.day &&
                dateTime.month == selectedDate.month&&
                dateTime.year == selectedDate.year) {
              return Center(
                child: Text(
                  dateTime.day.toString(),
                  style: TextStyle(color: CustomColors().customGreenColor),
                ),
              );
            } else {
              return Center(
                child: Text(
                  dateTime.day.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          },
          dowBuilder: (context, day) {
            final text = DateFormat('EEE').format(day);
            if (day.day == selectedDate.day &&
                day.month == selectedDate.month &&
                day.year == selectedDate.year) {
              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: CustomColors().customGreenColor),
                ),
              );
            } else {
              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          },
        ),
        calendarStyle: CalendarStyle(),
        headerVisible: false,
        calendarFormat: CalendarFormat.week,
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 1, 1),
        focusedDay: selectedDate,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (date, events) {
          selectedDate = date;
          selectedDateFromCalendar = date.day;

          sortByDate();
          setState(() {});
        },
      ),
    );
  }

  addVisitor() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddVisitor()));
  }

  //List<VisitorsDetailModel>
  void sortByDate() {
    print("SORT BY DATE CALLIMG");
    final listData = allVisitorsList.where((element) {
      // print(element.date);
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm").parse(element.date!);
      // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
      var inputDate = DateTime.parse(parseDate.toString());

      // print(inputDate);
      if (inputDate.month == selectedDate.month &&
          inputDate.day == selectedDate.day &&
          inputDate.year == selectedDate.year) {
        return true;
      } else {
        return false;
      }
    }).toList();
    setState(() {
      isLoading = false;
      sortedVisitorsList = listData;
      sortedVisitorsList.sort((a, b) {
        print(int.parse(displayOnlyHours(a.date)).toString() + " aa");
        print(int.parse(displayOnlyHours(b.date)).toString() + " bb");
        return int.parse(displayOnlyHours(a.date))
            .compareTo(int.parse(displayOnlyHours(b.date)));
      });
    });
  }

  void sortBySearchString(String searchData) {
    final listData = allVisitorsList.where((element) {
      if (element.name!.toLowerCase().contains(searchData.toLowerCase()))
        return true;
      else
        return false;
    }).toList();

    setState(() {
      isLoading = false;
      sortedVisitorsList = listData;
    });
  }

  showSearchField() {
    return Container(
      child: TextFormFieldCustomerBuiltSearch(
        showSeparator: false,
        icoon: Icons.search,
        onChange: (value) {
          setState(() {
            sortBySearchString(value);
          });
        },
      ),
    );
  }

  void wahtToLogOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Do you want to Log out ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: CustomColors().customGreenColor),
                    )),
                TextButton(
                    onPressed: () async {
                      // UserPreferences.setUserToken("null");
                      // UserPreferences.setExpiryTime(DateTime.now().toString());
                      // UserPreferences.setCompanyName("null");
                      UserPreferences.clearAllPreferences();
                      Navigator.pop(context);
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Sign_In_Up()),
                          (Route<dynamic> route) => false);
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sign_In_Up()));
                      Fluttertoast.showToast(
                          msg: "Loged Out",
                          gravity: ToastGravity.CENTER,
                          backgroundColor: CustomColors().customGreenColor);
                    },
                    child: Text("Yes",
                        style:
                            TextStyle(color: CustomColors().customGreenColor))),
                // CustomButtonWidget(btntext: "No",btnonPressed: (){Navigator.pop(context);},borderRadius: 10),
                // CustomButtonWidget(btntext: "Yes",btnonPressed: ()async{
                //
                //
                //   // UserPreferences.setUserToken("null");
                //   // UserPreferences.setExpiryTime(DateTime.now().toString());
                //   // UserPreferences.setCompanyName("null");
                //   UserPreferences.clearAllPreferences();
                //   Navigator.pop(context);
                //   setState(() {
                //     isLoading = true;
                //   });
                //   await Future.delayed(Duration(milliseconds: 500));
                //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                //       Sign_In_Up()), (Route<dynamic> route) => false);
                //   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sign_In_Up()));
                //   Fluttertoast.showToast(msg: "Loged Out",gravity: ToastGravity.CENTER,backgroundColor: CustomColors().customGreenColor);
                //
                // },borderRadius: 10),
              ],
            ));
  }


  void wahtToDelete(BuildContext context,VisitorsDetailModel visitorsDetailModel) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Do you want to Delete ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(color: CustomColors().customGreenColor),
                )),
            TextButton(

                onPressed: () async{
                  Navigator.pop(context);
                  setState(() {
                    isLoading = true;
                    showUpdateDeleteIcons = false;
                  });
                  String msg = await getPassesHttp.deleteVisitor(visitorsDetailModel.sId??"");



                  if(msg == "success"){

                    sortedVisitorsList.remove(visitorsDetailModel);
                    allVisitorsList.remove(visitorsDetailModel);

                    setState(() {
                      isLoading = false;
                    });

                  }


                },
                child: Text("Yes",
                    style:
                    TextStyle(color: CustomColors().customGreenColor))),
          ],
        ));
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = CustomColors().customGreenColor
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CirclePainterFilled extends CustomPainter {
  final _paint = Paint()
    ..color = CustomColors().customGreenColor
    //..strokeWidth = 1
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

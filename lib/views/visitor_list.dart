import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/models/visitor_details_Model.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/views/add_visitor.dart';
import 'package:passwise_app_rehan_sb/widgets/bustom_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class VisitorList extends StatefulWidget {
  String token;

  VisitorList({Key? key, required this.token}) : super(key: key);

  @override
  State<VisitorList> createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {
  int selectedIndex = 0;
  bool isLoading = false;
  HttpRequest getPassesHttp = HttpRequest();
  DateTime selectedDate = DateTime.now();
  int selectedDateFromCalendar = DateTime.now().day;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Date");
    //getAllPasses();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors().customGreenColor,
      padding: const EdgeInsets.only(left: 10),
      child: Scaffold(
        backgroundColor: CustomColors().customWhiteColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  size: 30, color: CustomColors().customGreenColor),
              onPressed: () {}),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
                color: CustomColors().customGreenColor,
              ),
              onPressed: () {},
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
              color:CustomColors().customGreenColor
            ),
          ),
        ),
        body:
            // isLoading
            //     ?
            Container(
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
                child: horizontalCalendar()

              ),
              Expanded(
                child: FutureBuilder<List>(
                  future: getPassesHttp.getAllPasses(widget.token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // if(index==0){
                            //   setState((){
                            //     selectedDate = stringToDateTime(snapshot.data![index]["date"]);
                            //   });
                            // }
                            return displayOnlyDate(snapshot.data![index]["date"])==selectedDateFromCalendar.toString() ?
                            singleVisitorTile(VisitorsDetailModel.fromJson(snapshot.data![index]), index):
                                index==1?
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                                    child: Center(child: Text("No record for Date "+selectedDateFromCalendar.toString(),style: TextStyle(fontSize: 20,color: CustomColors().customGreenColor),)),
                                  ):
                            Container();
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
          color: CustomColors().customWhiteColor,
        )
        //        : Center(child: CircularProgressIndicator())
        ,
        bottomSheet: CustomBottomSheet(addVisitor: addVisitor),
      ),
    );
  }

  void getAllPasses() async {
    print(DateTime.now());
    setState(() {
      isLoading = true;
    });

    List data = await getPassesHttp.getAllPasses(widget.token);
    print(data[0]);
  }

  Widget singleVisitorTile(VisitorsDetailModel visitorsDetail, int index) {
    return GestureDetector(
      onTap: () => setState(
        () {
          selectedIndex = index;
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
                  Column(
                    children: [
                      Text(displayOnlyHours(visitorsDetail.date),
                          style: TextStyle(
                              color: CustomColors().customTextGrey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                      Text("PM",
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
                      selectedIndex == index
                          ? Container(
                        // padding: EdgeInsets.all(7),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.all(Radius.circular(10)),
                        //   border: Border.all(
                        //     width: 1,
                        //     color: Colors.green,
                        //     style: BorderStyle.solid,
                        //   ),
                        // ),
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
                    color: selectedIndex == index
                        ? CustomColors().customGreenColor
                        : CustomColors().customTileColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: kElevationToShadow[4],
                  ),
                  //padding: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(5, 5, 30, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: CustomColors().customWhiteColor,
                          )),
                      Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Project meeting",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    displayHourAndMinutes(visitorsDetail.date),
                                    style: TextStyle(
                                      color: selectedIndex == index
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
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : CustomColors().customTextGrey,
                                      )),
                                  Text(visitorsDetail.phoneNo ?? "",
                                      style: TextStyle(
                                          //color: CustomColors().customTextGrey,
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : CustomColors().customTextGrey,
                                          fontSize: 12)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Creative inter tech",
                                style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : CustomColors().customTextGrey,
                                    //color: CustomColors().customTextGrey,
                                    fontSize: 12),
                              ),
                            ],
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String displayHourAndMinutes(String? date) {
    DateTime parseDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.Hm().format(inputDate);
    return outputDate;
  }

  String displayOnlyHours(String? date) {
    DateTime parseDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.H().format(inputDate);
    return outputDate;
  }

  String displayOnlyDate(String? date) {
    DateTime parseDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    var inputDate = DateTime.parse(parseDate.toString());
    //var outputDate = DateFormat.H().format(inputDate);
    var outputDate = DateFormat.d().format(inputDate);
    print(outputDate);
    return outputDate;
  }

  DateTime stringToDateTime(String? date) {
    DateTime parseDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date!);
    return parseDate;
  }

  horizontalCalendar() {
    return SingleChildScrollView(
        child: TableCalendar(
              calendarBuilders: CalendarBuilders(

                  markerBuilder: ((context, day, events) {
                    if(day.day == selectedDate.day) {
                      return Container(
                          height: 2.0,
                          width: 23.0,
                          color: CustomColors().customGreenColor
                      );
                    }
                  }),

                  defaultBuilder: (context,dateTime,datetime){
                    if(dateTime.day == selectedDate.day){
                      return Center(
                        child: Text(
                          dateTime.day.toString(),
                          style: TextStyle(color: CustomColors().customGreenColor),
                        ),
                      );
                    }
                  },

                  dowBuilder: (context, day) {
                    if (day.day == selectedDate.day) {
                      final text = DateFormat('EEE').format(day);
                      //final text = DateFormat.E('EEE').format(day);
                      return Center(
                        child: Text(
                          text,
                          style: TextStyle(color: CustomColors().customGreenColor),
                        ),
                      );
                    }
                  },

                  // selectedBuilder: (context,day,focusDay){
                  //   if(day.day == selectedDate.day)
                  //     return Container(child: Text("Ar"));
                  // }

              ),
              calendarStyle: CalendarStyle(),
              headerVisible: false,
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 1, 1),
              //focusedDay: DateTime.now(),
              focusedDay: selectedDate,


          startingDayOfWeek: StartingDayOfWeek.monday,

              onDaySelected: (date, events) {
                setState(() {
                  selectedDate = date;
                  selectedDateFromCalendar = date.day;
                });
                print(selectedDateFromCalendar);

              },
            ),
    );
  }


  addVisitor() {
    print("Add Visitor");
    Navigator.push(context,MaterialPageRoute(builder: (context)=>AddVisitor()));
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
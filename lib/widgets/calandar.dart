// import 'package:flutter/material.dart';
// import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
//
// class Full_Calendar extends StatefulWidget {
//   Full_Calendar({Key? key,required this.onSelectDate}) : super(key: key);
//   //Function onSelectDate;
//   VoidCallback onSelectDate;
//   @override
//   _Full_CalendarState createState() => _Full_CalendarState();
//
// }
//
// class _Full_CalendarState extends State<Full_Calendar> {
//
//   //int selectedIndex =  DateTime.now().day;
//   DateTime selectedDate = DateTime.now();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child:
//           Column(
//             children: [
//               TableCalendar(
//                 calendarBuilders: CalendarBuilders(
//
//                   markerBuilder: ((context, day, events) {
//                     if(day.day == selectedDate.day)
//                     return Container(
//                       height: 2.0,
//                       width: 23.0,
//                       color: CustomColors().customGreenColor
//                     );
//                   }),
//
//                   dowBuilder: (context, day) {
//                     if (day.day == selectedDate.day) {
//                       final text = DateFormat('EEE').format(day);
//                       //final text = DateFormat.E('EEE').format(day);
//                       return Center(
//                         child: Text(
//                           text,
//                           style: TextStyle(color: CustomColors().customGreenColor),
//                         ),
//                       );
//                     }
//                   },
//
//                   selectedBuilder: (context,day,focusDay){
//                     if(day.day == selectedDate.day)
//                     return Container(child: Text("Ar"));
//                   }
//
//                 ),
//                 calendarStyle: CalendarStyle(
//                 ),
//                 headerVisible: false,
//                 calendarFormat: CalendarFormat.week,
//                 firstDay: DateTime.utc(2010, 1, 1),
//                 lastDay: DateTime.utc(2030, 1, 1),
//                 //focusedDay: DateTime.now(),
//                 focusedDay: selectedDate,
//                 startingDayOfWeek: StartingDayOfWeek.monday,
//
//                 onDaySelected: (date, events) {
//                   //widget.onSelectDate;
//                   anotherFunction();
//                   // setState(() {
//                   //   selectedDate = date;
//                   // });
//                 },
//               ),
//               ElevatedButton(onPressed: widget.onSelectDate,
//                   child: Text("Press"))
//             ],
//           )
//     );
//   }
//
//   Function anotherFunction()=>
//     widget.onSelectDate;
// }
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';

class CalendarAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CalendarAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(148.0);

  @override
  State<CalendarAppBar> createState() => _CalendarAppBarState();
}

class _CalendarAppBarState extends State<CalendarAppBar> {

  ScrollController? _scrollController;
  DateTime now = DateTime.now();
  DateTime totalDaysOfMonth =  DateTime(DateTime.now().year, DateTime.now().month + 1,0);
  int selectedIndex =  DateTime.now().day;
  int testingDate = 15;
  @override
  void initState(){
    super.initState();
    _scrollController =  ScrollController(
      initialScrollOffset: calendarScrolingPosition(),
      keepScrollOffset: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            //width: 200,
            height : 80,
            child: GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(15),
              scrollDirection: Axis.horizontal ,
              itemCount:totalDaysOfMonth.day,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (context, index) {
                final dayName =  findFirstDayName(index);
                return  GestureDetector(
                  onTap: () => setState(
                        () {
                      selectedIndex = index;
                    },
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                          fontSize: 13  ,
                          color: selectedIndex == index
                              ? CustomColors().customGreenColor
                              : CustomColors().customTextGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //),
                      const SizedBox(height: 5),
                      Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 13,
                          color: selectedIndex == index
                              ? CustomColors().customGreenColor
                              : CustomColors().customTextGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Container(
                        height: 2.0,
                        width: 23.0,
                        color: selectedIndex == index
                            ? CustomColors().customGreenColor
                            : Colors.transparent,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
    );
  }

  calendarScrolingPosition() {
    print(now.day);
    if(now.day>=1 && now.day<8)
      {
        return 0.0;
      }
    else if(now.day>=8 && now.day<15)
    {
      return 400.0;
    }
    else if(now.day>=15 && now.day<21)
    {
      return 700.0;
    }
    else if(now.day>=21 && now.day<31)
    {
      return 1000.0;
    }
  }

  String findFirstDayName(int index) {
    print(DateFormat('EEE').format(now));
    final currentDate = now.add(Duration(days: index+3));
    return DateFormat('EEE').format(currentDate);
  }
}
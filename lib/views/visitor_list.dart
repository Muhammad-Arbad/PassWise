import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/models/visitor_details.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/widgets/visitor_page_bottom_sheet.dart';

class VisitorList extends StatefulWidget {
  String token;

  VisitorList({Key? key, required this.token}) : super(key: key);

  @override
  State<VisitorList> createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {
  bool isLoading = false;
  HttpRequest getPassesHttp = HttpRequest();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllPasses();
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
            preferredSize: const Size.fromHeight(10),
            child: Divider(
              color: CustomColors().customGreenColor,
              thickness: 3,
              indent: 170,
              endIndent: 170,
            ),
          ),
        ),
        body: isLoading
            ? Container(
          //padding: EdgeInsets.fromLTRB(10, 10, 20, 100),
          //padding: EdgeInsets.fromLTRB(10, 10, 10, 100),
                child: FutureBuilder<List>(
                  future: getPassesHttp.getAllPasses(widget.token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          // separatorBuilder: (context, index) => Divider(
                          //       color: Colors.red,
                          //     ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return singleVisitorTile(
                                VisitorsDetail.fromJson(snapshot.data![index]));
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                color: CustomColors().customWhiteColor,
              )
            : Center(child: CircularProgressIndicator()),
        bottomSheet: CustomBottomSheet(),
      ),
    );
  }

  void getAllPasses() async {
    setState(() {
      isLoading = true;
    });

    List data = await getPassesHttp.getAllPasses(widget.token);
    print(data[0]);
  }

  Widget singleVisitorTile(VisitorsDetail visitorsDetail) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text("07",style: TextStyle(color: CustomColors().customTextGrey,fontSize: 10,fontWeight: FontWeight.bold)),
                      Text("PM",style: TextStyle(color: CustomColors().customTextGrey,fontSize: 10,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 5,),
                  Column(
                    children: [
                      Container(
                          child: CustomPaint(
                            size: Size(13, 13),
                            painter: CirclePainter(),
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 60,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      )
                    ],
                  )
                ],
              )),
          Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors().customTileColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: kElevationToShadow[4],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex:1,child: Icon(Icons.calendar_month_outlined,color: CustomColors().customWhiteColor,)),
                    Expanded(flex:10,child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Project meeting",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("07:20",style: TextStyle(color: CustomColors().customTextGrey,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(visitorsDetail.name??"",style: TextStyle(color: CustomColors().customTextGrey),),
                            Text(visitorsDetail.phoneNo??"",style: TextStyle(color: CustomColors().customTextGrey)),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text("Creative inter tech",style: TextStyle(color: CustomColors().customTextGrey),),
                      ],
                    )
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}


class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = CustomColors().customGreenColor
    ..strokeWidth = 2
  // Use [PaintingStyle.fill] if you want the circle to be filled.
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



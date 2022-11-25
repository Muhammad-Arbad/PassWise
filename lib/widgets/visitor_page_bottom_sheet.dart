import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';


class CustomBottomSheet extends StatelessWidget {
   CustomBottomSheet({Key? key}) : super(key: key);

  HttpRequest get = HttpRequest();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors().customWhiteColor,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
          color: CustomColors().customGreenColor,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  boxShadow: kElevationToShadow[4],
                  color: CustomColors().customGreenColor,
                ),
                child: IconButton(icon: Icon(Icons.home,size: 30,color: Colors.white,),
                onPressed: ()async{
                  //await get.getAllPasses();
                },
                )),
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  boxShadow: kElevationToShadow[4],
                  color: CustomColors().customGreenColor,
                ),
                child: IconButton(icon:Icon(Icons.add_circle_outline,size: 30,color: Colors.white,),
                    onPressed: ()async{
                      await get.requestLogin('usman@gmail.com', '12345678');
                    }),
            ),

          ],
        ),
      ),
    );
  }
}
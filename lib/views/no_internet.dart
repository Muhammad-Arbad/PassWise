import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/views/splash.dart';


class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text("No internet",style: TextStyle(fontSize: 40),),
                Icon(Icons.signal_wifi_connected_no_internet_4,size: 80,),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                }, child: Text("Relod"))
              ]
          ),
        ),
      ),
    );
  }
}

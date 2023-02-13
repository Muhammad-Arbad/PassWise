import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/views/add_visitor.dart';
import 'package:passwise_app_rehan_sb/views/visitor_list.dart';
import 'package:passwise_app_rehan_sb/widgets/bustom_bottom_sheet.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_button.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SendQRCode extends StatefulWidget {
  String qrCode;
   SendQRCode({Key? key,required this.qrCode}) : super(key: key);

  @override
  State<SendQRCode> createState() => _SendQRCodeState();
}

class _SendQRCodeState extends State<SendQRCode> {
  GlobalKey globalKeyForImage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: OurScaffoldTemplate(
        appBarWidget: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text("Send QR Code"),
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
                child: Image.asset('assets/logo/logo.png'),
              ),
            ),
          ],
        ),
        showFAB: false,
        bottomSheet: CustomBottomSheet(
            home: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  VisitorList()), (Route<dynamic> route) => false);
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VisitorList(token: "token")));
              },
            addVisitor: (){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                  // AddVisitor(isEditing: false,)
                  AddVisitor()

              ));
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              //     AddVisitor()), (Route<dynamic> route) => false);
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddVisitor()));
            }),

        bodyWidget: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                50,
                20,
                50,
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).size.height * 0.20
                    : 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Share this QR code with your guest. Thank you for using this application",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                RepaintBoundary(
                  key: globalKeyForImage,
                  child: Container(
                    width: 270,
                    height: 270,
                    color: CustomColors().customWhiteColor,
                    child: Stack(children: [
                      Center(
                        child: QrImage(
                          data:widget.qrCode,
                          version: QrVersions.auto,
                          size: 250,
                          gapless: false,
                          embeddedImage: AssetImage('assets/qr_outside.png'),
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: Size(270, 270),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget(
                        btntext: "Save Image",
                        btnonPressed: ()=>saveQRtoGallery(context),
                        borderRadius: 10,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomButtonWidget(
                        btntext: "Share QR",
                        btnonPressed: (){
                          shareQR(context);
                          },
                        borderRadius: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        VisitorList()), (Route<dynamic> route) => false);
    return await true;
  }

  void saveQRtoGallery(BuildContext context) async {

    final RenderRepaintBoundary boundary =
    globalKeyForImage.currentContext!.findRenderObject() as RenderRepaintBoundary;
    //final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    //create file
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String fullPath = '$dir/${DateTime.now().millisecond}.png';
    File capturedFile = File(fullPath);
    await capturedFile.writeAsBytes(pngBytes);
    // print(capturedFile.path);



    await GallerySaver.saveImage(capturedFile.path,albumName: "PassWise").then((value) {
      // print(value);
      if(value==true){
        Fluttertoast.showToast(msg: "Image saved Successfully",backgroundColor: CustomColors().customGreenColor,gravity:ToastGravity.CENTER );
      }
      else{
        Fluttertoast.showToast(msg: "Failed to save",backgroundColor: Colors.red,gravity:ToastGravity.CENTER);
      }
    });

  }

  void shareQR(BuildContext context) async {

    final RenderRepaintBoundary boundary =
    globalKeyForImage.currentContext!.findRenderObject() as RenderRepaintBoundary;
    //final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    //create file
    final dir = (await getTemporaryDirectory()).path;
    final fullPath = '$dir/${DateTime.now().millisecond}.jpg';
    File(fullPath).writeAsBytesSync(pngBytes);
    Share.shareFiles([fullPath]);


      // final urlImage = "https://img.freepik.com/free-psd/google-icon-isolated-3d-render-illustration_47987-9777.jpg?w=826&t=st=1671539506~exp=1671540106~hmac=5ef339c7f640e8c38e46429dd4bb766a8737f2b996e793f006755ce039f12eb6";
      // final url = Uri.parse(urlImage);
      // final response = await http.get(url);
      // final bytes = response.bodyBytes;
      //
      // final temp = await getTemporaryDirectory();
      // final path = '${temp.path}/image.jpg';
      // File(path).writeAsBytes(bytes);
      //
      // Share.shareFiles([path]);

  }
}

import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';


class SendQRCode extends StatefulWidget {
  const SendQRCode({Key? key}) : super(key: key);

  @override
  State<SendQRCode> createState() => _SendQRCodeState();
}

class _SendQRCodeState extends State<SendQRCode> {
  @override
  Widget build(BuildContext context) {
    return OurScaffoldTemplate(
        appBarWidget: Container(),
        showFAB: false,
        bodyWidget: Container());
  }
}

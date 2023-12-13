


import 'package:flutter/material.dart';

class QrCodeResult extends StatelessWidget {
  String? result;
  QrCodeResult({Key? key,this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('QR Code Result'),
        centerTitle: true,
      ),


      body: Column(

      ),

    );
  }
}

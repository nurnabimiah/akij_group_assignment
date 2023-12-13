




import 'package:flutter/material.dart';


class ResultPage extends StatelessWidget {
  final String qrCodeResult;
   // Provide the path or URL of the scanned object image

  ResultPage({required this.qrCodeResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('QR Code Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QR Code Result:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              qrCodeResult,
              style: TextStyle(fontSize: 18),
            ),
            // SizedBox(height: 20),
            // Text(
            //   'Scanned Object Image:',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // Image.memory(
            //   scannedObjectImage as Uint8List,
            //   width: 200,
            //   height: 200,
            //   // You can adjust the width and height as needed
            // ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.withOpacity(0.5),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),





    );
  }
}

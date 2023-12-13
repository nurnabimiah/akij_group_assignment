

import 'dart:developer';

import 'package:assignment_akij/utils/app_textstyle/app_text_style.dart';
import 'package:assignment_akij/view/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class QrcodeScreen extends StatefulWidget {
  static const String routeName = '/qrscreen_route';
  const QrcodeScreen({Key? key}) : super(key: key);

  @override
  State<QrcodeScreen> createState() => _QrcodeScreenState();
}

class _QrcodeScreenState extends State<QrcodeScreen> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('QR Scanner'),
        centerTitle: true,
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child:  Center(child: Text('Place the qr code in the area',style: myStyleRoboto(18.sp, Colors.black87,FontWeight.w600),)),
            ),

            Expanded(
                flex: 4,
                child: Container(
                decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),),
                child: _buildQrView(context),
            )

            ),
            SizedBox(height: 20.h,),


            result != null ? Expanded(child: Center(
                child: Text(
                  'Barcode Result: ${result!.code}',
                  style: myStyleRoboto(18.sp, Colors.black87, FontWeight.w600),
                ),
              ),
            )
                : CustomButton(buttonText: 'Scan Me', onTap: () {}),

            SizedBox(height: 100.h,)


          ],
        ),
      ),

    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 320.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


}





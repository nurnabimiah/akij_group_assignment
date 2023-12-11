

import 'dart:developer';

import 'package:assignment_akij/utils/app_textstyle/app_text_style.dart';
import 'package:assignment_akij/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QrcodeScreen extends StatefulWidget {
//   static const String routeName = '/qrscreen_route';
//   const QrcodeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<QrcodeScreen> createState() => _QrcodeScreenState();
// }
//
// class _QrcodeScreenState extends State<QrcodeScreen> {
//
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue.withOpacity(0.8),
//         title: Text('QR Scanner'),
//         centerTitle: true,
//       ),
//
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//                 child:  Center(child: Text('Place the qr code in the area',style: myStyleRoboto(18.sp, Colors.black87,FontWeight.w600),)),
//             ),
//
//             Expanded(
//                 flex: 4,
//                 child: Container(
//                 decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.1),
//                 borderRadius: BorderRadius.all(Radius.circular(10.r)),),
//                 child: _buildQrView(context),
//             )
//
//             ),
//             SizedBox(height: 20.h,),
//
//
//             result != null ? Expanded(child: Center(
//                 child: Text(
//                   'Barcode Result: ${result!.code}',
//                   style: myStyleRoboto(18.sp, Colors.black87, FontWeight.w600),
//                 ),
//               ),
//             )
//                 : CustomButton(buttonText: 'Scan Me', onTap: () {}),
//
//             SizedBox(height: 100.h,)
//
//
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//         MediaQuery.of(context).size.height < 400)
//         ? 300.0
//         : 320.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }


import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
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
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    await cameraController!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('QR Scanner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Place the QR code in the area',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                child: _buildQrView(context),
              ),
            ),
            SizedBox(height: 20.h),
            result != null
                ? Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Barcode Result: ${result!.code}',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (cameraController != null) {
                          XFile imageFile = await cameraController!.takePicture();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                qrCodeResult: result!.code.toString(),
                                capturedImageFile: File(imageFile.path),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Capture Image'),
                    ),
                  ],
                ),
              ),
            )
                : CustomButton(buttonText: 'Scan Me', onTap: () {}),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 300.0 : 320.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
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
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    controller?.dispose();
    super.dispose();
  }
}

class ResultScreen extends StatelessWidget {
  final String qrCodeResult;
  final File capturedImageFile;

  const ResultScreen({Key? key, required this.qrCodeResult, required this.capturedImageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Scanned QR Code: $qrCodeResult'),
          SizedBox(height: 20.h),
          Image.file(
            capturedImageFile,
            width: 200.w,
            height: 200.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

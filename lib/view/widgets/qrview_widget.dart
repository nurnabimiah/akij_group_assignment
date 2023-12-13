



import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// Widget buildQrView(BuildContext context, Function(QRViewController) onQRViewCreated, Barcode? result) {
//   var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
//       ? 300.0
//       : 320.0;
//
//   return QRView(
//     key: GlobalKey(debugLabel: 'QR'),
//     onQRViewCreated: onQRViewCreated,
//     overlay: QrScannerOverlayShape(
//       borderColor: Colors.red,
//       borderRadius: 10,
//       borderLength: 30,
//       borderWidth: 10,
//       cutOutSize: scanArea,
//     ),
//     onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//   );
// }
//
// void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//   if (!p) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('No Permission')),
//     );
//   }
// }




import 'package:assignment_akij/view/screens/qrcode/qrcode_screen.dart';
import 'package:assignment_akij/view/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


import '../map/MapExample.dart';
import '../product/order_form.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_route';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? currentLocation;
  //final double targetLat = 37.7749; // Replace with your target latitude
  //final double targetLon = -122.4194;


    getPossition() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      Position datas = await _determinePosition();

      print("Current Location: $datas");

      setState(() {
        currentLocation = datas;
      });

      GetAddressFromLatLong(datas);
    }
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    var Address =
        '${place.street},${place.subLocality}, ${place.thoroughfare},${place.locality}, ${place.postalCode}, ${place.country}';
    print(Address);
    var lat = position.latitude;
    var lon = position.longitude;
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CurrentLocationMapScreen(latitude: lat, longitude: lon,currentLocation: currentLocation,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('Home'),
        centerTitle: true,
      ),


      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:20.w),
        child: Column(
          children: [
            SizedBox(height: 250.h,),
            //........qr code scan..............................................
            CustomButton(
              buttonText: 'Scan Qr Code',
              onTap: () { Get.toNamed(QrcodeScreen.routeName);  },),
            SizedBox(height: 15.h,),


            CustomButton(buttonText: 'Google Map', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return FutureBuilder(
                    future: getPossition(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Operation completed, navigate to the next screen
                        return CurrentLocationMapScreen(
                          latitude: currentLocation?.latitude ?? 0,
                          longitude: currentLocation?.longitude ?? 0,
                          currentLocation: currentLocation,
                        );
                      } else {
                        // Show a loading indicator or any other UI while waiting
                        return CircularProgressIndicator();
                      }
                    },
                  );
                }),
              );
            }),







            SizedBox(height: 15.h,),


            CustomButton(buttonText: 'Product Order', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderForm()));
            },),



          ],
        ),
      ),


    );
  }
}

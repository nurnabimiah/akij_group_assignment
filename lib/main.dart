import 'package:assignment_akij/view/screens/home/home_screen.dart';
import 'package:assignment_akij/view/screens/map/punch_list_screen.dart';
import 'package:assignment_akij/view/screens/qrcode/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'di_container.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jam Tv',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0
              ),
              useMaterial3: true,
              primarySwatch: Colors.blue,
            ),
            initialRoute: HomeScreen.routeName,
            getPages: [
             GetPage(name: HomeScreen.routeName, page: ()=>HomeScreen()),
             GetPage(name: QrcodeScreen.routeName, page: ()=>QrcodeScreen()),
             GetPage(name: PunchListScreen.routeName, page: ()=>PunchListScreen()),

            ],
          );
        }
    );
  }
}




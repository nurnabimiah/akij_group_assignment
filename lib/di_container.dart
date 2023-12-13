



import 'package:assignment_akij/controller/map_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/orderform_controller.dart';





final sl = GetIt.instance;

Future<void> init() async {

  /// Controller
  Get.lazyPut(() => OrderFormController(), fenix: true);
  Get.lazyPut(() => MapController(), fenix: true);




  /// External pocket lock
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
 // sl.registerLazySingleton(() => Dio());
}



import 'package:assignment_akij/utils/app_textstyle/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/map_controller.dart';


class PunchListScreen extends StatelessWidget {
  static const String routeName = '/punch_list_route';
  final MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text('Punch List Screen'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Trigger a refresh by calling the fetchData method
          await mapController.fetchData();
        },
        child: Obx(() {
          if (mapController.punchList.value.data.isEmpty) {
            // Data not loaded yet or empty, show loading indicator or a message
            return Center(
              child: mapController.punchList.value.data.isEmpty
                  ? CircularProgressIndicator()
                  : Text('No punch list data available.'),
            );
          } else {
            return ListView.builder(
              itemCount: mapController.punchList.value.data.length,
              itemBuilder: (context, index) {
                final punchListData = mapController.punchList.value.data[index];
                final formattedDateTime = DateFormat('hh:mm a').format(punchListData.createdAt);

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child:
                  Card(

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ID: ${punchListData.id}',style: myStyleRoboto(14.sp, Colors.black87,FontWeight.w500),),
                              Text('${formattedDateTime}',style: myStyleRoboto(14.sp, Colors.black87,FontWeight.w500)),

                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Text('Lat: ${punchListData.lat}, Long: ${punchListData.long}'),
                        ],
                      ),
                    )
                    // ListTile(
                    //   title: Text('ID: ${punchListData.id}'),
                    //   subtitle: Text('Lat: ${punchListData.lat}, Long: ${punchListData.long}'),
                    //
                    // ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}



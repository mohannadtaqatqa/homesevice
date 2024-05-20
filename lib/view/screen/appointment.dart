import 'package:flutter/material.dart';
import 'package:homeservice/view/screen/appint_user.dart';
import 'package:homeservice/view/screen/request_page.dart';

import '../../generated/l10n.dart';

class Appointement extends StatelessWidget {
  const Appointement({super.key});

  static  List<Tab> myTabs = <Tab>[
    Tab(child:Text( S.current.myRequests)),
    Tab(child: Text(S.current.myAppointments)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            tabs: myTabs,
          ),
        ),
        body: const TabBarView(children: [
          Request(),
          AppointmentPage()
        ]
            // myTabs.map((Tab tab) {
            //   final String label = tab.text!.toLowerCase();
            //   return Center(
            //     child: Text(
            //       'This is the $label tab',
            //       style: const TextStyle(fontSize: 36),
            //     ),
            //   );
            // }).toList(),
            ),
      ),
    );
  }
}

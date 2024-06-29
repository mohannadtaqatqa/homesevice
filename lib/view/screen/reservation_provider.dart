import 'package:flutter/material.dart';
import 'package:homeservice/data/model/Request_provider.dart';
import 'package:homeservice/view/widgit/AppointmentPage_provider.dart';

import '../../generated/l10n.dart';

class reservation_provider extends StatelessWidget {
  const reservation_provider({super.key});

  static  List<Tab> myTabs = <Tab>[
    Tab(text: S.current.Requestsforme),
    Tab(text: S.current.myAppointments),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom:  TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            tabs: myTabs,
          ),
        ),
        body: const TabBarView(children: [
          Requestprovider(),
          AppointmentPage_provider()]
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
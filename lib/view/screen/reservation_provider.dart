import 'package:flutter/material.dart';
import 'package:homeservice/data/model/Request_provider.dart';
import 'package:homeservice/view/widgit/AppointmentPage_provider.dart';

class reservation_provider extends StatelessWidget {
  const reservation_provider({super.key});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'طلبات لي'),
    Tab(text: 'مواعيدي'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            tabs: myTabs,
          ),
        ),
        body: const TabBarView(children: [
          Request_provider(),
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
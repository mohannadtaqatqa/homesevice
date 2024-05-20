import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../core/utilti/Color.dart';
import '../../generated/l10n.dart';

class arc_card extends StatefulWidget {
  final String name1;
  final String name2;
  final String phone;
  final String servicename;
  final String datereq;
  final String descrbtion;
  final String city;
  final String address;
  final int requestid;
  const arc_card({super.key, required this.name1, required this.name2, required this.phone, required this.servicename, required this.datereq, required this.descrbtion, required this.city, required this.address, required this.requestid});

  @override
  State<arc_card> createState() => _arc_cardState();
}
Future<void> _reject(requestid) async {
  await post(Uri.parse('http://10.0.2.2:5000/rework/$requestid'));
}
class _arc_cardState extends State<arc_card> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
        height: MediaQuery.sizeOf(context).height * .39,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 80,
                    color: mainColor,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " ${widget.name1} ${widget.name2}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            "${widget.city}-${widget.address}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.grey, height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).phoneNumber}:",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${widget.phone}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey, height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).theService}:",
                          style:
                          TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${widget.servicename}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey, height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).description}:",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                         Flexible(
                          child: Text(
                            "${widget.descrbtion}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey, height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).date}:",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                         Text(
                          "${widget.datereq}",
                          style: const TextStyle(fontSize: 15),

                        ),

                      ],

                    ),
                   const SizedBox(height: 30,),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            _reject(widget.requestid);

                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: mainColor,
                          ),
                          child:  Text(S.of(context).reject)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

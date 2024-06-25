import 'package:flutter/material.dart';
class Authpage extends StatelessWidget {
  const Authpage({super.key, this.iconData, this.onTap, this.color});
final IconData? iconData;
final VoidCallback? onTap;
final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),
        child: Row(
          children: [
            Padding(padding:const EdgeInsets.all(10),child: Icon(iconData,size: 30,color: color,))
          ],
        ),
      )
    );
  }
}

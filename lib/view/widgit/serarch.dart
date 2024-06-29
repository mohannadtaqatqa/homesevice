import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/color.dart';

class Search extends StatelessWidget {
   Search({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String searchValue = '';
    return Padding(
      
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        
        height: 45,
        width: 200,
        
        // Add padding around the search bar
      //  padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Use a Material design search bar
        child: TextField(
          
          
          cursorColor: mainColor,
          controller: _searchController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
            hoverColor: mainColor,
            fillColor: Colors.grey[400],
            hintText: 'بحث عن مقدم خدمة',
            hintStyle: const TextStyle(fontFamily: 'Cairo',),
            // Add a clear button to the search bar
            // suffixIcon: IconButton(
            //   icon: Icon(Icons.clear),
            //   onPressed: () => _searchController.clear(),
            // ),
            // Add a search icon or button to the search bar
            prefixIcon: IconButton(
              icon: Icon(Icons.search,color: mainColor,),
              onPressed: () {
                // Perform the search here
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: mainColor)
            ),
          ),
        ),
      ),
    );
  }
}
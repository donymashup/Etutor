import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SearchableDropdownExample extends StatefulWidget {
  @override
  _SearchableDropdownExampleState createState() => _SearchableDropdownExampleState();
}

class _SearchableDropdownExampleState extends State<SearchableDropdownExample> {
  String? selectedCountry;
  
  List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Germany',
    'France',
    'Japan',
    'Australia',
    'India',
    'Brazil',
    'Mexico',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Searchable Dropdown'),
      // ),
      body:
       Padding(
        padding: EdgeInsets.all(16.0),
        child:
        //  Column(
        //   children: [
            // Advanced searchable dropdown with custom filtering
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
              child: DropdownSearch<String>(
                items: countries,
                selectedItem: selectedCountry,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue;
                  });
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Type to search...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  itemBuilder: (context, item, isSelected) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      // decoration: BoxDecoration(
                      //   color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                      // ),
                      child: Text(
                        item,
                        style: TextStyle(
                        //  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                  //  labelText: "Advanced Search",
                    hintText: "Search Course here",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    // OutlineInputBorder(
                    //   borderSide: BorderSide(color: AppColor.whiteColor),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                ),
                filterFn: (item, filter) {
                  return item.toLowerCase().contains(filter.toLowerCase());
                },
              ),
            ),
            
           // SizedBox(height: 20),
            
            // if (selectedCountry != null)
            //   Card(
            //     child: Padding(
            //       padding: EdgeInsets.all(16),
            //       child: Text(
            //         'Selected: $selectedCountry',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
        //   ],
        // ),
      ),
    );
  }
}
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybarter/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:mybarter/ipconfig.dart';
import 'package:mybarter/models/item.dart';
import 'package:mybarter/views/screens/Bartercoinsuccess.dart';
import 'package:mybarter/views/screens/profiletabscreen.dart';
import 'package:firebase_database/firebase_database.dart';

class ProceedBarterScreenState extends StatefulWidget {
  final User user;
  final item useritem;
  const ProceedBarterScreenState({super.key, required this.user, required this.useritem});

  @override
  State<ProceedBarterScreenState> createState() => ProceedBarterScreenStateState();
}

class ProceedBarterScreenStateState extends State<ProceedBarterScreenState> {
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
   double totalcredit = 0.0;
  List<String> shipmethod = ["pick up","Delivery"];
  String selectedmethod = "pick up";
  double price = 0.0;
  int barterid = 0;
  @override
  void initState() {
    super.initState();

    print("ProceedBarter");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }
   

   @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Proceed To Barter", style: TextStyle(color: Colors.black),),
     backgroundColor: Colors.amber[200],
      foregroundColor: Colors.amber[800],),
      body: Center(
        child: Column(children: [
               Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
             color: Colors.amber[100],
             child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.user.name.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                        child: Divider(
                          color: Colors.blueGrey,
                          height: 2,
                          thickness: 2.0,
                        ),
                      ),
                    Table(
                        columnWidths: const {
                          0: FractionColumnWidth(0.3),
                          1: FractionColumnWidth(0.7)
                        },
                    defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const Icon(Icons.email),
                            Text(widget.user.email.toString()),
                          ]),
                        TableRow(children: [
                            const Icon(Icons.phone),
                            Text(widget.user.phone.toString()),
                          ]),  
                           TableRow(children: [
                            const Icon(Icons.currency_bitcoin,),
                            Text(widget.user.totalcredit.toString()),
                          ]), 
                          TableRow(children: [
                                  const Icon(Icons.date_range),
                                  Text(widget.user.datereg.toString())
                                        
                                          ],
                                        ),
                                      ],
                                    ),
                                      ],
                                ),

               ),      
           Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: screenWidth,
                            height: screenHeight * 0.2,
                            child: Row(
                              children: [
                                Container(
                                  height: screenHeight * 0.2,
                                  width: screenWidth * 0.4,
                                  child: CachedNetworkImage(
                                    width: screenWidth * 0.4,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "${MyConfig().SERVER}/mybarter/assets/items/${widget.useritem.itemId}_image0.png?timestamp=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 6,
                                  child:  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(4),
                                      1: FlexColumnWidth(6),
                                    },
                                    children: [
                                      TableRow(children: [
                                        const TableCell(
                                          child: Text(
                                            "item Type",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            widget.useritem.itemType.toString(),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        const TableCell(
                                          child: Text(
                                            "Quantity Available",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            widget.useritem.itemQty.toString(),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        const TableCell(
                                          child: Text(
                                            "value",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            "RM ${double.parse(widget.useritem.itemValue.toString()).toStringAsFixed(2)}",
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        const TableCell(
                                          child: Text(
                                            "Location",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            "${widget.useritem.itemLocality}/${widget.useritem.itemState}",
                                          ),
                                        )
                                      ]),
                                    
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),//
             Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Card(
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    child: Column(
                      children: [
                        const Text("PAY BARTER COIN  TO BARTER",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Text("Please select item shipping method "),
                        SizedBox(
                          height: 60,
                          child: DropdownButton(
                            //sorting dropdownoption
                            // Not necessary for Option 1
                            value: selectedmethod,
                            onChanged: (newValue) {
                              setState(() {
                                selectedmethod = newValue!;
                                print(selectedmethod);
                              });
                            },
                            items: shipmethod.map((selectedType) {
                              return DropdownMenuItem(
                                value: selectedType,
                                child: Text(
                                  selectedType,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             
                                Text(
                                  "Barter coin: ${double.parse(widget.useritem.itemValue.toString()).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                               Icon(
                                  Icons.currency_bitcoin,
                                  size: 16,
                                ),
                            ]),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("Barter"),
                          onPressed: _ConfirmDialog,
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth / 2, 50)),
                        ),
                      ],
                    ),
                  ),
                )),

        ],
      )));
  }
void _ConfirmDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            "Tranfer Barter Coin " +
                double.parse(widget.useritem.itemValue.toString()).toStringAsFixed(2) +
                "?",
            style: const TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
               onPressed: () async {
               
              Navigator.of(context).pop();

              // Deduct the itemValue from the totalcredit
              double deductionAmount = double.parse(widget.useritem.itemValue.toString());
              String curcredit = widget.user.totalcredit.toString();
              double ncurcredit =double.parse(curcredit.toString());
              double newTotalCredit =  ncurcredit- deductionAmount;
              

              // Update the newtotalcredit in the state
              setState(() {
                 totalcredit = newTotalCredit;
                
              });

              // Update the totalcredit on the server
              await updatetotalcredit();
             
              deleteitem();
              
              // Proceed to the BillPage
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BartercoinsuccesScreen(user: widget.user, useritem: widget.useritem),
                ),
              );

            },
            ),
            
            TextButton(
              
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
updatetotalcredit() async {
      http.post(Uri.parse('${MyConfig().SERVER}/mybarter/php/updatetotalcredit.php'),
 body: {
    'userid': widget.user.id,
    'totalcredit': totalcredit.toString(),
  }).then((response) {

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'success') {
      setState(() {
        widget.user.setTotalCredit(totalcredit.toString());
        
        
              });
      // The update was successful
      print('Total credit updated successfully');
    } else {
      // The update failed
      print('Failed to update total credit');
    }
  } else {
    // There was an error with the HTTP request
    print('Failed to update total credit');
  }
  });
  }

 void deleteitem() {
    http.post(Uri.parse("${MyConfig().SERVER}/mybarter/php/delete_item.php"),
        body: {
          "userid": widget.user.id,
          "itemid": widget.useritem.itemId
        }).then((response) {
      print(response.body);
      //itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Barter coin pay successfully")));
         
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }

}

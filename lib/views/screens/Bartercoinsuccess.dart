import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mybarter/models/user.dart';
import 'package:mybarter/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mybarter/ipconfig.dart';
import 'package:mybarter/views/screens/mainscreen.dart';

class BartercoinsuccesScreen extends StatefulWidget {
  final User user;
  final item useritem; 

  const BartercoinsuccesScreen(
      {super.key,required this.user, required this.useritem,});

  @override
  State<BartercoinsuccesScreen> createState() => _BartercoinsuccesScreen();
}

class _BartercoinsuccesScreen extends State<BartercoinsuccesScreen> {
  final df = DateFormat('dd/MM/yyyy');
  late double screenHeight, screenWidth, cardwitdh;
  late User user = User(
    id: "na",
    email: "na",
    name: "na",
    password: "na",
    otp: "na",
    datereg: "na",
    phone: "na",
   
  );

  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barter Coin Payment"),
       backgroundColor: Colors.amber[200],
      foregroundColor: Colors.amber[800],
        elevation: 0,
      ),
      backgroundColor: Colors.amber[50],
      body: Center(
        child: Column(
          children: [
         
                Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.24,
              width: screenWidth,
              child: Card(
                color: Colors.amber[500],
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.all(11),
                    width: screenWidth * 0.25,
                    child: Image.asset(
                      "assets/images/Barterlogo.png",
                    ),
                  ),
                  
                  Expanded(
                      flex: 6,
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "MY BARTER SDN.BHD",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 5, 8),
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
                            children: const [
                              TableRow(children: [
                                Icon(Icons.email),
                                Text(
                                  "MYBarter1212@gmail.com",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ]),
                              TableRow(children: [
                                Icon(Icons.phone),
                                Text(
                                  "04-4907856",
                                ),
                              ]),
                            ],
                          ),
                        ],
                      )),
                ]),
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
                     ),
            
            const Divider(
              color: Colors.blueGrey,
              height: 50,
              thickness: 2.0,
            ),
              const Padding(
                  
              padding: EdgeInsets.fromLTRB(17, 0, 100, 20),
             
              child: Text(
                "Total Barter Coin To Pay", style: TextStyle(fontSize: 22,),
              ),
              
            ),
             Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 100,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Barter Coin " + widget.useritem.itemValue.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                            Icon(
                                  Icons.currency_bitcoin,
                                  size: 20,
                                ),
                        ],
                      ),
                    ),
          
            const Divider(
              color: Colors.blueGrey,
              height: 20,
              thickness: 2.0,
            ),
            
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async{
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Barter Succesfull")));
                          await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(user: widget.user),
                ),
              );
                    },
                    child: const Text(
                      "Successful Payment",
                      style: TextStyle(fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Payment Fail")));
                    },
                    child: const Text("Fail Payment",
                        style: TextStyle(fontSize: 16))),
              ],
            )
          ],
        ),
      ),
    );
  }

  /*Future<void> successfulPay() async {
    Navigator.of(context).pop();
    await http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit/php/update_profile.php"), // Need to change
        body: {
          
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == "success") {
          //user = User.fromJson(jsondata['data']);   //error
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Fail")));
        }
      }
      setState(() {});
    }).timeout(const Duration(seconds: 5));
  }*/
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybarter/models/user.dart';
import 'package:mybarter/views/screens/editprofilescreen.dart';
import 'package:mybarter/views/screens/loginscreen.dart';
import 'package:mybarter/views/screens/mainscreen.dart';
import 'package:mybarter/views/screens/registrationscreen.dart';
import 'package:http/http.dart' as http;
import 'package:mybarter/ipconfig.dart';
import 'package:mybarter/models/item.dart';


// for profile screen

class ProfileTabScreen extends StatefulWidget {
  final User user;
 
  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight, screenWidth, cardwitdh;
  final df = DateFormat('dd/MM/yyyy');
  List<item> itemList = <item>[];
  double totalcredit =0.0;
   bool isDisable = true;
  @override
  void initState() {
    super.initState();
    
    loadbarteritems();
    print("Profile");
  }

  @override
  void dispose() {
    super.dispose();
     if (widget.user.id == "na") {
      isDisable = true;
    } else {
      isDisable = false;
    }
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle,style: TextStyle(color: Colors.black,),),
        backgroundColor: Colors.amber[200],
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Logout'),
                        onPressed: logout, // Call logout() method
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        
      ),
      backgroundColor: Colors.amber[50],
      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
             color: Colors.amber[200],
            child: Card(
              color: Colors.amber[500],
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(4),
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    "assets/images/Profilepic.jpg",
                  ),
                ),
                Flexible(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                          widget.user.name.toString() == "na"
                             ?const Column(
                                children: [
                                  Text(
                                    "Not Available",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                ],
                             )
                           :Column(   children: [
                            
                          Text(widget.user.name.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                            child: Divider(
                              color: Colors.amber,
                              height: 3,
                              thickness: 6.0,
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
                                      const Icon(Icons.date_range),
                                      Text(df.format(DateTime.parse(
                                          widget.user.datereg.toString())))
                                    ]),
                            
                          
                             ]),
                             //table, children
                             IconButton(
                                     onPressed: () {
                                                      
                                      Navigator.push(
                                          context,
                                            MaterialPageRoute(
                                               builder: (content) =>  EditProfileScreen(user: widget.user)));
                                                ////////
                                                   },
                                                  icon: const Icon(Icons.edit_square,color: Colors.black)
                                                  )
                                                 
                              ],
                              )
                              ]
                              )
                              ),
                                              ]
                                              ),
                              
            ),
          ),
                    Container(
  width: screenWidth,
  alignment: Alignment.center,
  color: Colors.amber[300],
  child: Padding(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Total Barter Coin: ${widget.user.totalcredit}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.currency_bitcoin,
          size: 20,
        ),
      ],
    ),
  ),
),

          Expanded(
              child: ListView(
            children: [
             
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
                },
                child: const Text("LOGIN"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const RegistrationScreen()));
                },
                child: const Text("REGISTRATION"),
              ),
            ],
          ))
        ]),
      ),
    );
  }
  
  ///////

void loadbarteritems() {
    http.post(Uri.parse("${MyConfig().SERVER}/mybarter/php/load_items.php"),
        body: {
          "userid": widget.user.id,
          
        }).then((response) {
      //print(response.body);
     
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(item.fromJson(v));
          });
         

         
        }
        setState(() {});
      }
    });
  }
  
  
  void logout() {
    setState(() {
      widget.user.id == "na";
      isDisable = true;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(user: widget.user)),
      (Route<dynamic> route) => false,
    );
  }
 
  
  
}
import 'package:flutter/material.dart';

import 'package:flutter_application_2/ProvidersApi/authentication.dart';
import 'package:flutter_application_2/screens/OtpVerification.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var loadingstate = false;
  TextEditingController mobilenum = TextEditingController();
  @override
  void initState() {
   

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadingstate
          ? const Align(alignment: Alignment.center, child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20, top: 120),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/logo.png'),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: '+91',
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Text(
                            "|",
                            style: TextStyle(fontSize: 33, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: mobilenum,
                            
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mobile no",
                              
                              
                            ),
                            
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7,right: 7),
                      child: SizedBox(
                        width: double.infinity,
                        height: 35,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green.shade600,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              try {
                                setState(() {
                                  loadingstate = true;
                                });
                                await Provider.of<Auth>(context, listen: false)
                                    .authOtp(mobilenum.text);
                                setState(() {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) => const MyVerify()));
                                  loadingstate = false;
                                });
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: const Text("Alert Dialog Box"),
                                        content: const Text("Error occured"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("okay"),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text("Continue")),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }


}

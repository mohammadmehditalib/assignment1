import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/ProvidersApi/authentication.dart';
import 'package:flutter_application_2/screens/landingPage.dart';
import 'package:flutter_application_2/screens/FinalPage.dart';
import 'package:provider/provider.dart';

class MyRegistration extends StatefulWidget {
  const MyRegistration({super.key});

  @override
  State<MyRegistration> createState() => _MyRegistrationState();
}

class _MyRegistrationState extends State<MyRegistration> {
  var loadingstate = false;
  

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
        child: loadingstate
            ? const Align(alignment: Alignment.center, child: CircularProgressIndicator())
            : Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Looks like you are new here. Tell us bit about yourself',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(hintText: 'Name'),
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          else{
                            return null;
                          }
                          
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(hintText: 'Email'),
                          controller: email,
                          validator: validateEmail),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade600,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          setState(() {
                            loadingstate = true;
                          });
                          try {
                            await Provider.of<Auth>(context, listen: false)
                                .Register(name.text, email.text);

                            setState(() {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => const MyHomePage1()));
                              loadingstate = false;
                            });
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Alert Dialog Box"),
                                    content: const Text(" Error Occurred"),
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
                        child: const Text('Submit')),
                  )
                ],
              ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
       
       
        return null;
        
      } else {
        return 'Enter a Valid Email Address';
      }
    } else {
      return 'Enter email address';
    }
  }
}

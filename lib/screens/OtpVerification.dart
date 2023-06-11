import 'package:flutter/material.dart';
import 'package:flutter_application_2/ProvidersApi/authentication.dart';
import 'package:flutter_application_2/screens/FinalPage.dart';
import 'package:flutter_application_2/screens/RegistrationPage.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  late var otp = '';
  var loadingstate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: loadingstate
          ? const Align(alignment: Alignment.center, child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left:20 ,right:20 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 120),
                    child:   Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/logo.png'),
                        ),
                      ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Enter OTP",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "OTP has been sent to +91-number",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    onCompleted: (pin) => {otp = pin},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
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
                            final response = await Provider.of<Auth>(context, listen: false)
                                .verifyOtp(otp.toString());
                           setState(() {
                              if (response['profile_exists']) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const MyHomePage1()));
                            } else {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => const MyRegistration()));
                            }
                           });
                           
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Alert Dialog Box"),
                                    content: const Text(" Invalid otp"),
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
                          setState(() {
                            loadingstate = false;
                          });
                        },
                        child: const Text("Verify")),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

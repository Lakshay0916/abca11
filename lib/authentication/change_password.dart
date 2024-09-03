import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forgot_password extends StatefulWidget {
  const Forgot_password({Key? key}) : super(key: key);

  @override
  State<Forgot_password> createState() => _Forgot_passwordState();
}

class _Forgot_passwordState extends State<Forgot_password> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(width*.05),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/DRIP_16.png"),
                  ],
                ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot Password?",style: TextStyle(
                          color: Color(0xff7785FC),
                          fontSize: 25,
                          fontWeight: FontWeight.w900
                      ),),
                    ],
                  ),
                  SizedBox(height: 26,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Enter registered E-mail address",style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff42414D)
                    ),),
                  ),
                  SizedBox(
                    height: 55,
                    width: width * .9,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType:
                      TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: Color(0xff8294C4)),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        filled: true,
                        fillColor: Color(0xffF8F8FF),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Color(0xFFF8F8FF)
                            ),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        suffixIcon: const Icon(
                          Icons.mail_outline_rounded,
                          color: Color(0xFF7E7E7E),
                          size: 20,
                        ),
                        hintText: "ex: john.22cse@bmu.edu.in",
                        hintStyle: const TextStyle(
                          color: Color(0xFF7E7E7E),
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.red,
                              width: .5
                          ),
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: width,
                      height: 55,

                      decoration: BoxDecoration(
                          color: Color(0xff7785FC),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  const SizedBox(height: 15,),


                ],
              )
          ),
        ),
      ),
    );
  }
}

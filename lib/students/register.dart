import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial_palmbook/logics/utils.dart';
import 'package:trial_palmbook/main.dart';

class Register extends StatefulWidget {
  final VoidCallback showLoginPage;

  const Register({
    Key? key,
    required this.showLoginPage,
  }) : super(key:key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                children: [const SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/DRIP_16.png"),
                  ],
                ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Join PalmBook!",style: TextStyle(
                          color: Color(0xff7785FC),
                          fontSize: 25,
                          fontWeight: FontWeight.w900
                      ),),
                    ],
                  ),
                  const SizedBox(height: 26,),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("E-mail address",style: TextStyle(
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
                            borderSide: const BorderSide(width: 1,color: Color(0xff8294C4)),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        filled: true,
                        fillColor: const Color(0xffF8F8FF),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
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
                  const Padding(
                    padding: EdgeInsets.only(left: 15,top: 20),
                    child: Text("Password",style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff42414D)
                    ),),
                  ),
                  SizedBox(
                    height: 55,
                    width: width * .9,
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: true,
                      obscuringCharacter: "*",
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1,color: Color(0xff8294C4)),
                            borderRadius: BorderRadius.circular(12)
                        ),

                        filled: true,
                        fillColor: const Color(0xFFF8F8FF),

                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,color: Color(0xFFF8F8FF)
                            ),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        suffixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color(0xFF7E7E7E),
                          size: 20,
                        ),
                        hintText: "8+ Character, 1 Capital",
                        hintStyle: const TextStyle(
                          color: Color(0xFF7E7E7E),
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),

                        suffixStyle: const TextStyle(
                            color: Color(0xFF0165FF),
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFFF1D1D),
                              width: .5
                          ),
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: signup,
                    child: Container(
                      width: width,
                      height: 55,

                      decoration: BoxDecoration(
                          color: const Color(0xff7785FC),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [const Text('Already have an account? ',style: TextStyle(fontSize: 12),),
                          InkWell(
                            onTap: widget.showLoginPage,
                              child: const Text('Login',style: TextStyle(color: Color(0xff2856D7),fontSize: 12),))],
                      )
                    ],
                  ),


                ],
              )
          ),
        ),
      ),
    );
  }
  Future signup() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final enteredEmail = _emailController.text.trim();

      if (!enteredEmail.endsWith('@bmu.edu.in')) {
        Utils.showSnackBar('Please enter a valid BMU email address.');
        Navigator.pop(context);
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: enteredEmail,
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}



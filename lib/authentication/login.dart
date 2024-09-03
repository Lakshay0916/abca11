import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial_palmbook/logics/utils.dart';
import 'package:trial_palmbook/main.dart';

import 'change_password.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const Login({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/DRIP_16.png"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Color(0xff7785FC),
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "E-mail address",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff42414D),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * .9,
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid E-mail address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xff8294C4)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Color(0xffF8F8FF),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                        borderRadius: BorderRadius.circular(12),
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
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: .5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff42414D),
                    ),
                  ),
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
                    obscureText: _obscureText,
                    obscuringCharacter: "*",
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xff8294C4)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F8FF),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFF8F8FF)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF7E7E7E),
                          size: 20,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      hintText: "8+ Characters, 1 Capital",
                      hintStyle: const TextStyle(
                        color: Color(0xFF7E7E7E),
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                      ),
                      suffixStyle: const TextStyle(
                        color: Color(0xFF0165FF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFF1D1D),
                          width: .5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('Forget password? ', style: TextStyle(fontSize: 12)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Forgot_password()),
                            );
                          },
                          child: Text(
                            'Change password',
                            style: TextStyle(color: Color(0xff2856D7), fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: signIN,
                  child: Container(
                    width: width,
                    child: Center(
                      child: Text(
                        'Log-in',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xff7785FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIN() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (lol) => Center(child: CircularProgressIndicator()),
    );
    try {
      final email = _emailController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

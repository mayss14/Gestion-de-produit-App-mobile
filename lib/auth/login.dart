import 'package:app1/ui.dart/list_produits.dart';
import 'package:app1/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  late Size mediaSize;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    mediaSize = MediaQuery.of(context).size;

    Future<User?> signInWithEmailAndPassword(
        String email, String password) async {
      try {
        UserCredential result = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = result.user;
        return user;
      } catch (error) {
        print(error.toString());
        return null;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 242, 242),
        image: DecorationImage(
          image: const NetworkImage(
              'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: Color.fromARGB(255, 146, 150, 129),
              fontSize: 34,
              fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 40),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 30),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 30),
        _buildLoginButton(),
        const SizedBox(height: 30),
        _buildSignUp(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildGreyText("Dont have An Account ? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUP()));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Color.fromARGB(255, 146, 150, 129),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ListProd())))
            .catchError((error) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text("Login failed \n User not found"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"))
                  ],
                );
              });
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.grey,
          minimumSize: const Size.fromHeight(60),
          backgroundColor: Color.fromARGB(255, 146, 150, 129)),
      child: const Text("Login",
          style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}

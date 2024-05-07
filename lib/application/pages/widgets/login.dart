import 'package:blocapp/application/pages/posts/itemsbloc/items_bloc.dart';
import 'package:blocapp/application/pages/posts/loginbloc/login_bloc.dart';
import 'package:blocapp/application/pages/widgets/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            BlocProvider.of<ItemsBloc>(context).add(ItemsRequestedEvent());

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Success")),
            );
            _saveCredentials(usernamecontroller.text, passwordcontroller.text);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid username and password")),
            );
          }
        },
        builder: (context, state) => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Form(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 380,
                    width: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login Form',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: usernamecontroller,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordcontroller,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginChecking(
                                    user: usernamecontroller.text,
                                    pass: passwordcontroller.text));
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveCredentials(String username, String password) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString('username', username);
    _prefs.setString('password', password);
  }
}

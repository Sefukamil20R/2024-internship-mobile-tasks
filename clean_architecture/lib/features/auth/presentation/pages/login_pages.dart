import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
import 'package:clean_architecture/features/auth/presentation/pages/signup_pages.dart';
import 'package:clean_architecture/features/auth/presentation/widgets/fields.dart';
import 'package:clean_architecture/features/product/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
         if (state is LoggedInUserState) {
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('user loggedin successfully')),
                );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  HomePage(),
                ),
              );
              } else if (state is ErrorUserState) {
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('error occured')),
                );
              }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Logo Container
                  Logo(),
                  const SizedBox(height: 60),
                  //Sign in Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Sign into your account',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  //Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color.fromRGBO(111, 111, 111, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Fields(
                    controller: usernameController,
                    hintText: 'ex: jon.smith@email.com',
                    obscureText: false,
                    text: 'email',
                  ),
                  const SizedBox(height: 20),
                  //Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color.fromRGBO(111, 111, 111, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Fields(
                    controller: passwordController,
                    hintText: '*********',
                    obscureText: true,
                    text: 'password',
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(
                              LoginUserEvent(
                                email: usernameController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(500, 50),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Color.fromRGBO(136, 136, 136, 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: const Text(
                            ' Sign Up',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

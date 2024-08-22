import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
import 'package:clean_architecture/features/auth/presentation/widgets/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_pages.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
             if (state is RegisteredUserState) {
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('user registered successfully')),
                );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
              } else if (state is ErrorUserState) {
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('error occured')),
                );
              }



        },
        
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromRGBO(63, 81, 243, 1),
                          ),
                        ),
                      ),
                      actions: [
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 35),
                          padding: const EdgeInsets.only(
                              left: 7, right: 7, bottom: 6),
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(63, 81, 243, 1),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'ECOM',
                            style: GoogleFonts.caveatBrush(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                color: Color.fromRGBO(63, 81, 243, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Create an account',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Name',
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
                      hintText: 'ex: John Doe',
                      obscureText: false,
                      text: 'name',
                    ),
                    const SizedBox(height: 15),
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
                      controller: emailController,
                      hintText: 'ex: jonsmith@gmail.com',
                      obscureText: false,
                      text: 'email',
                    ),
                    const SizedBox(height: 15),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Confirm Password',
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
                      controller: confirmPasswordController,
                      hintText: '*********',
                      obscureText: true,
                      text: 'confirm password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text(
                            'I understood ',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color.fromRGBO(111, 111, 111, 1),
                              ),
                            ),
                          ),
                          Text(
                            'Terms and Policy',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color.fromRGBO(63, 81, 243, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final users = User(
                                id: '',
                                name: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                            context
                                .read<UserBloc>()
                                .add(RegisterUserEvent(user: users));
                          }
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
                          'SIGN UP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: TextStyle(
                                color: Color.fromRGBO(136, 136, 136, 1)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              '  Log in',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

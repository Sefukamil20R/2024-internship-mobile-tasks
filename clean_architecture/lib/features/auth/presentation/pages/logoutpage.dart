import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
import 'package:clean_architecture/features/auth/presentation/pages/login_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        
         if (state is LoggedOutUserState) {
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('user loggedout successfully')),
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              context.read<UserBloc>().add(
                    LogoutUserEvent(),
                  );
            },
            child: Text('Logout',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}

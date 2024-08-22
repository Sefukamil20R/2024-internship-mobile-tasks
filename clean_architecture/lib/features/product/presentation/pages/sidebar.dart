import 'dart:io';
import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
import 'package:clean_architecture/features/auth/presentation/pages/login_pages.dart';
import 'package:clean_architecture/features/product/presentation/pages/add_product_page.dart';
import 'package:clean_architecture/features/product/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';



class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUserProfileEvent());

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(63, 81, 181, 1),
                ),
                accountName:
                    Text(state is UserProfileLoadedState ? state.user.name : ''),
                accountEmail:
                    Text(state is UserProfileLoadedState ? state.user.email : ''),
                currentAccountPicture: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    child: ClipOval(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            )
                          : Image.asset(
                              'assets/images/shoo.png',
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_rounded),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddProduct();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
          ),
          Divider(),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is LoggedOutUserState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Logout successfully'),
                ));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>LoginPage(),
         
                  ),
                );
              } else if (state is ErrorUserState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout failed')));
              }
              return;
            },
            child: ListTile(
              leading: const Icon(Icons.logout),

              title: const Text('Logout'),
              onTap: () {
                context.read<UserBloc>().add( LogoutUserEvent());
              },
            ),
          ),
        ],
      ),
    );
  }
}

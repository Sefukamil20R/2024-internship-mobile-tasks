import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:clean_architecture/features/auth/domain/usecases/getuserprofile_usecase.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
import 'package:clean_architecture/features/auth/presentation/pages/logoutpage.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_event.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_state.dart';
import 'package:clean_architecture/features/product/presentation/pages/add_product_page.dart';
import 'package:clean_architecture/features/product/presentation/pages/search_page.dart';
import 'package:clean_architecture/features/product/presentation/pages/sidebar.dart';
import 'package:clean_architecture/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProductBloc>().add(LoadAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d, yyyy').format(now);
    context.read<UserBloc>().add(FetchUserProfileEvent());

    return BlocConsumer<UserBloc, UserState>(
       
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            drawer: SideBar(),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0), // Top margin of 20 pixels
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LogoutPage()));
                                },
                                backgroundColor: Colors.grey[300],
                                child: null,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Hello ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: state is UserProfileLoadedState
                                              ? state.user.name
                                              : 'User',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          FloatingActionButton.small(
                            onPressed: () {},
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.black,
                                ),
                                Positioned(
                                  right: 3,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Available Products",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            FloatingActionButton.small(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(),
                                  ),
                                );
                              },
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.search_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is LoadingProductState) {
                      print('loading');
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    if (state is ErrorProductState) {
                      print('error');

                      return Text(state.errorMessage);
                    }
                    if (state is LoadedProductState) {
                      print('loaded');
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => _onRefresh(context), // Add the RefreshIndicator here
                          child: ListView(
                            children: [
                              for (var product in state.products)
                                ProductCard(product: product),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ),
                );
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
// import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
// import 'package:clean_architecture/features/auth/domain/usecases/getuserprofile_usecase.dart';
// import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
// import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
// import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
// import 'package:clean_architecture/features/auth/presentation/pages/logoutpage.dart';
// import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
// import 'package:clean_architecture/features/product/presentation/bloc/Product/product_state.dart';
// import 'package:clean_architecture/features/product/presentation/pages/add_product_page.dart';
// import 'package:clean_architecture/features/product/presentation/pages/search_page.dart';
// import 'package:clean_architecture/features/product/presentation/widgets/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('MMMM d, yyyy').format(now);
//     context.read<UserBloc>().add(FetchUserProfileEvent());
//     return BlocConsumer<UserBloc, UserState>(
//      listener: (context, state) {
            
//           },
//       builder: (context, state) {
//         return SafeArea(
//               child: Scaffold(
                  
//                   backgroundColor: Colors.white,
//                   body: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(
//                             top: 20.0), // Top margin of 20 pixels
//                         color: Colors.white,
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     FloatingActionButton(
//                                       onPressed: (){
//                                         Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogoutPage()));
//                                       },
//                                       backgroundColor: Colors.grey[300],
//                                       child: null,
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           formattedDate,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
                                        
//                                         Text.rich(
//                                           TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: "Hello ",
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                               TextSpan(
//                                                 text: state is UserProfileLoadedState
//                                                     ? state.user.name
//                                                     : 'User',
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 FloatingActionButton.small(
//                                   onPressed: () {},
//                                   backgroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(color: Colors.grey),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       const Icon(
//                                         Icons.notifications_outlined,
//                                         color: Colors.black,
//                                       ),
//                                       Positioned(
//                                         right: 3,
//                                         child: Container(
//                                           width: 8,
//                                           height: 8,
//                                           decoration: const BoxDecoration(
//                                             color: Colors.blue,
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 16.0, bottom: 8.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Available Products",
//                                     style: TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   FloatingActionButton.small(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>  SearchPage(),
//                                         ),
//                                       );
//                                     },
//                                     backgroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       side:
//                                           const BorderSide(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: const Icon(
//                                       Icons.search_outlined,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       BlocBuilder<ProductBloc, ProductState>(
//                         builder: (context, state) {
//                           if (state is LoadingProductState) {
//                             print('loading');
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           }
//                           if (state is ErrorProductState) {
//                             print('error');

//                             return Text(state.errorMessage);
//                           }
//                           if (state is LoadedProductState) {
//                             print('loaded');
//                             return Expanded(
//                               child: ListView(
//                                 children: [
//                                   for (var product in state.products)
//                                     ProductCard(product: product),
//                                 ],
//                               ),
//                             );
//                           }
//                           return const SizedBox();
//                         },
//                       ),
//                     ],
//                   ),
//                   floatingActionButton: FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AddProduct(),
//                         ),
//                       );
//                     },
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: const Icon(Icons.add, color: Colors.white),
//                   )));
        
//       },
//     );
//   }
// }

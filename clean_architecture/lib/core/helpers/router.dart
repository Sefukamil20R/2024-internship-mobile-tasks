import 'package:clean_architecture/features/product/presentation/pages/add_product_page.dart';
import 'package:clean_architecture/features/product/presentation/pages/homepage.dart';
import 'package:go_router/go_router.dart';
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    // GoRoute(
    //   path: '/details/:id',
    //   name: 'about',
    //   builder: (context, state) => const ProductDetailspage(),
    // ),
    GoRoute(
      path: '/add',
      name: 'contact',
      builder: (context, state) =>  AddProduct(),
    ),
    //  GoRoute(
    //   path: '/update/:id',
    //   name: 'contact',
    //   builder: (context, state) => const Updateproductpage(),
    // ),
    //  GoRoute(
    //   path: '/search/:id',
      
    //   name: 'contact',
    //   builder: (context, state) => const SearchPage(),
    // )
    
    
    ]);
   
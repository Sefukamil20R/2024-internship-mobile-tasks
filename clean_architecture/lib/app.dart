import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_event.dart';
import 'package:clean_architecture/screen/splashscreen.dart';
import 'package:clean_architecture/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            getAllproductusecase: locator(),
            getSpecproductsusecase: locator(),
            deleteProductusecase: locator(),
            updateProductusecase: locator(),
            addProductusecase: locator(),
          )..add(LoadAllProductEvent()),
        ),
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(
          getUserProfileUseCase: locator(),
          registerUserUseCase: locator(),
          loginUserUseCase: locator(),
          logoutuserUseCase: locator(),
        ),
       
      )
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        
      ),
    );
  }
}


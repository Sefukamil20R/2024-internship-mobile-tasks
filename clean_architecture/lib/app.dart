import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_event.dart';
import 'package:clean_architecture/features/product/presentation/pages/homepage.dart';
import 'package:clean_architecture/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service_locator.dart' as loc;
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
        // Add other BLoCs here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        
      ),
    );
  }
}


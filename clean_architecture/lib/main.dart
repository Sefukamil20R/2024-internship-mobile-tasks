import 'dart:async';

import 'package:clean_architecture/app.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart' ;

 
 

Future<void> main() async
{ 
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp( EcommerceApp());
}




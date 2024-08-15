import 'dart:convert';

import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main() {
 ProductModel products = ProductModel(
  id: "1",
  name: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
  description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
  imageurl: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
  price: 109
);


test(
  'the model from json test must be similar to the model',
  () async {
    final jsonString = readJson('helpers/dummy_data/other_json_data.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final result = ProductModel.fromJson(jsonData);

    final expectedProduct = ProductModel(
      id: '1',
      name: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      description: 'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
      imageurl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      price: 109,
    );

    expect(result, equals(expectedProduct));
  },
);




  
  test(
    'convert object to json format',
     () async {
      final result = products.toJson();
      final Map<String,dynamic> expectedJson = {
        'id':"1",
        'name': 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
        'description': 'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
        'imageurl': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
        'price': 109
      };
      expect(expectedJson, equals(result));
     }
     );
}



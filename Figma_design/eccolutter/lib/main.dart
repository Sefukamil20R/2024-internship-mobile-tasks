import 'package:eccolutter/add_product.dart';
import 'package:eccolutter/product_details.dart';
import 'package:eccolutter/search_page.dart';
import 'package:eccolutter/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          
          Container(
            margin: const EdgeInsets.only(top: 20.0), // Top margin of 20 pixels
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
                          onPressed: () {},
                          backgroundColor: Colors.grey[300],
                          child: null,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "July 12, 2023",
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
                                    text: "Yohannes",
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
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Products",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      FloatingActionButton.small(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
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
          Expanded(
            child: ListView(
              children: [
                ProductCard(
                  sampleproduct: Product(
                    
                    productname: "Derby Leather Shoes",
                    price: "128",
                    image: "assets/images/shoo.jpg",
                    rating: '4.0',
                    type: 'mens shoes',
                    Description: 'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.'

                  ),
                ),
                ProductCard(
                  sampleproduct: Product(
                    
                    productname: "Turkey shoes",
                    price: "128",
                    image: "assets/images/shoo.jpg",
                    rating: '4.0',
                    type: 'mens shoes',
                   Description: 'A Turkey  shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.'

                  ),
                ),
                ProductCard(
                  sampleproduct: Product(
                    
                    productname: "Quatar shoes",
                    price: "128",
                    image: "assets/images/shoo.jpg",
                    rating: '4.0',
                    type: 'mens shoe',
                    Description: 'A Quatar shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.'

                  ),
                ),
                
                
              ],
            ),
          ),
       
        ],
            
        
      ),
      floatingActionButton: FloatingActionButton(
                onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct()));
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));

                },
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              )

    );
  }
  









  
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key,required this.sampleproduct});
 final Product sampleproduct;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProductDetails(sampleproduct:sampleproduct),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:  Image(
                image: AssetImage(sampleproduct.image),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sampleproduct.productname,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        sampleproduct.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sampleproduct.type,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 19),
                          const SizedBox(width: 4),
                          Text(
                            sampleproduct.rating,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  
}
class Product
{
  final String image;
  String productname;
  String price;
  String type;
  String rating;
  String Description;
  Product(
    {required this.image,required this.productname,required this.price,required this.type,required this.rating,required this.Description}
    );
}
  // Widget _list_item(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const ProductDetails(),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             spreadRadius: 2,
  //             blurRadius: 4,
  //             offset: const Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: const Image(
  //               image: AssetImage("assets/images/shoo.jpg"),
  //               width: double.infinity,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           const SizedBox(height: 8),
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Derby Leather Shoes',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Text(
  //                       '\$120',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Men’s shoe',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.black.withOpacity(0.7),
  //                       ),
  //                     ),
  //                     Row(
  //                       children: [
  //                         const Icon(Icons.star, color: Colors.yellow, size: 19),
  //                         const SizedBox(width: 4),
  //                         Text(
  //                           '(4.0)',
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             color: Colors.black.withOpacity(0.7),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
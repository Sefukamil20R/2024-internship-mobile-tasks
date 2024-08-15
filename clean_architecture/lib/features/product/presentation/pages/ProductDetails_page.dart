import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_event.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.sampleproduct});
  final ProductEntitiy sampleproduct;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _selectedIndex = -1;

  void _toggleButton(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is Success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        else if (state is ErrorProductState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          widget.sampleproduct.imageurl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: FloatingActionButton.small(
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to the previous screen
                        },
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.chevron_left, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Space between image and other content
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'womens',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 19),
                          const SizedBox(width: 4), // Space between star and rating text
                          Text(
                            '(4.0)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.sampleproduct.name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.sampleproduct.price.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Text(
                    'Size:',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6, 
                    itemBuilder: (context, index) {
                      final number = 39 + index;

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: FloatingActionButton(
                          heroTag: null, 
                          onPressed: () => _toggleButton(index),
                          backgroundColor: _selectedIndex == index ? Colors.blue : Colors.white,
                          child: Text(
                            '$number',
                            style: TextStyle(
                              color: _selectedIndex == index ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.sampleproduct.description,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                            context.read<ProductBloc>().add(DeleteProductEvent(widget.sampleproduct.id));


                          debugPrint("outlined");
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateProduct(sampleproduct: widget.sampleproduct )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

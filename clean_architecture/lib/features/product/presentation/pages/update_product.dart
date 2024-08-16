import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_event.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_state.dart';
import 'package:clean_architecture/features/product/presentation/pages/ProductDetails_page.dart';
import 'package:clean_architecture/features/product/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.sampleproduct});
  final ProductEntitiy sampleproduct;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sampleproduct.name);
    _priceController =
        TextEditingController(text: widget.sampleproduct.price.toString());
    _descriptionController =
        TextEditingController(text: widget.sampleproduct.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is UpdatedSuccessProductState) {
            print('success update');
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(sampleproduct: widget.sampleproduct )));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product Updated successfully!')),
          );

        } else if (state is ErrorProductState) {
         print('error update');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Update Product",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              // Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  context.read<ProductBloc>().add(const LoadAllProductEvent());

            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 366,
                  height: 190,
                  margin: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 223, 219, 219),
                  ),
                  child: Center(
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(height: 10),
                              Text(
                                "Upload image",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : Image.file(
                            _image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(23.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Price',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(8),
                          suffixIcon: Icon(Icons.attach_money),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Perform update action
                            final product = ProductModel(
                              id: widget.sampleproduct.id,
                              name: _nameController.text,
                              description: _descriptionController.text,
                              price: double.parse(_priceController.text),
                              imageurl: _image != null ? _image!.path : '',
                            );
                            context.read<ProductBloc>().add(
                                UpdateProductEvent(widget.sampleproduct.id, product));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(500, 50),
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'UPDATE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          context
                              .read<ProductBloc>()
                              .add(DeleteProductEvent(widget.sampleproduct.id));
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(500, 50),
                          padding: const EdgeInsets.all(16),
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "DELETE",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class UpdateProduct extends StatefulWidget {
//   const UpdateProduct({super.key, required this.sampleproduct});
//   final ProductEntitiy sampleproduct;

//   @override
//   State<UpdateProduct> createState() => _UpdateProductState();
// }

// class _UpdateProductState extends State<UpdateProduct> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController _nameController;
//   // late TextEditingController _categoryController;
//   late TextEditingController _priceController;
//   late TextEditingController _descriptionController;
//   File? _image;

//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.sampleproduct.name);
//     // _categoryController = TextEditingController(text: widget.sampleproduct);
//     _priceController =
//         TextEditingController(text: widget.sampleproduct.price.toString());
//     _descriptionController =
//         TextEditingController(text: widget.sampleproduct.description);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     // _categoryController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => BlocProvider.of<ProductBloc>(context),
//       child: BlocListener(
//           listener: (BuildContext context, state) {
//             if (state is Success) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Product Deleted successfully!')),
//               );
//               // Navigator.pop(context); // Navigate back or to another screen
//             } else if (state is ErrorProductState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.errorMessage)),
//               );
//             }
//           },
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               title: const Text(
//                 "Update Product",
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//               ),
//               centerTitle: true,
//               automaticallyImplyLeading: false,
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: _pickImage,
//                     child: Container(
//                       width: 366,
//                       height: 190,
//                       margin: const EdgeInsets.all(18),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Color.fromARGB(255, 223, 219, 219),
//                       ),
//                       child: Center(
//                         child: _image == null
//                             ? const Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.image),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     "Upload image",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               )
//                             : Image.file(
//                                 _image!,
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(23.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           const Text(
//                             'Name',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           TextFormField(
//                               controller: _nameController,
//                               decoration: const InputDecoration(
//                                 filled: true,
//                                 fillColor: Color.fromARGB(255, 223, 219, 219),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.all(8),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter a product name';
//                                 }
//                                 return null;
//                               }),
//                           // const SizedBox(height: 16),
//                           // const Text(
//                           //   'Category',
//                           //   style: TextStyle(fontSize: 16),
//                           // ),
//                           // TextFormField(
//                           //   // controller: _categoryController,
//                           //   decoration: const InputDecoration(
//                           //     filled: true,
//                           //     fillColor: Color.fromARGB(255, 223, 219, 219),
//                           //     border: OutlineInputBorder(
//                           //       borderSide: BorderSide.none,
//                           //     ),
//                           //     contentPadding: EdgeInsets.all(8),
//                           //   ),
//                           // ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Price',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           TextFormField(
//                               controller: _priceController,
//                               decoration: const InputDecoration(
//                                 filled: true,
//                                 fillColor: Color.fromARGB(255, 223, 219, 219),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.all(8),
//                                 suffixIcon: Icon(Icons.attach_money),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter a price';
//                                 }
//                                 return null;
//                               }),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Description',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           TextFormField(
//                               controller: _descriptionController,
//                               decoration: const InputDecoration(
//                                 filled: true,
//                                 fillColor: Color.fromARGB(255, 223, 219, 219),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.all(8),
//                               ),
//                               maxLines: 4,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter a description';
//                                 }
//                                 return null;
//                               }),
//                           const SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState?.validate() ?? false) {
//                                 // Perform update action
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: const Size(500, 50),
//                               padding: const EdgeInsets.all(16),
//                               backgroundColor: Colors.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text(
//                               'UPDATE',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           OutlinedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 final product = ProductModel(
//                                   id: '', // Assuming ID is generated by backend
//                                   name: _nameController.text,
//                                   description: _descriptionController.text,
//                                   price: double.parse(_priceController.text),
//                                   imageurl: _image != null ? _image!.path : '',
//                                 );
//                                 //  BlocProvider.of<ProductBloc>(context).add(UpdateProductEvent())
//                                 context.read<ProductBloc>().add(
//                                     UpdateProductEvent(
//                                         widget.sampleproduct.id, product));
//                               }
//                             },
//                             style: OutlinedButton.styleFrom(
//                               minimumSize: const Size(500, 50),
//                               padding: const EdgeInsets.all(16),
//                               side: const BorderSide(color: Colors.red),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text(
//                               "DELETE",
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }

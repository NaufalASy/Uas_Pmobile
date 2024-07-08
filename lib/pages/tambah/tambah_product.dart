import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter/material.dart';

import 'package:image_input/image_input.dart';

class TambahProduct extends StatefulWidget {
  final void Function() fetch;
  const TambahProduct({super.key, required this.fetch});

  @override
  State<TambahProduct> createState() => _TambahProductState();
}

class _TambahProductState extends State<TambahProduct> {
  final _formKey = GlobalKey<FormState>();
  final _formNameController = TextEditingController();
  final _formPriceController = TextEditingController();
  final _formQtyController = TextEditingController();
  final _formAttrController = TextEditingController();
  final _formWeightController = TextEditingController();
  final List<XFile> _imageInputImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: AppBar(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
            title: const Text('Add Product'),
            centerTitle: true, // Menyusun judul di tengah secara horizontal
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                ImageInput(
                  images: _imageInputImages,
                  addImageIcon: const Icon(Icons.photo, color: Colors.white),
                  imageContainerDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.shade800,
                      width: 2.0,
                    ),
                  ),
                  addImageContainerDecoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  allowEdit: true,
                  allowMaxImage: 1,
                  onImageSelected: (image) {
                    setState(() {
                      _imageInputImages.add(image);
                    });
                  },
                  onImageRemoved: (image, index) {
                    setState(() {
                      _imageInputImages.remove(image);
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formNameController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: "Nama Product",
                    focusColor: Colors.blue.shade800,
                    prefixIconColor: Colors.grey.shade700,
                    floatingLabelStyle: const TextStyle(
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(100.0), // Set border radius
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Nama Product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formPriceController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Harga",
                    focusColor: Colors.blue.shade800,
                    prefixIconColor: Colors.grey.shade700,
                    floatingLabelStyle: const TextStyle(
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(100.0), // Set border radius
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Harga';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formWeightController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Weight",
                    focusColor: Colors.blue.shade800,
                    prefixIconColor: Colors.grey.shade700,
                    floatingLabelStyle: const TextStyle(
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(100.0), // Set border radius
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Weight';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formQtyController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    focusColor: Colors.blue.shade800,
                    prefixIconColor: Colors.grey.shade700,
                    floatingLabelStyle: const TextStyle(
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(100.0), // Set border radius
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formAttrController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: "Atribute",
                    focusColor: Colors.blue.shade800,
                    prefixIconColor: Colors.grey.shade700,
                    floatingLabelStyle: const TextStyle(
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(100.0), // Set border radius
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set border color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Atribute';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        var response = await ApiService().createProduct(
                            _formNameController.text,
                            int.parse(_formPriceController.text),
                            int.parse(_formQtyController.text),
                            _formAttrController.text,
                            int.parse(_formWeightController.text),
                            _imageInputImages);
                        print(
                            'Tambah Product created successfully: ${response.statusCode}');
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content:
                                  Text('Tambah Product created successfully'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.fetch();

                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                              backgroundColor: Colors.white,
                            );
                          },
                        );
                      } catch (e) {
                        print('Error Tambah Product: $e');
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Failed'),
                              content: Text('Tambah Product Gagal'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                              backgroundColor: Colors.white,
                            );
                          },
                        );
                      }
                    }
                  },
                  // full width button
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue.shade800,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Tambahkan',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

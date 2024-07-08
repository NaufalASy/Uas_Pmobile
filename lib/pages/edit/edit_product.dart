import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

class EditProduct extends StatefulWidget {
  final void Function() fetch;
  final Product product;
  const EditProduct({super.key, required this.fetch, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  final _formNameController = TextEditingController();
  final _formPriceController = TextEditingController();
  final _formAttrController = TextEditingController();
  final _formQtyController = TextEditingController();
  final _formWeightController = TextEditingController();
  final List<XFile> _imageInputImages = [];

  @override
  void initState() {
    super.initState();
    // Atur nilai awal controller jika diperlukan
    _formNameController.text = widget.product.name;
    _formPriceController.text = (widget.product.price).toString();
    _formAttrController.text = widget.product.attr;
    _formQtyController.text = (widget.product.qty).toString();
    _formWeightController.text = (widget.product.weight).toString();
  }

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
            title: const Text('Edit Product'),
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
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: "Price",
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
                      return 'Please enter Price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formWeightController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
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
                      return "Please enter Weight";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formQtyController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
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
                    labelText: "Attribute",
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
                      return 'Please enter Attribute';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        print(_imageInputImages);
                        var response = await ApiService().editProduct(
                            _formNameController.text,
                            int.parse(_formPriceController.text),
                            int.parse(_formQtyController.text),
                            _formAttrController.text,
                            num.parse(_formWeightController.text),
                            _imageInputImages,
                            widget.product.id);
                        print(
                            'Edit Product successfully: ${response.statusCode}');
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Edit Product successfully'),
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
                      } catch (e) {
                        print('Error Edit Product: $e');
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Failed'),
                              content: Text('Edit Product Gagal'),
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
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Simpan',
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

import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter/material.dart';

class TambahSales extends StatefulWidget {
  final void Function() fetch;
  const TambahSales({super.key, required this.fetch});

  @override
  State<TambahSales> createState() => _TambahSalesState();
}

class _TambahSalesState extends State<TambahSales> {
  final _formKey = GlobalKey<FormState>();
  final _formBuyerController = TextEditingController();
  final _formPhoneController = TextEditingController();
  final _formStatusController = TextEditingController();
  final _formDateController = TextEditingController();

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
            title: const Text('Add Seles'),
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
                TextFormField(
                  controller: _formBuyerController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: "Nama Buyer",
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
                      return 'Please enter Nama Buyer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formDateController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Date",
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
                      return 'Please enter Date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formPhoneController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone",
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
                      return 'Please enter Phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _formStatusController,
                  style: TextStyle(color: Colors.grey.shade700),
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: "Status",
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
                      return 'Please enter Status';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        var response = await ApiService().createSales(
                          _formBuyerController.text,
                          _formPhoneController.text,
                          _formStatusController.text,
                          _formDateController.text,
                        );
                        print(
                            'Tambah Sales created successfully: ${response.statusCode}');
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content:
                                  Text('Tambah Sales created successfully'),
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
                        print('Error Tambah Sales: $e');
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Failed'),
                              content: Text('Tambah Sales Gagal'),
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

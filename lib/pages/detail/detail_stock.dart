import 'package:flutter_application_1/models/stock.dart';
import 'package:flutter_application_1/pages/edit/edit_stock.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailStock extends StatefulWidget {
  final String id;
  final Function fetch;

  const DetailStock({super.key, required this.id, required this.fetch});

  @override
  _DetailStockState createState() => _DetailStockState();
}

class _DetailStockState extends State<DetailStock> {
  final ApiService apiService = ApiService();
  Stock? stock;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStock();
  }

  Future<void> _fetchStock() async {
    try {
      Stock fetchedStock = await apiService.getStock(widget.id);
      print('fetchedStock: $fetchedStock');
      setState(() {
        stock = fetchedStock;
        isLoading = false;
      });
      print(stock);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    print('ID Stock: ${widget.id}');
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.blue.shade800,
              ) // Tampilkan indicator loading jika data masih diambil
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                stock!.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${stock!.issuer} - ${stock!.weight} kg x ${stock!.qty} ${stock!.attr}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.white),
                                    foregroundColor: WidgetStateProperty.all(
                                        Colors.blue.shade800),
                                    shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Kembali'),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditStock(
                                          fetch: _fetchStock,
                                          stock: stock!,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.white),
                                    foregroundColor: WidgetStateProperty.all(
                                        Colors.blue.shade800),
                                    shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Edit'),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Hapus stock'),
                                          content: Text(
                                              'Apakah Anda yakin ingin menghapus stock ${stock!.name}?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                try {
                                                  await ApiService()
                                                      .delStock(stock!.id);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Success'),
                                                        content: Text(
                                                            'Stock ${stock!.name} has been deleted successfully'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              widget.fetch();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                        backgroundColor:
                                                            Colors.white,
                                                      );
                                                    },
                                                  ).then((value) {
                                                    _fetchStock;
                                                  });
                                                } catch (e) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Error'),
                                                        content:
                                                            Text(e.toString()),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                        backgroundColor:
                                                            Colors.white,
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: const Text('Hapus'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.white),
                                    foregroundColor: WidgetStateProperty.all(
                                        Colors.blue.shade800),
                                    shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Hapus'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Container(
                              width: double.infinity, // Set the width to full
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      'https://api.kartel.dev/stocks/${stock!.id}/image',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey.shade700,
                                          ),
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) {
                                          return child;
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Container(
                              width: double.infinity, // Set the width to full
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text('Created At',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(DateFormat('yyyy-MM-dd HH:mm')
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                stock!.createdAt))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Container(
                              width: double.infinity, // Set the width to full
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text('Updated At',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(DateFormat('yyyy-MM-dd HH:mm')
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                stock!.updatedAt))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

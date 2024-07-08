import 'package:flutter_application_1/models/stock.dart';
import 'package:flutter_application_1/pages/detail/detail_stock.dart';
import 'package:flutter_application_1/pages/tambah/tambah_stock.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  _StockPageState();

  final ApiService apiService = ApiService();
  late List<Stock> stock = [];
  late List<Stock> originalStocks = [];

  @override
  void initState() {
    super.initState();
    _fetchStocks(); // Panggil fungsi untuk mengambil data pegawai saat pertama kali halaman dimuat
  }

  Future<void> _fetchStocks() async {
    try {
      List<Stock> fetchedStock = await apiService.getStocks();
      setState(() {
        stock = fetchedStock;
        originalStocks = fetchedStock; // Simpan data asli
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _searchStock(String query) {
    setState(() {
      if (query.isNotEmpty) {
        stock = originalStocks.where((stock) {
          return stock.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        stock = originalStocks.toList();
      }
    });
  }

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              alignment: Alignment.bottomCenter,
              height: 240,
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
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Stock',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Menampilkan list Stock', // Ganti dengan data yang sesuai
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Cari data',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      _searchStock(
                          value); // Panggil fungsi _searchStock dengan nilai teks terbaru
                    },
                  ),
                ],
              )),
          // List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await _fetchStocks();
              },
              color: Colors.blue.shade800,
              child: FutureBuilder<List<Stock>>(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue.shade800,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data found'));
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: stock.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print("Tapped on ${stock[index].id}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailStock(
                                    id: stock[index].id, fetch: _fetchStocks),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Icon
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade800,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          'https://api.kartel.dev/stocks/${stock[index].id}/image',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) {
                                              return child;
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              stock[index].name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                          Text(
                                            '${stock[index].weight} Kg x ${stock[index].qty} ${stock[index].attr}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            stock[index].issuer,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                future: apiService.getStocks(),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TambahStock(
                      fetch: _fetchStocks,
                    )),
          );
        },
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

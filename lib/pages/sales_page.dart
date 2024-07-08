import 'package:flutter_application_1/models/sales.dart';
import 'package:flutter_application_1/pages/detail/detail_sales.dart';
import 'package:flutter_application_1/pages/tambah/tambah_sales.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  _SalesPageState();

  final ApiService apiService = ApiService();
  late List<Sales> sales = [];
  late List<Sales> originalSales = [];

  @override
  void initState() {
    super.initState();
    _fetchSales(); // Panggil fungsi untuk mengambil data pegawai saat pertama kali halaman dimuat
  }

  Future<void> _fetchSales() async {
    try {
      List<Sales> fetchedSales = await apiService.getSaless();
      setState(() {
        sales = fetchedSales;
        originalSales = fetchedSales; // Simpan data asli
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _searchSales(String query) {
    setState(() {
      if (query.isNotEmpty) {
        sales = originalSales.where((data) {
          return data.buyer.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        sales = originalSales.toList();
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
                        'Sales',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Menampilkan list Sales', // Ganti dengan data yang sesuai
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
                      _searchSales(
                          value); // Panggil fungsi _searchSales dengan nilai teks terbaru
                    },
                  ),
                ],
              )),
          // List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await _fetchSales();
              },
              color: Colors.blue.shade800,
              child: FutureBuilder<List<Sales>>(
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
                      itemCount: sales.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print("Tapped on ${sales[index].id}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSales(
                                    id: sales[index].id, fetch: _fetchSales),
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
                                      child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Icon(
                                              Icons.people_outlined,
                                              color: Colors.white,
                                            ),
                                          )),
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
                                              sales[index].buyer,
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
                                            '${sales[index].phone}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            sales[index].issuer,
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
                                const SizedBox(height: 10),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade800,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.confirmation_number,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${sales[index].status}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                future: apiService.getSaless(),
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
                builder: (context) => TambahSales(
                      fetch: _fetchSales,
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/models/sales.dart';
import 'package:flutter_application_1/models/stock.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_input/image_input.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://api.kartel.dev';

  Future<List<Product>> getProducts() async {
    print('Making request to $baseUrl/products');
    final response = await http.get(Uri.parse('$baseUrl/products'));
    print('response : $response');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => Product.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<Stock>> getStocks() async {
    print('Making request to $baseUrl/stocks');
    final response = await http.get(Uri.parse('$baseUrl/stocks'));
    print('response : $response');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => Stock.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<Sales>> getSaless() async {
    print('Making request to $baseUrl/sales');
    final response = await http.get(Uri.parse('$baseUrl/sales'));
    print('response : $response');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => Sales.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Product> getProduct(String id) async {
    print('Making request to $baseUrl/products/$id');
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Stock> getStock(String id) async {
    print('Making request to $baseUrl/stocks/$id');
    final response = await http.get(Uri.parse('$baseUrl/stocks/$id'));
    if (response.statusCode == 200) {
      return Stock.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Sales> getSales(String id) async {
    print('Making request to $baseUrl/sales/$id');
    final response = await http.get(Uri.parse('$baseUrl/sales/$id'));
    if (response.statusCode == 200) {
      return Sales.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<http.Response> createProduct(String name, int price, int qty,
      String attr, num weight, List<XFile> image) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      body: json.encode({
        'name': name,
        'price': price,
        'qty': qty,
        'attr': attr,
        'weight': weight,
        'issuer': 'naufal',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    print(response.statusCode == 201);

    if (response.statusCode == 201) {
      print("upload image");
      print(json.decode(response.body)['id']);
      if (image.isNotEmpty) {
        print(image[0]);

        final File imageFile = File(image[0].path);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '$baseUrl/products/${json.decode(response.body)['id']}/image'),
        );
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
            contentType: MediaType('image', 'png'), // Sesuaikan jika bukan jpeg
          ),
        );
        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
        });

        var response2 = await request.send();
        print(response2.statusCode);
        if (response2.statusCode != 201) {
          throw Exception('Failed to create product');
        }
        return response;
      }
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
    return response;
  }

  Future<http.Response> createStock(
      String name, int qty, String attr, num weight, List<XFile> image) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stocks'),
      body: json.encode({
        'name': name,
        'qty': qty,
        'attr': attr,
        'weight': weight,
        'issuer': 'naufal',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    print(response.statusCode == 201);

    if (response.statusCode == 201) {
      print("upload image");
      print(json.decode(response.body)['id']);
      if (image.isNotEmpty) {
        print(image[0]);

        final File imageFile = File(image[0].path);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '$baseUrl/stocks/${json.decode(response.body)['id']}/image'),
        );
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
            contentType: MediaType('image', 'png'), // Sesuaikan jika bukan jpeg
          ),
        );
        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
        });

        var response2 = await request.send();
        print(response2.statusCode);
        if (response2.statusCode != 201) {
          throw Exception('Failed to create product');
        }
        return response;
      }
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
    return response;
  }

  Future<http.Response> createSales(
    String buyer,
    String phone,
    String status,
    String date,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sales'),
      body: json.encode({
        'buyer': buyer,
        'phone': phone,
        'date': date,
        'status': status,
        'issuer': 'naufal',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
    return response;
  }

  Future<http.Response> editProduct(String name, int price, int qty,
      String attr, num weight, List<XFile> image, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      body: json.encode({
        'name': name,
        'price': price,
        'qty': qty,
        'attr': attr,
        'weight': weight,
        'issuer': 'naufal',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (image.isNotEmpty) {
      final File imageFile = File(image[0].path);

      print('$baseUrl/products/$id/image');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/products/$id/image'),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'png'), // Sesuaikan jika bukan jpeg
        ),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      var response2 = await request.send();
      print(response2.statusCode);
      if (response2.statusCode != 201) {
        print('Failed to upload image');
        throw Exception('Failed to upload image');
      }
      return response;
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to edit product');
    }
    return response;
  }

  Future<http.Response> editStock(String name, int qty, String attr, num weight,
      List<XFile> image, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/stocks/$id'),
      body: json.encode({
        'name': name,
        'qty': qty,
        'attr': attr,
        'weight': weight,
        'issuer': 'naufal',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (image.isNotEmpty) {
      final File imageFile = File(image[0].path);

      print('$baseUrl/stocks/$id/image');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/stocks/$id/image'),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'png'), // Sesuaikan jika bukan jpeg
        ),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      var response2 = await request.send();
      print(response2.statusCode);
      if (response2.statusCode != 201) {
        print('Failed to upload image');
        throw Exception('Failed to upload image');
      }
      return response;
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to edit stocks');
    }
    return response;
  }

  Future<http.Response> editSales(
      String buyer, String phone, String status, String date, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sales/$id'),
      body: json.encode({
        'buyer': buyer,
        'phone': phone,
        'status': status,
        'date': date,
        'issuer': 'naufal',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (response.statusCode != 200) {
      throw Exception('Failed to edit sales');
    }
    return response;
  }

  Future<http.Response> delProduct(String id) async {
    print('Making request to $baseUrl/products/$id');
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 204) {
      return response;
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<http.Response> delStock(String id) async {
    print('Making request to $baseUrl/stocks/$id');
    final response = await http.delete(Uri.parse('$baseUrl/stocks/$id'));
    if (response.statusCode == 204) {
      return response;
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<http.Response> delSales(String id) async {
    print('Making request to $baseUrl/sales/$id');
    final response = await http.delete(Uri.parse('$baseUrl/sales/$id'));
    if (response.statusCode == 204) {
      return response;
    } else {
      throw Exception('Failed to delete user');
    }
  }
}

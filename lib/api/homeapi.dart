import 'dart:convert';
import 'package:egg_project/model/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class HomeProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get islOading => _isLoading;

  bool _loadingSpinner = false;
  bool get loadingSpinner => _loadingSpinner;

  bool _isSelect = false;
  bool get isSelect => _isSelect;

  bool _isError = false;
  bool get isError => _isError;

  List<Homemodel> _farm = [];
  List<Homemodel> get farms => [..._farm];

  String? currentUserId;
  void setCurrentUserId(String userId) {
    currentUserId = userId;
    notifyListeners();
  }

  Future<void> profileData({required BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();

      var response = await https.get(
        Uri.parse("https://test.ajayhatcheries.in/api/farm-entry"),
      );

      print("https://test.ajayhatcheries.in/api/farm-entry");
      print(response.body);

      if (response.statusCode == 200) {
        _farm = [];
        var extractedData = json.decode(response.body);
        if (extractedData is Map<String, dynamic> &&
            extractedData.containsKey('data')) {
          final farmDetailsList = extractedData['data'] as List<dynamic>;
          for (var farmDetails in farmDetailsList) {
            _farm.add(
              Homemodel(
                farmName: farmDetails['farm_name']?.toString(),
                intervalDays: farmDetails['interval_days'] is int
                    ? farmDetails['interval_days']
                    : int.tryParse(farmDetails['interval_days'].toString()) ??
                        0,
                chiks: farmDetails['chiks'] is int
                    ? farmDetails['chiks']
                    : int.tryParse(farmDetails['chiks'].toString()) ?? 0,
                mortality: farmDetails['mortality'] is int
                    ? farmDetails['mortality']
                    : int.tryParse(farmDetails['mortality'].toString()) ?? 0,
                farmSaleDate: farmDetails['farm_sale_date']?.toString(),
                totalWeight: farmDetails['total_weight'] is int
                    ? farmDetails['total_weight']
                    : int.tryParse(farmDetails['total_weight'].toString()) ?? 0,
                totalAvg: farmDetails['total_avg'] is int
                    ? farmDetails['total_avg']
                    : int.tryParse(farmDetails['total_avg'].toString()) ?? 0,
                hatchDate: farmDetails['hatch_date']?.toString(),
                feedData: farmDetails['feed_data'] is Map
                    ? Map<String, int>.from(
                        (farmDetails['feed_data'] as Map).map(
                          (key, value) => MapEntry(
                            key.toString(),
                            value is int
                                ? value
                                : int.tryParse(value.toString()) ?? 0,
                          ),
                        ),
                      )
                    : null,
              ),
            );
          }
        }

        print('product details: ${_farm.toString()}');
        _isLoading = false;
        _isError = false;
        notifyListeners();
      } else {
        _isLoading = false;
        _isError = true;
        notifyListeners();
      }
    } catch (e) {
      print('error in product prod: $e');
      _isLoading = false;
      _isError = true;
      _isSelect = false;
      notifyListeners();
    }
  }
}

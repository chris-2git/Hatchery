class Homemodel {
  String? farmName;
  int? intervalDays;
  int? chiks;
  int? mortality;
  String? farmSaleDate;
  int? totalWeight;
  int? totalAvg;
  String? hatchDate;
  Map<String, int>? feedData;

  Homemodel({
    this.farmName,
    this.intervalDays,
    this.chiks,
    this.mortality,
    this.farmSaleDate,
    this.totalWeight,
    this.totalAvg,
    this.hatchDate,
    this.feedData,
  });

  factory Homemodel.fromJson(Map<String, dynamic> json) {
    return Homemodel(
      farmName: json['farm_name']?.toString(),
      intervalDays: json['interval_days'] is int
          ? json['interval_days']
          : int.tryParse(json['interval_days'].toString()) ?? 0,
      chiks: json['chiks'] is int
          ? json['chiks']
          : int.tryParse(json['chiks'].toString()) ?? 0,
      mortality: json['mortality'] is int
          ? json['mortality']
          : int.tryParse(json['mortality'].toString()) ?? 0,
      farmSaleDate: json['farm_sale_date']?.toString(),
      totalWeight: json['total_weight'] is int
          ? json['total_weight']
          : int.tryParse(json['total_weight'].toString()) ?? 0,
      totalAvg: json['total_avg'] is int
          ? json['total_avg']
          : int.tryParse(json['total_avg'].toString()) ?? 0,
      hatchDate: json['hatch_date']?.toString(),
      feedData: json['feed_data'] is Map
          ? Map<String, int>.from(
              (json['feed_data'] as Map).map(
                (key, value) => MapEntry(
                  key.toString(),
                  value is int ? value : int.tryParse(value.toString()) ?? 0,
                ),
              ),
            )
          : null,
    );
  }
}

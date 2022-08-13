class Data {
  final List detections;
  final List results;

  const Data({
    required this.detections,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      detections: json['detections'],
      results: json['results'],
    );
  }
}
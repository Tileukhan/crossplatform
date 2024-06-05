import 'dart:convert';

List<Package2> packageFromJson(String str) => List<Package2>.from(json.decode(str).map((x) => Package2.fromJson(x)));

String packageToJson(List<Package2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Package2 {
  Package2({
    required this.email,
    required this.number,
    required this.address
  });

  final String email;
  final int number;
  final String address;

  factory Package2.fromJson(Map<String, dynamic> json) => Package2(
    email: json["email"],
    number: json["number"],
    address: json["address"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "number": number,
    "address":address
  };
}

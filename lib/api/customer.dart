import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  Billing billing;
  Shipping shipping;

  Customer({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.billing,
    required this.shipping,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class Billing {
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String company;
  @JsonKey(name: 'address_1')
  String address1;
  @JsonKey(name: 'address_2')
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => _$BillingFromJson(json);
  Map<String, dynamic> toJson() => _$BillingToJson(this);
}

@JsonSerializable()
class Shipping {
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String company;
  @JsonKey(name: 'address_1')
  String address1;
  @JsonKey(name: 'address_2')
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  Shipping({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingToJson(this);
}

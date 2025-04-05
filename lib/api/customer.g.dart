// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      billing: Billing.fromJson(json['billing'] as Map<String, dynamic>),
      shipping: Shipping.fromJson(json['shipping'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'billing': instance.billing,
      'shipping': instance.shipping,
    };

Billing _$BillingFromJson(Map<String, dynamic> json) => Billing(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      company: json['company'] as String,
      address1: json['address_1'] as String,
      address2: json['address_2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      country: json['country'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$BillingToJson(Billing instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'company': instance.company,
      'address_1': instance.address1,
      'address_2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
      'email': instance.email,
      'phone': instance.phone,
    };

Shipping _$ShippingFromJson(Map<String, dynamic> json) => Shipping(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      company: json['company'] as String,
      address1: json['address_1'] as String,
      address2: json['address_2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$ShippingToJson(Shipping instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'company': instance.company,
      'address_1': instance.address1,
      'address_2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
    };

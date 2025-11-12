class AddressModel {
  String? status;
  String? message;
  Data? data;
  Errors? errors;

  AddressModel({this.status, this.message, this.data, this.errors});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Data {
  List<Addresses>? addresses;

  Data({this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) { addresses!.add(new Addresses.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? id;
  String? name;
  String? street;
  String? street2;
  String? city;
  CountryId? countryId;
  String? phone;
  String? type;

  Addresses({this.id, this.name, this.street, this.street2, this.city, this.countryId, this.phone, this.type});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    street2 = json['street2'];
    city = json['city'];
    countryId = json['country_id'] != null ? new CountryId.fromJson(json['country_id']) : null;
    phone = json['phone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['street'] = this.street;
    data['street2'] = this.street2;
    data['city'] = this.city;
    if (this.countryId != null) {
      data['country_id'] = this.countryId!.toJson();
    }
    data['phone'] = this.phone;
    data['type'] = this.type;
    return data;
  }
}

class CountryId {
  int? id;
  String? name;
  String? code;

  CountryId({this.id, this.name, this.code});

  CountryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class Errors {


Errors.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
return data;
}
}

class AffiliateRegisterModel {
  String? jsonrpc;
  Null? id;
  Result? result;

  AffiliateRegisterModel({this.jsonrpc, this.id, this.result});

  AffiliateRegisterModel.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? status;
  String? message;
  int? influencerId;
  String? phone;

  Result({this.status, this.message, this.influencerId, this.phone});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    influencerId = json['influencer_id'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['influencer_id'] = this.influencerId;
    data['phone'] = this.phone;
    return data;
  }
}

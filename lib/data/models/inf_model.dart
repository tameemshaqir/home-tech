class InfModel {
  String? status;
  String? message;
  Data? data;

  InfModel({this.status, this.message, this.data});

  InfModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CouponsSummary>? couponsSummary;
  double? totalFixedRewards;
  double? totalPercentRewards;
  double? totalPointsRewards;
  int? totalCoupons;

  Data(
      {this.couponsSummary,
        this.totalFixedRewards,
        this.totalPercentRewards,
        this.totalPointsRewards,
        this.totalCoupons});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['coupons_summary'] != null) {
      couponsSummary = <CouponsSummary>[];
      json['coupons_summary'].forEach((v) {
        couponsSummary!.add(new CouponsSummary.fromJson(v));
      });
    }
    totalFixedRewards = json['total_fixed_rewards'];
    totalPercentRewards = json['total_percent_rewards'];
    totalPointsRewards = json['total_points_rewards'];
    totalCoupons = json['total_coupons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.couponsSummary != null) {
      data['coupons_summary'] =
          this.couponsSummary!.map((v) => v.toJson()).toList();
    }
    data['total_fixed_rewards'] = this.totalFixedRewards;
    data['total_percent_rewards'] = this.totalPercentRewards;
    data['total_points_rewards'] = this.totalPointsRewards;
    data['total_coupons'] = this.totalCoupons;
    return data;
  }
}

class CouponsSummary {
  String? code;
  int? totalUsed;
  int? totalAvailable;
  String? validUntil;
  String? rewards;

  CouponsSummary(
      {this.code,
        this.totalUsed,
        this.totalAvailable,
        this.validUntil,
        this.rewards});

  CouponsSummary.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totalUsed = json['total_used'];
    totalAvailable = json['total_available'];
    validUntil = json['valid_until'];
    rewards = json['rewards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['total_used'] = this.totalUsed;
    data['total_available'] = this.totalAvailable;
    data['valid_until'] = this.validUntil;
    data['rewards'] = this.rewards;
    return data;
  }
}

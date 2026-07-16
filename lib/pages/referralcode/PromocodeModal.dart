class Coupon {
  final String id;
  final String code;
  final String serviceLocationId;
  final double minimumTripAmount;
  final double maximumDiscountAmount;
  final double discountPercent;
  final int totalUses;
  final int usesPerUser;
  final String from;
  final String to;
  final int active;
  final bool isApplied;

  Coupon({
    required this.id,
    required this.code,
    required this.serviceLocationId,
    required this.minimumTripAmount,
    required this.maximumDiscountAmount,
    required this.discountPercent,
    required this.totalUses,
    required this.usesPerUser,
    required this.from,
    required this.to,
    required this.active,
    required this.isApplied,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      serviceLocationId: json['service_location_id'],
      minimumTripAmount: json['minimum_trip_amount'].toDouble(),
      maximumDiscountAmount: json['maximum_discount_amount'].toDouble(),
      discountPercent: json['discount_percent'].toDouble(),
      totalUses: json['total_uses'],
      usesPerUser: json['uses_per_user'],
      from: json['from'],
      to: json['to'],
      active: json['active'],
      isApplied: json['is_applied'],
    );
  }
}

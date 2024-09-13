class Subscription {
  final String name;
  final double planPrice;
  final double youPay;
  final double usage;
  final String? orgId;
  final String? typeEvent;
  final String? username;
  final String? description;
  final String? logo;
  final int? usageCount;

  Subscription({
    required this.name,
    required this.planPrice,
    required this.youPay,
    required this.usage,
    this.orgId,
    this.typeEvent,
    this.username,
    this.description,
    this.usageCount,
    this.logo,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      orgId: json['orgId'],
      typeEvent: json['typeEvent'],
      username: json['username'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      planPrice: json['planPrice'].toDouble(),
      youPay: json['youPay'].toDouble(),
      usage: json['usage'].toDouble(),
      usageCount: json['usageCount'],
    );
  }
}

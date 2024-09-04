class Subscription {
  final String title;
  final double originalPrice;
  final double discountPrice;
  final double usagePercentage; // 0.0 - 1.0

  Subscription({
    required this.title,
    required this.originalPrice,
    required this.discountPrice,
    required this.usagePercentage,
  });
}

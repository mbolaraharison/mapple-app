// Interface:-------------------------------------------------------------------
abstract class PriceCalculatorUtilsInterface {
  double calculateTotalPrice({
    required double unitPrice,
    required num quantity,
  });

  double calculateDiscountedPrice({
    required double totalPrice,
    required num discount,
  });

  double calculateDiscountAmount({
    required double price,
    required double discountedPrice,
  });

  double calculateTaxAmount({
    required double price,
    required num tax,
  });

  double calculatePriceInclTax({
    required double price,
    required num tax,
  });
}

// Implementation:--------------------------------------------------------------
class PriceCalculatorUtils implements PriceCalculatorUtilsInterface {
  @override
  double calculateTotalPrice({
    required double unitPrice,
    required num quantity,
  }) {
    var result = unitPrice * quantity;
    result = double.parse(result.toStringAsFixed(3));
    final roundedResult = (result * 100).roundToDouble() / 100;
    return roundedResult;
  }

  @override
  double calculateDiscountedPrice({
    required double totalPrice,
    required num discount,
  }) {
    var result = totalPrice - (totalPrice * discount / 100);
    result = double.parse(result.toStringAsFixed(3));
    final roundedResult = (result * 100).roundToDouble() / 100;
    return roundedResult;
  }

  @override
  double calculateDiscountAmount({
    required double price,
    required double discountedPrice,
  }) {
    return price - discountedPrice;
  }

  @override
  double calculateTaxAmount({
    required double price,
    required num tax,
  }) {
    var result = price * (tax / 100);
    result = double.parse(result.toStringAsFixed(3));
    final roundedResult = (result * 100).roundToDouble() / 100;
    return roundedResult;
  }

  @override
  double calculatePriceInclTax({
    required double price,
    required num tax,
  }) {
    var result = price * (1 + (tax / 100));
    result = double.parse(result.toStringAsFixed(3));
    final roundedResult = (result * 100).roundToDouble() / 100;
    return roundedResult;
  }
}

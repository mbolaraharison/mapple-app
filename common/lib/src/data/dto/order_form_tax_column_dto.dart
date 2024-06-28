class OrderFormTaxColumnDto {
  final String tax;
  final String amountExclTax;
  final String amountTax;
  final String amountInclTax;

  OrderFormTaxColumnDto({
    required this.tax,
    required this.amountExclTax,
    required this.amountTax,
    required this.amountInclTax,
  });
}

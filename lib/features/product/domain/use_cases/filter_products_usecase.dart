
import 'package:logiology/features/product/data/models/product_model.dart';

class FilterProductsUseCase {
  List<ProductModel> call(
    List<ProductModel> products, {
    String? category,
    String? tag,
    String? priceRange,
  }) {
    return products.where((p) {
      final matchesCategory = category == null || p.category == category;
      final matchesTag = tag == null || p.tags.contains(tag);
      final matchesPrice = _matchesPrice(p.price.toDouble(), priceRange);
      return matchesCategory && matchesTag && matchesPrice;
    }).toList();
  }

  bool _matchesPrice(double price, String? range) {
    switch (range) {
      case '0-5 \$':
        return price >= 0 && price <= 5;
      case '5-20 \$':
        return price > 5 && price <= 20;
      case '20-100 \$':
        return price > 20 && price <= 100;
      case '100-300 \$':
        return price > 100 && price <= 300;
      case '300\$+':
        return price > 300;
      default:
        return true;
    }
  }
}

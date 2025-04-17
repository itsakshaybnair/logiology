
import 'package:logiology/features/product/data/models/product_model.dart';

class SearchProductsUseCase {
  List<ProductModel> call(List<ProductModel> products, String query) {
    final lowerQuery = query.toLowerCase();

    return products.where((p) {
      return p.title.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}

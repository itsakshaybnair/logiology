import 'package:get/get.dart';
import 'package:logiology/features/product/data/models/product_model.dart';
import 'package:logiology/features/product/domain/use_cases/filter_products_usecase.dart';
import 'package:logiology/features/product/domain/use_cases/get_products_usecase.dart';
import 'package:logiology/features/product/domain/use_cases/search_products_usecase.dart';


class ProductController extends GetxController {
  final GetProductsUseCase _getProductsUseCase;
  final FilterProductsUseCase _filterProductsUseCase;
  final SearchProductsUseCase _searchProductsUseCase;

  ProductController(
    this._getProductsUseCase,
    this._filterProductsUseCase,
    this._searchProductsUseCase,
  );

  final products = <ProductModel>[].obs;
  final filteredProducts = <ProductModel>[].obs;
  RxBool enableFilteredProducts = false.obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final RxString errorMessage = ''.obs;

  final int limit = 50;
  int skip = 0;
  bool allLoaded = false;

  // Filters
  String? selectedCategory;
  String? selectedTag;
  String? selectedPrice;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    if (allLoaded) return;

    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getProductsUseCase(limit, skip);

    result.fold(
      (failure) {
        final isNetworkError = failure.message.toLowerCase().contains('errno = 7');
        errorMessage.value = isNetworkError
            ? "Network error.\nPlease check your connection."
            : "Something went wrong.\nPlease try again.";
      },
      (data) {
        if (data.length < limit) allLoaded = true;
        skip += limit;
        products.addAll(data);
        applyFilters(false);
      },
    );

    isLoading.value = false;
  }

  void setFilters({String? category, String? price, String? tag}) {
    selectedCategory = category;
    selectedTag = tag;
    selectedPrice = price;

    applyFilters(true);
  }

  void applyFilters(bool enable) {
    enableFilteredProducts.value = enable;

    final result = _filterProductsUseCase.call(
      products,
      category: selectedCategory,
      tag: selectedTag,
      priceRange: selectedPrice,
    );

    filteredProducts.assignAll(result);
  }

  void clearFilters() {
    enableFilteredProducts.value = false;
    selectedCategory = null;
    selectedTag = null;
    selectedPrice = null;
  }

  void searchProductsByTitle(String query) {
    clearFilters();
    searchQuery.value = query;

    final result = _searchProductsUseCase.call(products, query);
    filteredProducts.assignAll(result);
  }

  RxList<ProductModel> get productListToDisplayWhileSearching => filteredProducts;
}


























// class ProductController extends GetxController {
//   final GetProductsUseCase _useCase;
//   ProductController(this._useCase);

//   final products = <ProductModel>[].obs;
//   final filteredProducts = <ProductModel>[].obs;
//   RxBool enableFilteredProducts = false.obs;
//   final isLoading = false.obs;
  
//   final searchQuery = ''.obs;
//   final RxString errorMessage = ''.obs;

//   final int limit = 50;
//   int skip = 0;
//   bool allLoaded = false;

//   // Filters
//   String? selectedCategory;
//   String? selectedTag;
//   String? selectedPrice;

//   @override
//   void onInit() {
//     fetchProducts();
//     super.onInit();
//   }

//   void fetchProducts() async {
//     if (allLoaded) return;

//     isLoading.value = true;
//       errorMessage.value = '';
//     final result = await _useCase(limit, skip);

//     result.fold(
//       (failure) {
//         debugPrint("failue: ${failure.message}");

//          final isNetworkError = failure.message. toLowerCase().contains('errno = 7');

//       errorMessage.value = isNetworkError
//           ? "Network error.\nPlease check your connection."
//           : "Something went wrong.\nPlease try again.";
//       },
//       (data) {
//         if (data.length < limit) allLoaded = true;
//         skip += limit;
//         products.addAll(data);
//         applyFilters(false); 
//       },
//     );
//     isLoading.value = false;
//   }




//   void setFilters({String? category, String? price, String? tag}) {
//     selectedCategory = category;
//     selectedTag = tag;
//     selectedPrice = price;

//     applyFilters(true);
//   }

//   void applyFilters(final bool enableFilteredProduct) {
//     final filtered = products.where((p) {
//       final matchesCategory =
//           selectedCategory == null || p.category == selectedCategory;
//       final matchesTag = selectedTag == null || p.tags.contains(selectedTag);
//       final matchesPrice = () {
//         if (selectedPrice == null) return true;
//         final price = p.price.toDouble();
//         switch (selectedPrice) {
//           case '0-5 \$':
//             return price >= 0 && price <= 5;
//           case '5-20 \$':
//             return price > 5 && price <= 20;
//           case '20-100 \$':
//             return price > 20 && price <= 100;
//           case '100-300 \$':
//             return price > 100 && price <= 300;
//           case '300\$+':
//             return price > 300;
//           default:
//             return true;
//         }
//       }();

//       enableFilteredProducts.value = enableFilteredProduct;

//       return matchesCategory && matchesTag && matchesPrice;
//     }).toList();

//     filteredProducts.assignAll(filtered);
//   }




//   void clearFilters() {
//     enableFilteredProducts.value = false;
//     selectedCategory = null;
//     selectedTag = null;
//     selectedPrice = null;
//   }





//   void searchProductsByTitle(String query) {
//     clearFilters();
//     searchQuery.value = query;
//     _applySearchFilter();
//   }






//   void _applySearchFilter() {
//     final query = searchQuery.value.toLowerCase();

//     final baseList = products;

//     final result = baseList.where((p) {
//       return p.title.toLowerCase().contains(query);
//     }).toList();
//     filteredProducts.assignAll(result);
//   }




//   RxList<ProductModel> get productListToDisplayWhileSearching {
//     return filteredProducts;
//   }
// }



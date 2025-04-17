import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/core/common/assets/app_fonts.dart';
import 'package:logiology/core/common/assets/app_svgs.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/common/widgets/app_brand_header.dart';
import 'package:logiology/core/common/widgets/svg_icon.dart';
import 'package:logiology/core/theme/app_colors.dart';
import 'package:logiology/features/home/presentation/controllers/product_controllers.dart';
import 'package:logiology/features/home/presentation/widgets/show_filter_bottom_sheet.dart';
import 'package:logiology/features/home/presentation/widgets/side_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ProductController controller = Get.find();

  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void _onFilterPressed() {
    showFilterBottomSheet(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       searchFocusNode.unfocus();
      },
      child: Scaffold(
        endDrawer: const SideDrawer(),
        appBar: AppBar(
          actions: [
            Builder(builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  right: context.setResponsiveSize(1, 1),
                ),
                child: IconButton(
                  icon: Center(
                      child: SvgIcon(
                    icon: AppSvgIcons.userProfile,
                    height: context.setResponsiveSize(7.5, 6),
                  )),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              );
            })
          ],
          forceMaterialTransparency: true,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setResponsiveSize(1, 1),
            ),
            child: Row(
              children: [
                AppBrandHeader(
                  imageRadius: context.setResponsiveSize(4, 4),
                  fontSize: context.setResponsiveSize(7, 6),
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                _searchController.text.isEmpty) {
              controller.fetchProducts();
            }
            return false;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setResponsiveSize(4.5, 4),
            ).copyWith(top: context.setResponsiveSize(2, 2)),
            child: Column(
              children: [
                TextField(
                  focusNode: searchFocusNode,
                  onChanged: (value) => controller.searchProductsByTitle(value),
                  controller: _searchController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          context.setResponsiveSize(8, 6)),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: context.setResponsiveSize(.2, .3),
                      ),
                    ),
                    hintText: 'Search products...',
                    prefixIcon: Icon(
                      Icons.search,
                      size: context.setResponsiveSize(5, 4),
                      color: AppColors.greyColor,
                    ),
                    suffixIcon: IconButton(
                      icon: SvgIcon(
                        icon: AppSvgIcons.filter,
                        height: context.setResponsiveSize(3.8, 3),
                      ),
                      onPressed: _onFilterPressed,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          context.setResponsiveSize(8, 6)),
                    ),
                    hintStyle: const TextStyle(
                        color: AppColors.hintTextColor,
                        fontFamily: AppFonts.njalBold),
                  ),
                ),
                Obx(
                  () {
                    return controller.enableFilteredProducts.isTrue
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Showing filtered products",
                                style: TextStyle(
                                  fontSize: context.setResponsiveSize(4, 3),
                                  color: AppColors.greyColor,
                                  fontFamily: AppFonts.njalBold,
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.clear,
                                    color: AppColors.blueColor),
                                onPressed: () {
                                  controller.clearFilters();
                                },
                                iconAlignment: IconAlignment.end,
                                label: Text("clear now",
                                    style: TextStyle(
                                      fontSize: context.setResponsiveSize(3, 2),
                                      color: AppColors.blueColor,
                                    )),
                              )
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: Obx(() {
                    log("bool is: ${controller.enableFilteredProducts}");

                    final dynamic productToShow;

                    if (controller.enableFilteredProducts.value) {
                      productToShow = controller.filteredProducts;
                    } else {
                      if (controller.searchQuery.isEmpty) {
                        productToShow = controller.products;
                      } else {
                        log("search.................");
                        productToShow =
                            controller.productListToDisplayWhileSearching;
                      }
                    }

                    // controller.enableFilteredProducts.value
                    //     ? controller.filteredProducts
                    //     : controller.products;

                    if (productToShow.isEmpty && controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return productToShow.isEmpty && !controller.isLoading.value
                        ? Center(
                            child: Text(
                              'Oh! No products found 🙂',
                              style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontSize: context.setResponsiveSize(4, 3)),
                            ),
                          )
                        : RawScrollbar(
                            thickness: 3,
                            padding: EdgeInsets.only(
                              top: context.setResponsiveSize(3, 2),
                            ),
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(
                                  context.setResponsiveSize(2, 2)),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: productToShow.length,
                              itemBuilder: (context, index) {
                                final product = productToShow[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        context.setResponsiveSize(7, 6)),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(context
                                                  .setResponsiveSize(7, 6))),
                                          child: Image.network(
                                            product.thumbnail,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            context.setResponsiveSize(3, 4)),
                                        child: Column(
                                          spacing:
                                              context.setResponsiveSize(1, 1),
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(product.title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: context
                                                        .setResponsiveSize(
                                                            3.5, 3.5),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Text(
                                              '\$${product.price}',
                                              style: TextStyle(
                                                  fontSize:
                                                      context.setResponsiveSize(
                                                          3.8, 3.5),
                                                  color: AppColors.blueColor),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    size: context
                                                        .setResponsiveSize(
                                                            3.5, 3.5),
                                                    color:
                                                        AppColors.amberColor),
                                                SizedBox(
                                                    width: context
                                                        .setResponsiveSize(
                                                            1, 1)),
                                                Text(product.rating.toString(),
                                                    style: TextStyle(
                                                      fontSize: context
                                                          .setResponsiveSize(
                                                              3.5, 3.5),
                                                      color:
                                                          AppColors.greyColor,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

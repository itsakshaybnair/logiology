import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logiology/core/common/widgets/basic_app_button.dart';
import 'package:logiology/core/theme/app_colors.dart';
import 'package:logiology/features/home/presentation/controllers/product_controllers.dart';

void showFilterBottomSheet(BuildContext context) {
  final controller = Get.find<ProductController>();

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.transparentColor,
    shape: RoundedRectangleBorder(),
    isScrollControlled: true,
    builder: (context) {
      return FilterSheetContent(
        selectedCategory: controller.selectedCategory,
        selectedPrice: controller.selectedPrice,
        selectedTag: controller.selectedTag,
      );
    },
  );
}

class FilterSheetContent extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedPrice;
  final String? selectedTag;
  const FilterSheetContent(
      {super.key, this.selectedCategory, this.selectedPrice, this.selectedTag});

  @override
  State<FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<FilterSheetContent> {
  final List<String> categories = [
    'beauty',
    'fragrances',
    'furniture',
    'groceries',
    'decoration'
  ];
  final List<String> prices = [
    '0-5 \$',
    '5-20 \$',
    '20-100 \$',
    '100-300 \$',
    '300\$+'
  ];
  final List<String> tags = [
    'perfumes',
    'meat',
    'vegetables',
    'fruits',
    'home decor'
  ];

  late String? selectedCategory;
  late String? selectedPrice;
  late String? selectedTag;

  final ProductController controller = Get.find();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    selectedPrice = widget.selectedPrice;
    selectedTag = widget.selectedTag;
  }

  Widget buildChip(String label, String? selected, Function(String?) onSelect) {
    final isSelected = selected == label;
    return Center(
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelect(isSelected ? null : label),
        selectedColor: Colors.blue.shade100,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(60),
          right: Radius.circular(60),
        ),
        color: AppColors.backgroundColor,
        border: Border.all(color: AppColors.greyColor, width: 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Filter by...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyColor,
                  ),
                ),
                
                // )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Category',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: categories
                            .map((e) => buildChip(e, selectedCategory, (val) {
                                  setState(() => selectedCategory = val);
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Price',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: prices
                            .map((e) => buildChip(e, selectedPrice, (val) {
                                  setState(() => selectedPrice = val);
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Tag',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: tags
                            .map((e) => buildChip(e, selectedTag, (val) {
                                  setState(() => selectedTag = val);
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () {
                if (selectedCategory == null &&
                    selectedPrice == null &&
                    selectedTag == null) {
                  context.pop();
                  controller.clearFilters();
                  // return showCustomDialog(context);
                } else {
                  // final controller = Get.find<ProductController>();
                  controller.setFilters(
                    category: selectedCategory,
                    price: selectedPrice,
                    tag: selectedTag,
                  );

                  log('Selected Category: $selectedCategory');
                  log('Selected Price: $selectedPrice');
                  log('Selected Tag: $selectedTag');
                   context.pop();
                }
               
                },
              title: 'Update',
            ),
          ],
        ),
      ),
    );
  }

  // void showCustomDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         backgroundColor: const Color(0xff0D0C0C),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(50),
  //           side: const BorderSide(color: Colors.white),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Text(
  //                 'Oops! You forgot to select',
  //                 style: TextStyle(color: AppColors.redColor, fontSize: 14),
  //               ),
  //               const SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.white,
  //                   foregroundColor: Colors.black,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(30),
  //                   ),
  //                 ),
  //                 child: const Text('Okay'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}

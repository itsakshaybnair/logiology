import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/common/widgets/basic_app_button.dart';
import 'package:logiology/core/theme/app_colors.dart';
import 'package:logiology/features/product/presentation/controllers/product_controllers.dart';

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
    'home-decoration'
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
        borderRadius:  BorderRadius.horizontal(
          left: Radius.circular(context.setResponsiveSize(14, 12),),
          right: Radius.circular(context.setResponsiveSize(14, 12),),
        ),
        color: AppColors.backgroundColor,
        border: Border.all(color: AppColors.greyColor, width: 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            context.setResponsiveSize(4, 3), 
            context.setResponsiveSize(4, 3),
            context.setResponsiveSize(4, 3), 
            MediaQuery.of(context).viewInsets.bottom + context.setResponsiveSize(4, 3),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Filter by...',
                  style: TextStyle(
                    fontSize: context.setResponsiveSize(5, 4),
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyColor,
                  ),
                ),
                
                // )
              ],
            ),
             SizedBox(height: context.setResponsiveSize(4, 3),),
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
                        spacing: context.setResponsiveSize(4, 3),
                        runSpacing: context.setResponsiveSize(2, 1),
                        children: categories
                            .map((e) => buildChip(e, selectedCategory, (val) {
                                  setState(() => selectedCategory = val);
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                 SizedBox(width: context.setResponsiveSize(4, 3)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Price',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                         spacing: context.setResponsiveSize(4, 3),
                        runSpacing: context.setResponsiveSize(2, 1),
                        children: prices
                            .map((e) => buildChip(e, selectedPrice, (val) {
                                  setState(() => selectedPrice = val);
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                 SizedBox(width:  context.setResponsiveSize(4, 3),
                        ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Tag',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: context.setResponsiveSize(4, 3),
                        runSpacing: context.setResponsiveSize(2, 1),
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
             SizedBox(height: context.setResponsiveSize(4, 3),
                        ),
            BasicAppButton(
              onPressed: () {
                if (selectedCategory == null &&
                    selectedPrice == null &&
                    selectedTag == null) {
                  context.pop();
                  controller.clearFilters();
                } else {
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

}

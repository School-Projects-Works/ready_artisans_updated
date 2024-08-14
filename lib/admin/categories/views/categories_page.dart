import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_artisans/admin/core/custom_dialog.dart';
import 'package:ready_artisans/admin/provider/admin_provider.dart';
import 'package:ready_artisans/components/custom_button.dart';
import 'package:ready_artisans/components/text_inputs.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles_admin.dart';

import '../../../components/smart_dialog.dart';
import '../provider/category_provider.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var titleStyles = style.title(color: Colors.white, fontSize: 15);
    var rowStyles = style.body(fontSize: 13);
    var categories = ref.watch(categoriesFilterProvider).filter;
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories'.toUpperCase(),
              style: style.title(fontSize: 30, color: primaryColor)),
          const SizedBox(height: 20),
          newCategory(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: style.width * 0.5,
                child: CustomTextFields(
                  hintText: 'Search Categories',
                  onChanged: (query) {
                    ref
                        .read(categoriesFilterProvider.notifier)
                        .filterCategories(query);
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DataTable2(
              columnSpacing: 30,
              horizontalMargin: 12,
              empty: Center(
                  child: Text(
                'No Categories found',
                style: rowStyles,
              )),
              minWidth: 600,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => primaryColor.withOpacity(0.6)),
              headingTextStyle: titleStyles,
              columns: [
                DataColumn2(
                    label: Text(
                      'INDEX',
                      style: titleStyles,
                    ),
                    fixedWidth: style.largerThanMobile ? 80 : null),
                DataColumn2(
                  label: Text('Image'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Name'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Description'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Per Hour'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                ),
              ],
              rows: List<DataRow>.generate(categories.length, (index) {
                var category = categories[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: rowStyles)),
                    DataCell(
                      category.image == null
                          ? const Icon(Icons.image)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: ImageNetwork(
                                  image: category.image!,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                    ),
                    DataCell(Text(category.name, style: rowStyles)),
                    DataCell(Text(category.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: rowStyles)),
                    DataCell(Text(category.perHourRate!.toStringAsFixed(2),
                        style: rowStyles)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          CustomAdminDialog.showInfo(
                              message:
                                  'Are you sure you want to delete this category?',
                              buttonText: 'Delete',
                              onPressed: () {
                                print('Pressed======');
                                ref
                                    .read(categoriesFilterProvider.notifier)
                                    .deleteCategory(category.id);
                              });
                        },
                      ),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget newCategory() {
    var notifier = ref.read(newCategoryProvider.notifier);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 3)
          ]),
      child: Form(
        key: _formKey,
        child: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 22,
          children: [
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  CustomTextFields(
                    label: 'Category Name',
                    onSaved: (value) {
                      notifier.setCategoryName(value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextFields(
                    label: 'Price per hour (GHS)',
                    onSaved: (value) {
                      notifier.setPricePerHour(double.parse(value!));
                    },
                    isDigitOnly: true,
                    max: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price per hour is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  CustomTextFields(
                    label: 'Category Description',
                    maxLines: 2,
                    onSaved: (value) {
                      notifier.setCategoryDescription(value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category description is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            ref.watch(categoryImageProvider)?.path ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles(context).body()),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                          onPressed: () {
                            _pickImage();
                          },
                          child: Text(
                              ref.watch(categoryImageProvider) == null
                                  ? 'Select Image'
                                  : 'Change Image',
                              style: Styles(context)
                                  .body(color: primaryColor, fontSize: 13)))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: CustomButton(
                  text: 'Save Category',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (ref.watch(categoryImageProvider) == null) {
                        CustomDialog.showToast(
                            message: 'Please select an image');
                        return;
                      }
                      notifier.saveCategory(_formKey, ref);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ref.read(categoryImageProvider.notifier).state = image;
    }
  }
}

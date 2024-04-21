import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakas_task/core/app_widgets/custom_main_buttom.dart';
import 'package:kakas_task/core/app_widgets/custom_textfield.dart';
import 'package:kakas_task/core/functions/custom_appbar.dart';
import 'package:kakas_task/core/functions/custom_snackbar.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/core/utils/app_images.dart';
import 'package:kakas_task/core/utils/size_config.dart';
import 'package:kakas_task/core/utils/styles.dart';
import 'package:kakas_task/features/product/data/models/product_model.dart';
import 'package:kakas_task/features/product/presentation/view_models/product_providers/product_provider.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/pic_image_card.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/pic_image_snackbar.dart';
import 'package:provider/provider.dart';

class EditProductView extends StatefulWidget {
  final ProductModel productModel;

  const EditProductView({super.key, required this.productModel});
  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  late final TextEditingController titleController;
  late final TextEditingController priceController;
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    titleFocusNode.removeListener(() {});
    priceFocusNode.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    titleController =
        TextEditingController(text: widget.productModel.title ?? '');
    priceController =
        TextEditingController(text: widget.productModel.price.toString());
    uploadedImagepath = widget.productModel.image ?? '';
    _selectedImagePath = widget.productModel.image ?? '';
    super.initState();
  }

  String? _selectedImagePath;
  String uploadedImagepath = '';
  XFile? file;
  Future _pickImage({required ImageSource imageSource}) async {
    file = await ImagePicker().pickImage(source: imageSource, imageQuality: 10);
    if (file != null) {
      return file?.path;
    } else {
      return '';
    }
  }

  Future _selectImage() {
    return showDialog(
      context: context,
      builder: (context) {
        var h = SizeConfig.height(context);
        return AlertDialog(
          content: SizedBox(
            height: h * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text('select Image From', style: Styles.textStyle18),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PickImageCard(
                          image: AppImages.gallery,
                          text: 'gallery',
                          function: () async {
                            _selectedImagePath = await _pickImage(
                                imageSource: ImageSource.gallery);
                            uploadedImagepath =
                                await Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .uploadImage(File(file?.path ?? ''));
                            if (_selectedImagePath != '') {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              // ignore: use_build_context_synchronously
                              imagePickerSnackBar(context);
                            }
                          },
                        ),
                        PickImageCard(
                          image: AppImages.camera,
                          text: 'camera',
                          function: () async {
                            _selectedImagePath = await _pickImage(
                                imageSource: ImageSource.camera);
                            uploadedImagepath =
                                await Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .uploadImage(File(file?.path ?? ''));
                            if (_selectedImagePath != '') {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              // ignore: use_build_context_synchronously
                              imagePickerSnackBar(context);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width(context);
    var height = SizeConfig.height(context);

    return Scaffold(
      appBar: customAppBar(
          title: 'Edit Product',
          context: context,
          color: AppColors.kScaffoldBGColor),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: height * 0.070),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                        width: 90,
                        height: 90,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: _selectedImagePath == null
                                    ? AppColors.kPrimaryColor
                                    : Colors.transparent)),
                        child: _selectedImagePath == null
                            ? Container(
                                width: 90,
                                height: 90,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade100),
                                child: const Icon(Icons.image,
                                    color: Colors.grey, size: 35),
                              )
                            : Container(
                                width: 90,
                                height: 90,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade100),
                                child: _selectedImagePath!.startsWith('http')
                                    ? Image.network(
                                        _selectedImagePath!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(_selectedImagePath ?? ''),
                                        fit: BoxFit.cover,
                                      ),
                              )),
                    InkWell(
                      onTap: () {
                        _selectImage();
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kPrimaryColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.090,
              ),
              SizedBox(
                child: CustomTextFormField(
                  controller: titleController,
                  prefix: Icons.title,
                  hintText: 'Title',
                  type: TextInputType.text,
                  focusNode: titleFocusNode,
                  textInputAction: TextInputAction.next,
                  icon: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'title is required';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                child: CustomTextFormField(
                  controller: priceController,
                  hintText: 'Price',
                  prefix: Icons.money,
                  type: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  focusNode: priceFocusNode,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                    return null;
                  },
                ),
              ),
              Consumer<ProductProvider>(
                builder:
                    (BuildContext context, productProvider, Widget? child) =>
                        Padding(
                  padding: EdgeInsets.only(top: height * 0.1),
                  child: MainButton(
                    isLoading: productProvider.isLoading,
                    text: 'Save',
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        if (_selectedImagePath == null) {
                          customSnackBar(context, 'image is required ',
                              color: Colors.red);
                          return;
                        } else {
                          await productProvider.editProduct(
                              id: widget.productModel.id ?? -1,
                              title: titleController.text,
                              image: uploadedImagepath,
                              price: int.tryParse(priceController.text) ?? -1);
                          if (productProvider.isSuccess) {
                            customSnackBar(context, 'Edit Product Successfully',
                                color: Colors.green);
                            GoRouter.of(context)
                                .pushReplacement(RoutesPath.kProductsView);
                          } else {
                            customSnackBar(context, 'Edit Product Faild',
                                color: Colors.red);
                            GoRouter.of(context).pop();
                          }
                        }
                      }
                    },
                    width: width,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

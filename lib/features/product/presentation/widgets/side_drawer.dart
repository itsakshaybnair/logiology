import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logiology/core/common/assets/app_svgs.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/common/widgets/show_snakbar.dart';
import 'package:logiology/core/di/sevice_locator.dart';
import 'package:logiology/core/theme/app_colors.dart';
import 'package:logiology/core/user_info/user_info.dart';
import 'package:logiology/core/utils/pick_image.dart';
import 'package:logiology/features/auth/domain/usecases/set_user_logged_in_usecase.dart';
import 'package:logiology/features/product/presentation/widgets/edit_user_info_dialog.dart';

final ValueNotifier<bool> _refreshUserInfoNotifier = ValueNotifier(false);

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });



  final res = await SetUserLoggedInUsecase(getIt())
                .call(UserInfoParams(dP: pickedImage.path));

            res.fold((l) {
              showSnackbar('Oops..Something went wrong', context);
            }, (r) {
              showSnackbar('Updated Successfully 🔥', context);
            });
           
          





      _refreshUserInfoNotifier.value = !_refreshUserInfoNotifier.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Drawer(
        backgroundColor: AppColors.backgroundColor,
        child: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: _refreshUserInfoNotifier,
            builder: (context, value, child) => Column(
              children: [
                SizedBox(height: context.setResponsiveSize(15, 13)),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: UserInfo.dP == ''
                              ? CircleAvatar(
                                  radius: context.setResponsiveSize(13, 11),
                                  backgroundColor: AppColors.whiteColor,
                                  child: SvgPicture.asset(
                                    AppSvgIcons.userProfile, // 👈 Your SVG path
                                    width: context.setResponsiveSize(14, 13),
                                    height: context.setResponsiveSize(14, 13),
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: context.setResponsiveSize(30, 24),
                                    width: context.setResponsiveSize(30, 24),
                                    child: Image.file(
                                      File(UserInfo.dP),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => selectImage(),
                            child: Container(
                              padding: EdgeInsets.all(
                                  context.setResponsiveSize(1.5, 1.5)),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.blueColor,
                              ),
                              child: Icon(
                                Icons.change_circle,
                                size: context.setResponsiveSize(5, 4),
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: context.setResponsiveSize(9, 8),
                          top: context.setResponsiveSize(6, 6)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              UserInfo.name,
                              style: TextStyle(
                                fontSize: context.setResponsiveSize(5, 4),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _editUserInfoDialog(
                                    context, true, UserInfo.name);
                              },
                              child: Icon(
                                Icons.edit,
                                size: context.setResponsiveSize(6, 6),
                                color: AppColors.greyColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.setResponsiveSize(10, 9)),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: context.setResponsiveSize(6, 6)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius:
                        BorderRadius.circular(context.setResponsiveSize(6, 6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline,
                            size: context.setResponsiveSize(6, 6),
                            color: AppColors.greyColor),
                        SizedBox(width: context.setResponsiveSize(3, 2)),
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                UserInfo.paswword,
                                style: TextStyle(
                                  fontSize: context.setResponsiveSize(4, 3),
                                  color: Colors.black87,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _editUserInfoDialog(
                                      context, false, UserInfo.paswword);
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: context.setResponsiveSize(6, 6),
                                  color: AppColors.greyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editUserInfoDialog(BuildContext context, final bool isNameChanged,
      final String initialValue) {
    showDialog(
      context: context,
      builder: (context) => EditUserInfoDialog(
        isNameChanged: isNameChanged,
        initialValue: initialValue,
        onSubmit: (text) async {
          if (isNameChanged) {
            final res = await SetUserLoggedInUsecase(getIt())
                .call(UserInfoParams(name: text));

            res.fold((l) {
              showSnackbar('Oops..Something went wrong', context);
            }, (r) {
              showSnackbar('Updated Successfully 🔥', context);
            });

          
          } else {

              final res = await SetUserLoggedInUsecase(getIt())
                .call(UserInfoParams(password: text));

            res.fold((l) {
              showSnackbar('Oops..Something went wrong', context);
            }, (r) {
              showSnackbar('Updated Successfully 🔥', context);
            });
           
          }

          _refreshUserInfoNotifier.value = !_refreshUserInfoNotifier.value;
          if (context.mounted) {
            Navigator.of(context).pop();
          }


        },
      ),
    );
  }
}

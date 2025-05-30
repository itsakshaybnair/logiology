import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logiology/core/common/assets/app_fonts.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/common/widgets/app_brand_header.dart';
import 'package:logiology/core/common/widgets/basic_app_button.dart';
import 'package:logiology/core/common/widgets/custom_text_field.dart';
import 'package:logiology/core/common/widgets/show_snakbar.dart';
import 'package:logiology/core/constants/app_route_paths.dart';
import 'package:logiology/core/di/sevice_locator.dart';
import 'package:logiology/features/auth/domain/usecases/set_user_logged_in_usecase.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.setResponsiveSize(8, 6),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppBrandHeader(
                      imageRadius: context.setResponsiveSize(8, 6),
                      fontSize: context.setResponsiveSize(10, 8),
                    ),
                    SizedBox(height: context.setResponsiveSize(20, 17)),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _registerText(context),
                          SizedBox(height: context.setResponsiveSize(10, 8)),
                          CustomTextField(
                            hintText: 'Username',
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is missing';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.setResponsiveSize(6, 5)),
                          CustomTextField(
                            hintText: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is missing';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.setResponsiveSize(6, 5)),
                          BasicAppButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final username = _emailController.text.trim();
                                final password =
                                    _passwordController.text.trim();

                                if (username != 'admin' &&
                                    password != 'Pass@123.') {
                                  showSnackbar(
                                      'Oops..Invalid username and password',context);
                                } else if (username != 'admin') {
                                  showSnackbar('Oops..Invalid username',context);
                                } else if (password != 'Pass@123.') {
                                  showSnackbar('Oops..Invalid password',context);
                                } else {
                                  // await UserPreferences.setLoginStatus(
                                  //     isLoggedIn: true);
                                  // UserInfo.loginStatus = true;

                                  final res =
                                      await SetUserLoggedInUsecase(getIt())
                                          .call(UserInfoParams(
                                    isLoggedIn: true,
                                  ));

                                  res.fold((l) {
                                    showSnackbar(
                                        'Oops..Something went wrong',context);
                                  }, (r) {
                                     context.go(AppRoutePaths.homePage);

                                    showSnackbar(
                                        'Woohoo..Login Successful 🔥',context);
                                  });

                               
                                }
                              }
                            },
                            title: 'Log In',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.setResponsiveSize(25, 8)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerText(BuildContext context) {
    return Text(
      'Log In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: context.setResponsiveSize(8, 8),
        fontFamily: AppFonts.outfitMedium,
      ),
      textAlign: TextAlign.center,
    );
  }

  // void showSnackbar(final String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: SizedBox(
  //         height: context.setResponsiveSize(10, 8),
  //         child: Center(child: Text(message)),
  //       ),
  //     ),
  //   );
  // }
}

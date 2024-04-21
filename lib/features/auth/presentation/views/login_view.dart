import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/app_widgets/custom_main_buttom.dart';
import 'package:kakas_task/core/app_widgets/custom_textfield.dart';
import 'package:kakas_task/core/functions/custom_snackbar.dart';
import 'package:kakas_task/core/network/local/cache_helper.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/core/utils/app_images.dart';
import 'package:kakas_task/core/utils/size_config.dart';
import 'package:kakas_task/core/utils/styles.dart';
import 'package:kakas_task/features/auth/presentation/view_models/auth_providers/login_provider.dart';
import 'package:kakas_task/features/auth/presentation/views/widgets/custom_lines.dart';
import 'package:kakas_task/features/auth/presentation/views/widgets/social_button.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSecure = true;

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    userNameFocusNode.removeListener(() {});
    passwordFocusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width(context);
    var height = SizeConfig.height(context);

    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.1),
                    Hero(
                      tag: 'logo',
                      child: Center(
                          child: Image.asset(
                        AppImages.logo,
                        width: 60,
                        height: 60,
                      )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Recepo',
                      style: Styles.textStyle26,
                    ),
                    SizedBox(
                      height: height * 0.065,
                    ),
                    Text(
                      'Login to your Account',
                      style: Styles.textStyle23,
                    ),
                    SizedBox(
                      height: height * 0.028,
                    ),
                    SizedBox(
                      child: CustomTextFormField(
                        controller: userNameController,
                        prefix: Icons.person,
                        hintText: 'Username',
                        type: TextInputType.name,
                        focusNode: userNameFocusNode,
                        textInputAction: TextInputAction.next,
                        icon: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          if (value.length < 5 || value.length > 10) {
                            return 'Username must be between 5 and 10 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Consumer<LoginProvider>(
                      builder: (BuildContext context, loginProvider,
                              Widget? child) =>
                          SizedBox(
                        child: CustomTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          prefix: Icons.lock,
                          type: TextInputType.visiblePassword,
                          obscureText: loginProvider.isObscure,
                          textInputAction: TextInputAction.done,
                          focusNode: passwordFocusNode,
                          suffixIcon: loginProvider.isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixFun: () =>
                              loginProvider.changevisibilityPassword(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 5 || value.length > 10) {
                              return 'Password must be between 5 and 10 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Consumer<LoginProvider>(
                      builder: (BuildContext context, loginProvider,
                              Widget? child) =>
                          Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 0.022, top: height * 0.045),
                        child: MainButton(
                          isLoading: loginProvider.isLoading,
                          text: 'Login',
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              await loginProvider.loginUser(
                                  userName: userNameController.text,
                                  password: passwordController.text);
                              if (loginProvider.loginModel?.token != null) {
                                customSnackBar(context, 'Login Successfully',
                                    color: Colors.green);
                                await CacheHelper.saveDate(
                                        key: 'token',
                                        value: loginProvider.loginModel?.token)
                                    .then((value) => GoRouter.of(context)
                                        .pushReplacement(
                                            RoutesPath.kProductsView));
                                print(
                                    'MyToooooKK ${CacheHelper.getData(key: 'token')}');
                              } else {
                                customSnackBar(
                                    context, 'Login Failed. Please try again.',
                                    color: Colors.red);
                              }
                            }
                          },
                          width: width,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.012,
                      ),
                      child: const CustomLines(
                        title: 'in',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.055),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Spacer(
                            flex: 4,
                          ),
                          SocialButton(
                              fun: () {},
                              text: 'Facebook',
                              imageIcon: AppImages.facebook),
                          const Spacer(),
                          SocialButton(
                              fun: () {},
                              text: 'Google',
                              imageIcon: AppImages.google),
                          const Spacer(),
                          SocialButton(
                              fun: () {},
                              text: 'Ios',
                              imageIcon: AppImages.ios),
                          const Spacer(
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        children: [
                          TextSpan(
                              text: "Don't have an account ? ",
                              style: Styles.textStyle18.copyWith(fontSize: 14)),
                          TextSpan(
                            text: "Register",
                            style: Styles.textStyle18.copyWith(
                                color: AppColors.kPrimaryColor, fontSize: 14),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GoRouter.of(context).go(RoutesPath.kSignUpView);
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.040,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

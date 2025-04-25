import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_cubit.dart';
import 'package:ultimate_solution_flutter_task/app/login/presentation/cubit/login_state.dart';
import 'package:ultimate_solution_flutter_task/core/constants/images_constants/images_constants.dart';
import 'package:ultimate_solution_flutter_task/core/constants/strings_constants/strings_constants.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/buttons/custom_main_button.dart';
import 'package:ultimate_solution_flutter_task/core/reusable_widgets/text_form_field/custom_text_form_field.dart';
import 'package:ultimate_solution_flutter_task/core/theme/font_manager/font_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Login successful! Welcome, ${state.login!.deliveryName}'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to home/dashboard page after successful login
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (state.isError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Red circle in top right corner
            Positioned(
                right: 0.w, child: SvgPicture.asset(ImagesConstants.redCircle)),

            // Language globe icon
            Positioned(
              right: 16.w,
              top: 50.h,
              child:
                  SizedBox(child: SvgPicture.asset(ImagesConstants.language)),
            ),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),

                        // Logo
                        SvgPicture.asset(
                          ImagesConstants.homeLogo,
                          height: 74.h,
                        ),

                        SizedBox(height: 132.h),

                        // Welcome Back text
                        Center(
                          child: Text(
                            StringsConstants.welcomeBack.tr(),
                            style: TextStyles.font29primaryDarkSemiBold,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Log back into your account text
                        Center(
                          child: Text(
                            StringsConstants.logBack.tr(),
                            style: TextStyles.font12primaryDarkMedium,
                          ),
                        ),

                        SizedBox(height: 44.h),

                        // User ID field
                        SizedBox(
                          width: double.infinity,
                          child: CustomTextField(
                            borderRadius: 22.r,
                            controller: userIdController,
                            hintText: StringsConstants.userId.tr(),
                            textAlign: TextAlign.center,
                            fillColor: const Color(0xffF1F5FB),
                            borderColor: Colors.transparent,
                            textStyle: TextStyles.font14BlackRegular,
                            hintStyle: TextStyles.font14BlackRegular,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your User ID';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Password field
                        SizedBox(
                          width: double.infinity,
                          child: CustomTextField(
                            borderRadius: 22.r,
                            controller: passwordController,
                            hintText: StringsConstants.password.tr(),
                            textAlign: TextAlign.center,
                            obscureText: !isPasswordVisible,
                            fillColor: const Color(0xffF1F5FB),
                            borderColor: Colors.transparent,
                            textStyle: TextStyles.font14BlackRegular,
                            hintStyle: TextStyles.font14BlackRegular,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 27.h),

                        // Show More Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50.w, 25.h),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              StringsConstants.showMore.tr(),
                              style: TextStyles.font14primaryDarkSemiBold,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Login Button
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            bool isLoading = state.isLoading;
                            return SizedBox(
                              width: double.infinity,
                              height: 44.h,
                              child: CustomMainButton(
                                text: isLoading
                                    ? 'Loading...'
                                    : StringsConstants.logIn.tr(),
                                textStyle: TextStyles.font16whiteMedium,
                                onPressed: isLoading ? () {} : _handleLogin,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 37.h),

                        // Delivery Truck Illustration
                        Center(
                          child: SvgPicture.asset(
                            ImagesConstants.delivery,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
            deliveryNo: userIdController.text,
            password: passwordController.text,
          );
    }
  }
}

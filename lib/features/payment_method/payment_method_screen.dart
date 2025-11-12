// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Password Recovery',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         fontFamily: 'SF Pro Display',
//         brightness: Brightness.dark,
//       ),
//       home: LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1A1A1A),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Status bar info
//               Row(
//                 children: [
//                   Text(
//                     '12:25 AM',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 16),
//                       SizedBox(width: 4),
//                       Icon(Icons.wifi, color: Colors.white, size: 16),
//                       SizedBox(width: 4),
//                       Icon(Icons.battery_std, color: Colors.white, size: 16),
//                       SizedBox(width: 2),
//                       Text('68', style: TextStyle(color: Colors.white, fontSize: 12)),
//                     ],
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 40),
//
//               // Skip button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Skip',
//                     style: TextStyle(
//                       color: Color(0xFFE53E3E),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 60),
//
//               // Welcome text
//               Text(
//                 'Welcome',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF9CA3AF),
//                 ),
//               ),
//
//               SizedBox(height: 12),
//
//               // Subtitle
//               Text(
//                 'Log in with your data that you intered during your registration.',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Color(0xFF6B7280),
//                   height: 1.4,
//                 ),
//               ),
//
//               SizedBox(height: 60),
//
//               // Phone number field
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFF2D2D2D),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Color(0xFF374151), width: 1),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.phone_outlined,
//                         color: Color(0xFF6B7280),
//                         size: 20,
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: TextField(
//                           keyboardType: TextInputType.phone,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF9CA3AF),
//                             fontWeight: FontWeight.w400,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: 'Phone number',
//                             hintStyle: TextStyle(
//                               color: Color(0xFF6B7280),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(vertical: 16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               // Password field
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFF2D2D2D),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Color(0xFF374151), width: 1),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.lock_outline,
//                         color: Color(0xFF6B7280),
//                         size: 20,
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: TextField(
//                           obscureText: true,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF9CA3AF),
//                             fontWeight: FontWeight.w400,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: 'Password',
//                             hintStyle: TextStyle(
//                               color: Color(0xFF6B7280),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(vertical: 16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               Spacer(),
//
//               // Login button
//               Container(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFE53E3E),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 24),
//
//               // Sign up link
//               Center(
//                 child: RichText(
//                   text: TextSpan(
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Color(0xFF9CA3AF),
//                     ),
//                     children: [
//                       TextSpan(text: "Don't have an account? "),
//                       WidgetSpan(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                 pageBuilder: (context, animation, secondaryAnimation) =>
//                                     PasswordRecoveryScreen(),
//                                 transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                                   return SlideTransition(
//                                     position: animation.drive(
//                                       Tween(begin: Offset(1.0, 0.0), end: Offset.zero),
//                                     ),
//                                     child: child,
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                           child: Text(
//                             'Signup',
//                             style: TextStyle(
//                               color: Color(0xFFE53E3E),
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PasswordRecoveryScreen extends StatefulWidget {
//   @override
//   _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
// }
//
// class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen>
//     with TickerProviderStateMixin {
//   final TextEditingController _phoneController = TextEditingController();
//   final FocusNode _phoneFocusNode = FocusNode();
//   bool _isPhoneValid = false;
//   bool _isLoading = false;
//   late AnimationController _shakeController;
//   late Animation<double> _shakeAnimation;
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Animation for shake effect on invalid phone
//     _shakeController = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _shakeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 10.0,
//     ).animate(CurvedAnimation(
//       parent: _shakeController,
//       curve: Curves.elasticIn,
//     ));
//
//     // Fade animation for the screen
//     _fadeController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));
//
//     _fadeController.forward();
//
//     // Listen to phone changes
//     _phoneController.addListener(_validatePhone);
//     _phoneFocusNode.addListener(() {
//       setState(() {});
//     });
//   }
//
//   void _validatePhone() {
//     final phone = _phoneController.text;
//     // تحقق من رقم الهاتف السعودي أو الدولي
//     final phoneRegex = RegExp('');
//     setState(() {
//       _isPhoneValid = phoneRegex.hasMatch(phone.replaceAll(' ', '').replaceAll('-', '')) && phone.isNotEmpty;
//     });
//   }
//
//   void _shakeField() {
//     _shakeController.forward().then((_) {
//       _shakeController.reverse();
//     });
//   }
//
//   void _handleNext() async {
//     if (!_isPhoneValid) {
//       _shakeField();
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // Simulate API call
//     await Future.delayed(Duration(seconds: 2));
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     // Show success message
//     _showSuccessDialog();
//   }
//
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Color(0xFF2D2D2D),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Column(
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.green[100]?.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.check,
//                   color: Colors.green[400],
//                   size: 30,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'SMS Sent!',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF9CA3AF),
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'Password recovery code has been sent to ${_phoneController.text}',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           actions: [
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFE53E3E),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: Text(
//                   'OK',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1A1A1A),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//
//                 // Back Button
//                 Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF2D2D2D),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Color(0xFF374151), width: 1),
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: Color(0xFF9CA3AF),
//                       size: 20,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 40),
//
//                 // Title
//                 Text(
//                   'Password recovery',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF9CA3AF),
//                     letterSpacing: -0.5,
//                   ),
//                 ),
//
//                 SizedBox(height: 12),
//
//                 // Subtitle
//                 Text(
//                   'Enter your phone number to recover your\npassword',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Color(0xFF6B7280),
//                     height: 1.4,
//                   ),
//                 ),
//
//                 SizedBox(height: 60),
//
//                 // Phone Input Field
//                 AnimatedBuilder(
//                   animation: _shakeAnimation,
//                   builder: (context, child) {
//                     return Transform.translate(
//                       offset: Offset(_shakeAnimation.value, 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFF2D2D2D),
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: _phoneFocusNode.hasFocus
//                                 ? Color(0xFFE53E3E)
//                                 : Color(0xFF374151),
//                             width: _phoneFocusNode.hasFocus ? 2 : 1,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.phone_outlined,
//                                 color: Color(0xFF6B7280),
//                                 size: 20,
//                               ),
//                               SizedBox(width: 16),
//                               Expanded(
//                                 child: TextField(
//                                   controller: _phoneController,
//                                   focusNode: _phoneFocusNode,
//                                   keyboardType: TextInputType.phone,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Color(0xFF9CA3AF),
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   decoration: InputDecoration(
//                                     hintText: 'Phone number',
//                                     hintStyle: TextStyle(
//                                       color: Color(0xFF6B7280),
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.symmetric(vertical: 16),
//                                   ),
//                                 ),
//                               ),
//                               if (_isPhoneValid)
//                                 Container(
//                                   width: 20,
//                                   height: 20,
//                                   decoration: BoxDecoration(
//                                     color: Colors.green[400],
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Icon(
//                                     Icons.check,
//                                     size: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 Spacer(),
//
//                 // Next Button
//                 Container(
//                   width: double.infinity,
//                   height: 52,
//                   margin: EdgeInsets.only(bottom: 40),
//                   child: ElevatedButton(
//                     onPressed: _handleNext,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFE53E3E),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                     ),
//                     child: _isLoading
//                         ? SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                         strokeWidth: 2.5,
//                       ),
//                     )
//                         : Text(
//                       'Next',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _phoneFocusNode.dispose();
//     _shakeController.dispose();
//     _fadeController.dispose();
//     super.dispose();
//   }
// }

import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/services/ecash_payment_service.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/data/models/ecash_model.dart';
import 'package:ecommerce/features/payment_method/components/build_payment_tab.dart';
import 'package:ecommerce/features/payment_method/components/initil_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'payment_page.dart';

class PaymentMethodScreen extends StatelessWidget {
  final String selectedPaymentMethod = 'cash';

  const PaymentMethodScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'Payment method',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Column(
            children: [
              // Payment method selection tabs
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 20.h),
                child: Row(
                  children: [
                    BuildPaymentTab(
                      title: 'Pay with ecash',
                      value: 'card',
                      icon: Icons.credit_card,
                    ),
                    SizedBox(width: 8.w),
                    BuildPaymentTab(
                      title: 'Pay with cash',
                      value: 'cash',
                      icon: Icons.money,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Cash illustration
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Image.asset('assets/Illustration/PayWithCash_darkTheme.png' , height: 150.h, width: 200.w,)
                    ),

                    SizedBox(height: 40.h),

                     Text(
                       MainCubit.get(context).selectedPaymentMethod == 'cash'? 'Pay with cash' : 'Pay with ecash',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Text(
                        MainCubit.get(context).selectedPaymentMethod == 'cash' ? 'Prefer to pay in cash? No problem! Pay the exact order amount when your delivery arrives at your doorstep.' : 'Pay securely with your ecash wallet. Fast, convenient, and your payment is processed instantly upon confirmation.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16.sp,
                          height: 1.4.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Confirm button
              Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    initiatePayment(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}



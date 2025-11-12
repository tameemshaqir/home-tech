import 'package:ecommerce/features/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateIndicator extends StatelessWidget {
  final status;

  const StateIndicator({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = ['Ordered', 'Processing',  'Delivered'];
    final currentStep = 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Names
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < steps.length; i++)
              Expanded(
                child: Text(
                  steps[i],
                  style: TextStyle(
                    color: i <= currentStep ? Colors.white : Colors.grey[600],
                    fontSize: 10.sp,
                    fontWeight: i == currentStep ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: i == 0
                      ? TextAlign.start
                      : i == steps.length - 1
                      ? TextAlign.end
                      : TextAlign.center,
                ),
              ),
          ],
        ),

        SizedBox(height: 8.h),

        // Progress Bar
        Row(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              // Circle
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i <= currentStep ? Color(0xFF00C853) : Colors.grey[600],
                ),
                child: i <= currentStep
                    ? Icon(Icons.check, size: 12.r, color: Colors.white)
                    : null,
              ),
              // Line (except for last item)
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2.h,
                    color: i < currentStep ? Color(0xFF00C853) : Colors.grey[600],
                  ),
                ),
            ],
          ],
        ),
      ],
    );
  }
}
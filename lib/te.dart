import 'package:ecommerce/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/cubits/user_cubit/user_states.dart';
import 'package:ecommerce/data/models/inf_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class SalesRepresentativePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
  builder: (context, state) {
    var model = UserCubit.get(context).infModel;
    if(model == null){
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'sales_rep_dashboard'.tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            elevation: 0,
            centerTitle: true,
          ),
        body: Center(child: CircularProgressIndicator(),),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'sales_rep_dashboard'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // بطاقات الأرباح
            _buildEarningsCards(model),
            SizedBox(height: 24.h),

            // قسم الكوبونات
            _buildCouponsSection(model),
          ],
        ),
      ),
    );
  },
);
  }



  Widget _buildEarningsCards(InfModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'earnings_and_sales'.tr(),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,

          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildEarningCard(
                'total_earnings'.tr(),
                '${model.data?.totalFixedRewards}',
                Icons.account_balance_wallet,
                Colors.green,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildEarningCard(
                'total_point'.tr(),
                '${model.data?.totalPointsRewards}',
                Icons.calendar_today,
                Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEarningCard(String title, String amount, IconData icon, Color color, {bool fullWidth = false}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              if (fullWidth) ...[
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (!fullWidth) ...[
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Text(
            amount,
            style: TextStyle(
              fontSize: fullWidth ? 20.sp : 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsSection(InfModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'available_coupons'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${model.data?.totalCoupons} ${'coupons'.tr()}',
                style: TextStyle(
                  color: Colors.indigo[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.data?.totalCoupons?? 0,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return _buildCouponCard(model.data?.couponsSummary?[index]);
          },
        ),
      ],
    );
  }

  Widget _buildCouponCard(model) {
    bool isActive = model.validUntil == DateTime.now().toString();
    Color statusColor = isActive ? Colors.green : Colors.red;
    String discount = 'nooooooooooooooo';
    String rewards = model.rewards != "" ? model.rewards : '0';
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  model.code,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  isActive ? 'active'.tr() : 'expired'.tr(),
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_offer, size: 16, color: Colors.orange),
                        SizedBox(width: 6.w),
                        Text(
                          '${'discount'.tr()}: $discount',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.monetization_on, size: 16, color: Colors.green),
                        SizedBox(width: 6.w),
                        Text(
                          '${'الارياح'.tr()}: $rewards',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.deepPurple),
                        SizedBox(width: 6.w),
                        Text(
                          '${'expires'.tr()}: ${model.validUntil}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tr('usage_count'),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${model.totalUsed}/${model.totalAvailable + model.totalUsed}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: model.totalUsed / (model.totalAvailable + model.totalUsed),
            backgroundColor: Colors.grey[600],
            valueColor: AlwaysStoppedAnimation<Color>(
              isActive ? Colors.deepPurple : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
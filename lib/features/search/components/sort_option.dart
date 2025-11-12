import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/cubits/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableSortBottomSheet {

  static void show({
    required BuildContext context,
    required List<String> options,
    required String selectedOption,
    required Function(String) onOptionSelected,
    required String title ,
    Color backgroundColor = const Color(0xFF1A1A1A),
    Color selectedColor = Colors.red,
    Color textColor = Colors.white,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _SortBottomSheetWidget(
        options: options,
        selectedOption: selectedOption,
        onOptionSelected: onOptionSelected,
        title: title,
        backgroundColor: backgroundColor,
        selectedColor: selectedColor,
        textColor: textColor,
      ),
    );
  }
}


class _SortBottomSheetWidget extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionSelected;
  final String title;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;

  const _SortBottomSheetWidget({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.title,
    required this.backgroundColor,
    required this.selectedColor,
    required this.textColor,
  }) : super(key: key);

  @override
  _SortBottomSheetWidgetState createState() => _SortBottomSheetWidgetState();
}

class _SortBottomSheetWidgetState extends State<_SortBottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late String selectedOption;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
          ),
          transform: Matrix4.translationValues(
            0,
            (1 - _animation.value) * 200,
            0,
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // عنوان
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // خيارات الترتيب
              ...widget.options.map((option) => _buildOption(option)).toList(),

              // مساحة إضافية في الأسفل
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(String option) {
    final isSelected = option == selectedOption;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });

        // تأخير قصير لإظهار التحديد
        Future.delayed(Duration(milliseconds: 150), () {
          widget.onOptionSelected(selectedOption);
          _closeSheet();
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        color: isSelected ? widget.selectedColor.withOpacity(0.1) : Colors.transparent,
        child: Row(
          children: [
            // دائرة الاختيار
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? widget.selectedColor : Colors.grey[600]!,
                  width: 2.w,
                ),
                color: isSelected ? widget.selectedColor : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )
                  : null,
            ),

            SizedBox(width: 16.w),

            // النص
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: TextStyle(
                  color: isSelected ? widget.textColor : Colors.grey[400]!,
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                child: Text(option),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _closeSheet() {
    _animationController.reverse().then((_) {
      Navigator.of(context).pop();
    });
  }
}


void showSortOptions(BuildContext context , List<String> sortOptions , String selectedSort) {
  ReusableSortBottomSheet.show(
    context: context,
    options: sortOptions,
    selectedOption: selectedSort,
    title: 'Sort by'.tr(),
    backgroundColor: Color(0xFF1A1A1A),
    selectedColor: Colors.red,
    textColor: Colors.white,
    onOptionSelected: (option) {
        selectedSort = option;
      if(option == 'Price: Low to High'.tr()){
        SearchCubit.get(context).sortProductsByPriceAscending();
      }else{
        SearchCubit.get(context).sortProductsByPriceDescending();
      }
    },
  );
}
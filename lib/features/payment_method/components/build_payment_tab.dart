import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';

class BuildPaymentTab extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const BuildPaymentTab({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    bool isSelected = MainCubit.get(context).selectedPaymentMethod == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          MainCubit.get(context).changePaymentMethod(value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6366F1)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6366F1)
                  : const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

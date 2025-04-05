import 'package:amazmart/core/app_export.dart';
import 'package:flutter/material.dart';

class OrderStatus {
  final String title;
  final String subtitle;
  final String date;
  final bool isCompleted;

  OrderStatus({
    required this.title,
    required this.subtitle,
    required this.date,
    this.isCompleted = false,
  });
}

class OrderTimeline extends StatelessWidget {
  final List<OrderStatus> orderStatuses;

  const OrderTimeline({
    super.key,
    required this.orderStatuses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderStatuses.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final status = orderStatuses[index];
        final isLast = index == orderStatuses.length - 1;

        return SizedBox(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: CustomImageView(
                          imagePath: status.isCompleted
                              ? ImageConstant.iconTrackActive
                              : ImageConstant.iconTrackInActive),
                      decoration: BoxDecoration(
                        color: status.isCompleted
                            ? theme.primaryColor
                            : appTheme.gray50,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: status.isCompleted
                              ? theme.primaryColor
                              : appTheme.gray50,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: status.isCompleted
                            ? theme.primaryColor
                            : appTheme.gray50,
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              status.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: status.isCompleted
                                    ? appTheme.whiteA700
                                    : appTheme.black900,
                              ),
                            ),
                            Text(
                              status.date,
                              style: TextStyle(
                                fontSize: 14,
                                color: status.isCompleted
                                    ? appTheme.whiteA700
                                    : theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          status.subtitle,
                          style: TextStyle(
                            color: status.isCompleted
                                ? appTheme.whiteA700
                                : appTheme.blueGray400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
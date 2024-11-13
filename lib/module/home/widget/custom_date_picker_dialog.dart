import 'package:employee_detail_app/utils/app_assets.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_functions.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:employee_detail_app/widgets/common_button.dart';
import 'package:employee_detail_app/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePickerDialog extends StatefulWidget {
  final DateTime? fromdate;
  final bool isFromDate;
  final Function(String) onPressed;
  final String? selectedString;
  const CustomDatePickerDialog(
      {super.key,
      this.fromdate,
      required this.onPressed,
      this.isFromDate = true,
      this.selectedString});
  @override
  _CustomDatePickerDialogState createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  DateTime? selectedDate;
  String? selectedString;
  @override
  void initState() {
    selectedString = widget.selectedString;

    if ((widget.selectedString ?? "").isNotEmpty &&
        widget.selectedString != AppStrings.noDate) {
      selectedDate = AppFunctions.parseDate(selectedString!);
    }

    setRangeStrings();
    setState(() {});
    super.initState();
  }

  void setRangeStrings() {
    DateTime now = DateTime.now();
    selectedString = (widget.selectedString ?? "").isEmpty
        ? (widget.isFromDate ? AppStrings.todayText : AppStrings.noDate)
        : widget.selectedString;
    // Calculate the next Monday and next Tuesday
    DateTime nextMonday =
        now.add(Duration(days: (DateTime.monday - now.weekday + 7) % 7));
    DateTime nextTuesday =
        now.add(Duration(days: (DateTime.tuesday - now.weekday + 7) % 7));
    if (selectedString == AppStrings.todayText) {
      selectedDate = DateTime.now();
    }
    if (selectedDate != null) {
      if (isSameDayString(selectedDate!, now)) {
        selectedString = AppStrings.todayText;
      } else if (isSameDayString(selectedDate!, nextMonday)) {
        // If the selected date is next Monday
        selectedString = AppStrings.nextMonday;
      } else if (isSameDayString(selectedDate!, nextTuesday)) {
        // If the selected date is next Tuesday
        selectedString = AppStrings.nextTuesday;
      } else if (selectedDate!.isAfter(now.add(const Duration(days: 6)))) {
        // If the selected date is more than a week from today
        selectedString = AppStrings.afterOneWeek;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date Range Option Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                widget.isFromDate
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CommonButton(
                                    text: AppStrings.todayText,
                                    height: 36,
                                    width: double.infinity,
                                    buttonColor:
                                        selectedString == AppStrings.todayText
                                            ? AppColors.primaryColor
                                            : AppColors.lightBlue,
                                    textColor:
                                        selectedString == AppStrings.todayText
                                            ? AppColors.secondaryColor
                                            : AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    onTap: () {
                                      selectedString = AppStrings.todayText;
                                      _setDateRange(DateTime.now()); // Today
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: CommonButton(
                                    text: AppStrings.nextMonday,
                                    height: 36,
                                    width: double.infinity,
                                    buttonColor:
                                        selectedString == AppStrings.nextMonday
                                            ? AppColors.primaryColor
                                            : AppColors.lightBlue,
                                    textColor:
                                        selectedString == AppStrings.nextMonday
                                            ? AppColors.secondaryColor
                                            : AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    onTap: () {
                                      selectedString = AppStrings.nextMonday;
                                      _setNextMonday();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CommonButton(
                                    text: AppStrings.nextTuesday,
                                    height: 36,
                                    width: double.infinity,
                                    buttonColor:
                                        selectedString == AppStrings.nextTuesday
                                            ? AppColors.primaryColor
                                            : AppColors.lightBlue,
                                    textColor:
                                        selectedString == AppStrings.nextTuesday
                                            ? AppColors.secondaryColor
                                            : AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    onTap: () {
                                      selectedString = AppStrings.nextTuesday;
                                      _setNextTuesday();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: CommonButton(
                                    text: AppStrings.afterOneWeek,
                                    height: 36,
                                    width: double.infinity,
                                    buttonColor: selectedString ==
                                            AppStrings.afterOneWeek
                                        ? AppColors.primaryColor
                                        : AppColors.lightBlue,
                                    textColor: selectedString ==
                                            AppStrings.afterOneWeek
                                        ? AppColors.secondaryColor
                                        : AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    onTap: () {
                                      selectedString = AppStrings.afterOneWeek;
                                      _setDateRange(DateTime.now()
                                          .add(const Duration(days: 7)));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CommonButton(
                                text: AppStrings.noDate,
                                height: 36,
                                width: double.infinity,
                                buttonColor: selectedString == AppStrings.noDate
                                    ? AppColors.primaryColor
                                    : AppColors.lightBlue,
                                textColor: selectedString == AppStrings.noDate
                                    ? AppColors.secondaryColor
                                    : AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                onTap: () {
                                  selectedString = AppStrings.noDate;
                                  widget.onPressed(AppStrings.noDate);
                                  selectedDate = null;
                                  setState(() {});
                                  // _setNextTuesday();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: CommonButton(
                                text: AppStrings.todayText,
                                height: 36,
                                width: double.infinity,
                                buttonColor:
                                    selectedString == AppStrings.todayText
                                        ? AppColors.primaryColor
                                        : AppColors.lightBlue,
                                textColor:
                                    selectedString == AppStrings.todayText
                                        ? AppColors.secondaryColor
                                        : AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                onTap: () {
                                  selectedString = AppStrings.todayText;
                                  _setDateRange(DateTime.now()); // Today
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                // Calendar widget (use package: table_calendar)
                TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: selectedDate ?? DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day) || selectedDate == day;
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      selectedString = null;
                    });
                  },
                  enabledDayPredicate: (day) {
                    // Disable dates before selectedFromDate
                    if (widget.fromdate == null) {
                      return true; // Allow all dates if no fromDate is selected
                    }
                    return day.isAfter(
                        widget.fromdate!); // Disable dates before fromDate
                  },
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, // Hide format toggle
                      titleCentered: true,
                      leftChevronIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: SvgImage(
                          image: AppAssets.arrowLeft,
                          height: 14,
                          width: 14,
                          // color:AppColors.borderColor
                        ),
                      ),
                      rightChevronIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: SvgImage(
                          image: AppAssets.arrowRight,
                          height: 14,
                          width: 14,
                        ),
                      ),
                      leftChevronPadding: const EdgeInsets.only(right: 0),
                      rightChevronPadding: const EdgeInsets.only(left: 0),
                      // leftChevronMargin: EdgeInsets.zero,
                      // rightChevronMargin: EdgeInsets.zero,
                      headerMargin: const EdgeInsets.only(right: 42, left: 42),
                      headerPadding: EdgeInsets.only(bottom: 25.h),
                      // titleTextStyle: AppStyles.textStyle18
                      //   ..copyWith(color: AppColors.textColor),
                      titleTextStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor)),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: AppStyles.textStyle12.copyWith(
                        color: AppColors.textColor,
                        fontSize: 15), // Weekend color
                  ),
                  calendarStyle: CalendarStyle(
                    disabledTextStyle: AppStyles.textStyle12
                        .copyWith(color: AppColors.borderColor, fontSize: 15),
                    defaultTextStyle: AppStyles.textStyle12
                        .copyWith(color: AppColors.textColor, fontSize: 15),
                    todayDecoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        shape: BoxShape.circle,
                        color: AppColors.secondaryColor),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: AppStyles.textStyle12
                        .copyWith(color: AppColors.primaryColor, fontSize: 15),
                    selectedTextStyle:
                        AppStyles.textStyle12.copyWith(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Container(
              height: 1,
              width: double.infinity,
              color: AppColors.dividerColor,
            ),
          ),

          // Cancel and Save buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //calender icon
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: const SvgImage(
                        image: AppAssets.calender,
                        height: 28,
                        width: 24,
                      ),
                    ),
                    if (selectedDate != null ||
                        selectedString == AppStrings.noDate)
                      //selected date
                      Text(
                        selectedString == AppStrings.noDate
                            ? selectedString!
                            : AppFunctions.getStringFromDateTime(selectedDate!),
                        style: AppStyles.textStyle16
                            .copyWith(color: AppColors.textColor),
                      )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //cancel
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CommonButton(
                        text: AppStrings.cancelText,
                        buttonColor: AppColors.primaryColor.withOpacity(.1),
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          popScreen(context);
                        },
                      ),
                    ),
                    //save
                    CommonButton(
                      text: AppStrings.saveText,
                      onTap: () {
                        if (selectedString == AppStrings.noDate) {
                          widget.onPressed(selectedString!);
                        } else {
                          if (selectedDate != null) {
                            widget.onPressed(AppFunctions.getStringFromDateTime(
                                selectedDate!));
                          }
                        }
                        popScreen(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setDateRange(DateTime fromDate) {
    setState(() {
      selectedDate = fromDate;
    });
  }

  void _setNextMonday() {
    final today = DateTime.now();
    // Calculate the number of days to the next Monday
    int daysUntilNextMonday = (DateTime.monday - today.weekday + 7) % 7;
    daysUntilNextMonday = daysUntilNextMonday == 0 ? 7 : daysUntilNextMonday;

    // Next Monday is today + daysUntilNextMonday
    DateTime nextMonday = today.add(Duration(days: daysUntilNextMonday));

    setState(() {
      selectedDate = nextMonday;
    });
  }

  void _setNextTuesday() {
    final today = DateTime.now();
    // Calculate the number of days to the next Tuesday
    int daysUntilNextTuesday = (DateTime.tuesday - today.weekday + 7) % 7;
    daysUntilNextTuesday = daysUntilNextTuesday == 0 ? 7 : daysUntilNextTuesday;

    // Next Tuesday is today + daysUntilNextTuesday
    DateTime nextTuesday = today.add(Duration(days: daysUntilNextTuesday));

    setState(() {
      selectedDate = nextTuesday;
    });
  }

  bool isSameDayString(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

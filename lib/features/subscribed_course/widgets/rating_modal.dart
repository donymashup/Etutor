import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void showRatingDialog(BuildContext context, String courseId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => _RatingBottomSheet(courseid: courseId),
  );
}

class _RatingBottomSheet extends StatefulWidget {
  final String courseid;
  const _RatingBottomSheet({
    required this.courseid,
  });

  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<_RatingBottomSheet>
    with TickerProviderStateMixin {
  int selectedRating = 0;
  final TextEditingController suggestionController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();
  late AnimationController _heightAnimationController;
  late Animation<double> _heightAnimation;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _heightAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 0.5,
      end: 0.85,
    ).animate(CurvedAnimation(
      parent: _heightAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    suggestionController.dispose();
    textFieldFocusNode.dispose();
    _heightAnimationController.dispose();
    super.dispose();
  }

  String getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Very Bad";
      case 2:
        return "Bad";
      case 3:
        return "Okay";
      case 4:
        return "Good";
      case 5:
        return "Excellent";
      default:
        return "";
    }
  }

  void _onRatingSelected(int rating) {
    setState(() {
      selectedRating = rating;
    });
    _heightAnimationController.forward();
  }

  Future<void> _submitFeedback() async {
    if (selectedRating == 0) return;
    setState(() => isLoading = true);
    textFieldFocusNode.unfocus();

    try {
      await Provider.of<SubcribedCourseProvider>(
        context,
        listen: false,
      ).updateCourseRating(
        context: context,
        courseid: widget.courseid,
        rating: selectedRating.toString(),
        comment: suggestionController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Thanks for your ${selectedRating}★ feedback!",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            textFieldFocusNode.unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * _heightAnimation.value,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // header
                Container(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                    bottom: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.close, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // body
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Lottie.asset(
                            'assets/lottie/ratinglottie.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Rate your course experience",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => _onRatingSelected(index + 1),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.star,
                                  size: 36,
                                  color: index < selectedRating
                                      ? Colors.orange
                                      : Colors.grey.shade300,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: selectedRating > 0
                              ? Text(
                                  getRatingText(selectedRating),
                                  key: ValueKey(selectedRating),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedRating >= 4
                                        ? Colors.green[600]
                                        : selectedRating == 3
                                            ? Colors.orange[600]
                                            : Colors.red[600],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: selectedRating > 0
                              ? Column(
                                  key: const ValueKey('review_section'),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Share Your Thoughts",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                      ),
                                      child: TextField(
                                        controller: suggestionController,
                                        focusNode: textFieldFocusNode,
                                        maxLines: 4,
                                        maxLength: 500,
                                        textInputAction:
                                            TextInputAction.newline,
                                        decoration: InputDecoration(
                                          hintText: selectedRating >= 4
                                              ? "Tell us what you loved about the course..."
                                              : selectedRating == 3
                                                  ? "How can we improve your experience?"
                                                  : "Please let us know what went wrong...",
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          counterStyle: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                        style:
                                            const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                )
                              : const SizedBox.shrink(key: ValueKey('empty')),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:
                                (selectedRating == 0 || isLoading)
                                    ? null
                                    : _submitFeedback,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedRating == 0
                                  ? Colors.grey[300]
                                  : AppColor.secondaryColor,
                              foregroundColor: Colors.white,
                              elevation: selectedRating == 0 ? 0 : 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    selectedRating == 0
                                        ? "Select a rating"
                                        : "Submit Feedback",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
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

import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showRatingDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => _RatingBottomSheet(),
  );
}

class _RatingBottomSheet extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    _heightAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 0.5, // Small initial height (50% of screen)
      end: 0.85,  // Expanded height (85% of screen)
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
    // Expand modal when rating is selected
    _heightAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // Dismiss keyboard when tapping outside
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
                // Fixed header with only close button
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
                      // Drag handle
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Close button
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
                // Scrollable content - everything from lottie onwards
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: Column(
                      children: [
                        // Lottie animation
                        SizedBox(
                          height: 150,
                          child: Lottie.asset(
                            'assets/lottie/ratinglottie.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        const Text(
                          "Rate your course experience",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Star rating
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
                        // Rating text
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
                        // Review section - only show when rating is selected
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
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: TextField(
                                        controller: suggestionController,
                                        focusNode: textFieldFocusNode,
                                        maxLines: 4,
                                        maxLength: 500,
                                        textInputAction: TextInputAction.newline,
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
                                          contentPadding: const EdgeInsets.all(16),
                                          counterStyle: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                )
                              : const SizedBox.shrink(key: ValueKey('empty')),
                        ),
                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: selectedRating == 0
                                ? null
                                : () {
                                    textFieldFocusNode.unfocus();
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
                                  },
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
                            child: Text(
                              selectedRating == 0 ? "Select a rating" : "Submit Feedback",
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
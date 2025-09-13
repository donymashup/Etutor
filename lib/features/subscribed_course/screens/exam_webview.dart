import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/subscribed_course/screens/soluction_webview_tests.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExamWebView extends StatefulWidget {
  final String testid;
  final String userid;
  final String title;
  final bool isMain;

  const ExamWebView({
    super.key,
    required this.testid,
    required this.userid,
    required this.title,
    required this.isMain,
  });

  @override
  State<ExamWebView> createState() => _ExamWebViewState();
}

class _ExamWebViewState extends State<ExamWebView> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setBackgroundColor(AppColor.whiteColor) 
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..addJavaScriptChannel(
        'quizFinished',
        onMessageReceived: (JavaScriptMessage message) {
          if (mounted) {
            Future.delayed(const Duration(seconds: 2), () {
              widget.isMain
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBarScreen(),
                      ),
                    )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SoluctionExamWebView(
                          testid: widget.testid,
                          isMain: false,
                          title: widget.title,
                        ),
                      ),
                    );
            });
          }
        },
      )
      ..loadRequest(
        Uri.parse(
          widget.isMain
              ? '$baseUrl/quiz/attendtest/mains/${widget.testid}/${widget.userid}'
              : '$baseUrl/quiz/attendPracticeTest/${widget.testid}/${widget.userid}',
        ),
      );
  }

  Future<bool> _onWillPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text(
            'Are you sure you want to go back? Your test progress may be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    if (shouldPop == true && mounted) {
      widget.isMain
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SoluctionExamWebView(
                  testid: widget.testid,
                  isMain: false,
                  title: widget.title,
                ),
              ),
            );
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor, 
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: CustomBackButton(),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: AppColor.whiteColor, 
              child: WebViewWidget(controller: _webViewController),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(), 
              ),
          ],
        ),
      ),
    );
  }
}

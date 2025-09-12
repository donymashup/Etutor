
import 'package:etutor/common/constants/config.dart' as AppConstants;
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/my_course/screens/my_course.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExamWebView extends StatefulWidget {
  final String testid;
  final String userid;
  final String title;

  const ExamWebView({
    super.key,
    required this.testid,
    required this.userid,
    required this.title,
  });

  @override
  State<ExamWebView> createState() => _ExamWebViewState();
}

class _ExamWebViewState extends State<ExamWebView> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'quizFinished',
        onMessageReceived: (JavaScriptMessage message) {
          if (mounted) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
              );
            });
          }
        },
      )
      ..loadRequest(Uri.parse(
          '${AppConstants.baseUrl}/quiz/attendtest/${widget.testid}/${widget.userid}'
          ));
          

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
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
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Reload',
              onPressed: () {
                _webViewController.reload();
              },
            ),
          ],
        ),
        body: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}

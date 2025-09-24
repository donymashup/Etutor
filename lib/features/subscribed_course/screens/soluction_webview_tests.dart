import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/subscribed_course/provider/chapter_card_overview_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SoluctionExamWebView extends StatefulWidget {
  final String testid;
  final String title;
  final bool isMain;

  const SoluctionExamWebView({
    super.key,
    required this.testid,
    required this.title,
    required this.isMain,
  });

  @override
  State<SoluctionExamWebView> createState() => _SoluctionExamWebViewState();
}

class _SoluctionExamWebViewState extends State<SoluctionExamWebView> {
  late final WebViewController _webViewController;
  bool _isLoading = true; 

  @override
  void initState() {
    super.initState();
    final userDetailsProvider = context.read<UserDetailsProvider>();

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBarScreen(),
                ),
              );
            });
          }
        },
      )
      ..loadRequest(
        Uri.parse(
          widget.isMain
              ? '$baseUrl/Quiz/ViewAnswerSheet/mains/${widget.testid}/${userDetailsProvider.userDetails.data!.id}'
              : '$baseUrl/Quiz/ViewAnswerSheet/practice/${widget.testid}/${userDetailsProvider.userDetails.data!.id}',
        ),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
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
    );
  }
}

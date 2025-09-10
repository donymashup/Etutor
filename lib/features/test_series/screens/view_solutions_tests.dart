import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/test_series/provider/soluction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class ViewSolutionsTests extends StatefulWidget {
  final String testId;

  const ViewSolutionsTests({
    super.key,
    required this.testId,
  });

  @override
  State<ViewSolutionsTests> createState() => _ViewSolutionsTestsState();
}

class _ViewSolutionsTestsState extends State<ViewSolutionsTests> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SolutionProvider>(context, listen: false).loadSolution(
        testId: widget.testId,
        type: "mains",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "View Answer Sheet",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: Consumer<SolutionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          if (provider.htmlData != null) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(18),
              child: Html(data: provider.htmlData),
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}

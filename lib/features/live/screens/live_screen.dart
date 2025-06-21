import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/screens/ongoing_live_screen.dart';
import 'package:etutor/features/live/screens/recorded_live_screen.dart';
import 'package:etutor/features/live/screens/upcoming_live_screen.dart';
import 'package:flutter/material.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen>with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget> _body = [ OngoingLiveScreen(),UpcomingLiveScreen(),RecordedLiveScreen()];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
   @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight:kToolbarHeight -10 ,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text("Live Class",style: TextStyle(fontSize: 20),),
          ),
        ),
        body: DefaultTabController(
          length: 3, 
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.greyTabBar,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color:AppColor.primaryColor,
                    ),
                    padding: const EdgeInsets.all(5),
                     labelStyle: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.w600),
                     unselectedLabelStyle:TextStyle(color: AppColor.blackColor,) ,
                    tabs: const [
                      Tab(text: "Ongoing"),
                      Tab(text: "Upcoming"),
                      Tab(text: "Recorded"),   
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                 // physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: _body,
                ),
              ),
            ],
          ),
          ),
      ),
    );
  }
}
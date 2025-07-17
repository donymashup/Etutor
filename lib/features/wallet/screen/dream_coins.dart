import 'package:etutor/features/wallet/screen/redeemed_sucessfully';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/wallet/widgets/parabola_shaphed_painter.dart';


class DreamCoins extends StatefulWidget {
  const DreamCoins({super.key});

  @override
  State<DreamCoins> createState() => _DreamCoinsState();
}

class _DreamCoinsState extends State<DreamCoins> {
  int? expandedIndex;

  List<Map<String, String>> history = [
    {'type': 'reward', 'name': 'Target UPSC daily quiz', 'date': '14 Apl 2025', 'amt': '15'},
    {'type': 'reward', 'name': 'Target UPSC daily quiz', 'date': '13 Apl 2025', 'amt': '25'},
    {'type': 'redemption', 'name': 'Reward redemption', 'date': '12 Apl 2025', 'amt': '35'},
    {'type': 'reward', 'name': 'Target UPSC daily quiz', 'date': '12 Apl 2025', 'amt': '35'},
    {'type': 'purchase', 'name': 'Course Purchase', 'date': '11 Apl 2025', 'amt': '20'},
    {'type': 'reward', 'name': 'Target UPSC daily quiz', 'date': '11 Apl 2025', 'amt': '20'},
  ];

  final List<Map<String, String>> qaList = [
    {
      "question": "What is DreamCoin?",
      "answer":
          "DreamCoin is a virtual wallet coin you earn by participating in the daily UPSC Target Quiz. It encourages consistency and rewards learning."
    },
    {
      "question": "How can I earn DreamCoins?",
      "answer": "You can collect DreamCoins by attending and completing the daily UPSC Target Quiz in the app."
    },
    {
      "question": "Where can I use DreamCoins?",
      "answer": "DreamCoins can be used to purchase courses available in the app or redeemed to your bank account when you meet the minimum redemption criteria."
    },
    {
      "question": "Is there a limit to earning DreamCoins?",
      "answer": "You can earn DreamCoins daily by participating in quizzes. There's no strict limit, but consistency boosts your rewards."
    },
    {
      "question": "How do I redeem DreamCoins to my bank?",
      "answer":
          "Once you reach the minimum redeemable amount, you can request a withdrawal to your linked bank account directly from the app."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
        title: Text("Dream Coins",
            style: TextStyle(color: AppColor.whiteColor, fontSize: 20)),
        backgroundColor: AppColor.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  painter: ParabolaShaphedPainter(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: Image.asset('assets/images/cloud_right.png', height: 150),
                ),
                Positioned(
                  left: 0,
                  bottom: 50,
                  child: Image.asset('assets/images/cloud_left.png', height: 150),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/star.png', width: 40, height: 40),
                            const SizedBox(width: 10),
                            const Text("35", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Available DreamCoin", style: TextStyle(fontWeight: FontWeight.w300)),
                            const SizedBox(width: 5),
                            Tooltip(
                              message: '10 DreamCoin = ₹1',
                              triggerMode: TooltipTriggerMode.tap,
                              child: Icon(Icons.info_outline,
                                  color: AppColor.greyIconDark, size: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SlideAction(
                            height: 50,
                            sliderButtonIconPadding: 7,
                            text: 'Swipe to Redeem',
                            textStyle: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 18,
                            ),
                            outerColor: AppColor.whiteColor,
                            innerColor: AppColor.secondaryColor,
                            borderRadius: 10,
                            sliderButtonIcon: const Icon(Icons.arrow_forward_ios_outlined, size: 18),
                            elevation: 5,
                            onSubmit: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  child: SizedBox.expand(
                                    child: Lottie.asset(
                                      'assets/lottie/rupee_coins_falling.json',
                                      fit: BoxFit.cover,
                                      repeat: true,
                                    ),
                                  ),
                                ),
                              );

                              await Future.delayed(const Duration(seconds: 5));

                              Navigator.of(context).pop(); // close dialog

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CoinRedeemedSuccessPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Redeem DreamCoins on reaching 50",
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: history.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Reward History",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                Image.asset("assets/icons/star.png", width: 20, height: 20),
                                const SizedBox(width: 5),
                                const Text("₹95",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(
                          history.length,
                          (index) {
                            final item = history[index];
                            Widget leading;
                            Color? textColor;

                            if (item['type'] == 'reward') {
                              leading = Image.asset("assets/images/targetupsc.png", width: 40);
                            } else if (item['type'] == 'redemption') {
                              leading = Image.asset("assets/icons/rupee.png", width: 30);
                              textColor = AppColor.secondaryColor;
                            } else {
                              leading = Image.asset("assets/icons/shopping-card.png", width: 30);
                              textColor = AppColor.redStroke;
                            }

                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: leading,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(item['name']!,
                                                  style: TextStyle(color: textColor)),
                                              Text(item['date']!,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 13,
                                                      color: textColor)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Row(
                                    children: [
                                      if (item['type'] == 'purchase')
                                        Text("-", style: TextStyle(color: AppColor.redStroke)),
                                      Image.asset("assets/icons/star.png", width: 20),
                                      const SizedBox(width: 5),
                                      Text(item['amt']!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500, color: textColor)),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
            ),
            const SizedBox(height: 10),
            ...List.generate(qaList.length, (index) {
              final item = qaList[index];
              final isExpanded = expandedIndex == index;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.greyStroke),
                  boxShadow: isExpanded
                      ? [BoxShadow(color: AppColor.greyBackground, blurRadius: 6, offset: Offset(0, 3))]
                      : [],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(item['question']!, style: const TextStyle(fontSize: 14)),
                      trailing: Icon(isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                      onTap: () {
                        setState(() {
                          expandedIndex = isExpanded ? null : index;
                        });
                      },
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(item['answer']!),
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    )
                  ],
                ),
              );
            }),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

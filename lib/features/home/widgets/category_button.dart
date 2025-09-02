import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  CategoryButton({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15 < 120
          ? 120
          : MediaQuery.of(context).size.width * 0.15,
      height: 60,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primaryColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style:  TextStyle(color: isSelected ? AppColor.whiteColor : Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


class CategoryButtonList extends StatefulWidget {
  const CategoryButtonList({super.key});

  @override
  State<CategoryButtonList> createState() => _CategoryButtonListState();
}

class _CategoryButtonListState extends State<CategoryButtonList> {
  HomepageProvider homepageProvider = HomepageProvider();

  @override
  Widget build(BuildContext context) {
    homepageProvider = context.watch<HomepageProvider>();
    return homepageProvider.isCategoryHeader
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder:(context, index){
                return  Card(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                             color: Colors.grey.shade300,
                          ),
                         
                           width:MediaQuery.of(context).size.width * 0.15 < 120
                    ? 120
                    : MediaQuery.of(context).size.width * 0.15, 
                        )),
                    );
              }),
          ),
        )

        : SizedBox(
            height: 60,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: homepageProvider.catogryDetails.length,
                itemBuilder: (context, index) {
                  final categoryNames = homepageProvider.catogryDetails[index];
                  final isSelected = homepageProvider.selectedIndex == index;
                  return GestureDetector(
                      onTap: () {
                        context
                            .read<HomepageProvider>()
                            .setSelectedIndex(index);
                      },
                      child: CategoryButton(
                        label: categoryNames.name ?? '',
                        isSelected: isSelected,
                      ));
                }),
          );
  }
}

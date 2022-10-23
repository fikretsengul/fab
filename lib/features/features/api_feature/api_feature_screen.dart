import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/graphql_api_page/graphql_api_page.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

class ApiFeatureScreen extends StatefulWidget {
  const ApiFeatureScreen({super.key});

  @override
  State<ApiFeatureScreen> createState() => _ApiFeatureScreenState();
}

class _ApiFeatureScreenState extends State<ApiFeatureScreen> {
  PageController controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    controller.addListener(() {
      controller.addListener(() {
        if (controller.page!.round() != currentPage) {
          setState(() {
            currentPage = controller.page!.round();
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: getTheme(context).primary,
              ),
            ),
          ),
          title: CustomSlidingSegmentedControl<int>(
            fixedWidth: 150,
            initialValue: currentPage,
            children: const {
              0: Text('Rest'),
              1: Text('GraphQL'),
            },
            decoration: BoxDecoration(
              color: getPrimaryColor(context),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            thumbDecoration: BoxDecoration(
              color: getCustomOnPrimaryColor(context),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(
                    0,
                    2,
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInToLinear,
            onValueChanged: (value) {
              controller.animateToPage(
                value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: PageView(
            controller: controller,
            children: const [GraphQLApiPage(), GraphQLApiPage()],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

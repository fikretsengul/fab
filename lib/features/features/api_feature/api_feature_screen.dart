import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_segmented_control.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/graphql_api_page/graphql_api_page.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/rest_api_page/rest_api_page.dart';
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
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          title: CustomSegmentedControl<int>(
            fixedWidth: 120,
            currentIndex: currentPage,
            children: {
              0: Text('Rest', style: getTextTheme(context).titleMedium),
              1: Text('GraphQL', style: getTextTheme(context).titleMedium),
            },
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
            children: const [RestApiPage(), GraphQLApiPage()],
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

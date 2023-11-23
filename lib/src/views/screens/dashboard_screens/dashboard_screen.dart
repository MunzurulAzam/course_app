import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loginapp/components.dart';
import 'package:loginapp/src/controllers/auth_controller/auth_controller.dart';
import 'package:loginapp/src/controllers/screen_controllers/dashboard_screen_controller/dashboard_screen_controller.dart';
import 'package:loginapp/src/models/app_models/page_model.dart';
import 'package:loginapp/src/views/widgets/others/custom_icon.dart';
import 'package:loginapp/src/views/widgets/others/custom_pop_up_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardScreenController _controller = Get.put(DashboardScreenController());
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(baseName),
        actions: [
          CustomPopUpMenuWidget<PageModel>(
            headWidget: CustomIcon(Icons.more_vert_rounded, size: defaultPadding, color: Theme.of(context).colorScheme.onBackground),
            items: _controller.dropDownList,
            onSelected: (item) {
              //---------------------------------------------------call sign-out method
              _authController.signOut();
            },
            itemBuilder: (item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Row(
                  children: [
                    SvgPicture.asset(item.svg,
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn), height: defaultPadding),
                    SizedBox(width: defaultPadding / 2),
                    Expanded(
                        child: Text(item.pageHeading,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold))),
                  ],
                ),
              );
            },
          ),
          SizedBox(width: defaultPadding / 3)
        ],
      ),
      body: GridView.builder(
        itemCount: 10,
        padding: EdgeInsets.all(defaultPadding/ 2),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: defaultPadding / 3,
          mainAxisSpacing: defaultPadding / 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: (){Get.to(Scaffold());},
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(defaultPadding / 2),
              ),
              child: DashboardScreensContents(),
            ),
          );
        },
      ),
    );
  }
}

//------------------------------------------------------------------------------------------------ course content

class DashboardScreensContents extends StatelessWidget {
  const DashboardScreensContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            height: double.infinity,
            child: Image.network(
              'https://www.excelptp.com/wp-content/uploads/2023/03/Flutter-Development-Course.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}

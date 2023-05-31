import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:gobank/home/savings/upgrade_plan.dart';
import 'package:story/story_page_view.dart';

class SavingsStory extends StatefulWidget {
  const SavingsStory({Key? key}) : super(key: key);

  @override
  State<SavingsStory> createState() => _SavingsStoryState();
}

class _SavingsStoryState extends State<SavingsStory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoryPageView(
      itemBuilder: (context, pageIndex, storyIndex) {
        return Center(
            child: Image.asset("images/savings_story/${storyIndex + 1}.png"));
      },
      storyLength: (pageIndex) {
        return 6;
      },
      pageLength: 1,
      onPageLimitReached: () {
        Get.to(() => const UpgradePlan());
      },
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/ui_constants.dart';
import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';

class TopicChipWidget extends StatelessWidget {
  final TopicUI postTopic;
  const TopicChipWidget({Key? key, required this.postTopic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ColorTheme.novaTheme;
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 8.0),
            child: LMTopicChip(
              topic: postTopic,
              backgroundColor: theme.colorScheme.primary,
              borderRadius: 43,
              height: 30,
              textStyle: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

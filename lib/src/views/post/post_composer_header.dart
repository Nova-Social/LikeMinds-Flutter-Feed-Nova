import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/ui_constants.dart';
import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';

class PostComposerHeader extends StatelessWidget {
  final LMTextView title;
  final Function onTap;
  final Function? onPressedBack;
  final LMTextView? actionText;
  final bool active;

  const PostComposerHeader({
    Key? key,
    required this.title,
    this.onPressedBack,
    required this.onTap,
    this.actionText,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ColorTheme.novaTheme;
    return SizedBox(
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LMIconButton(
              icon: LMIcon(
                type: LMIconType.icon,
                icon: CupertinoIcons.xmark,
                color: theme.colorScheme.onPrimary,
              ),
              onTap: onPressedBack == null
                  ? (bool value) {
                      Navigator.pop(context);
                    }
                  : (bool value) => onPressedBack!(),
            ),
            const Spacer(),
            title,
            const Spacer(),
            LMTextButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 4.0),
              text: actionText ??
                  LMTextView(
                    text: "Post",
                    textStyle: theme.textTheme.bodyMedium,
                  ),
              borderRadius: 6,
              backgroundColor: active
                  ? ColorTheme.novaTheme.primaryColor
                  : ColorTheme.darkBlack300,
              onTap: () => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}

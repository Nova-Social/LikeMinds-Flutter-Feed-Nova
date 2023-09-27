import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:likeminds_feed_nova_fl/likeminds_feed_nova_fl.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/assets_constants.dart';
import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';
import 'package:likeminds_feed_nova_fl/src/utils/post/post_action_id.dart';

Future loadSvgIntoCache() async {
  for (String assetPath in svgAssets) {
    SvgAssetLoader loader = SvgAssetLoader(assetPath);
    svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}

LMIcon getIconFromDropDownItemId(int id, double size, Color color) {
  switch (id) {
    case postDeleteId || commentDeleteId:
      return LMIcon(
        type: LMIconType.svg,
        assetPath: kAssetDeleteIcon,
        color: ColorTheme.redColor,
        size: size,
      );
    case postEditId || commentEditId:
      return LMIcon(
        type: LMIconType.svg,
        assetPath: kAssetEditIcon,
        color: color,
        size: size,
      );
    case postPinId || postUnpinId:
      return LMIcon(
        type: LMIconType.svg,
        assetPath: kAssetPinIcon,
        color: color,
        size: size,
      );
    case postReportId || commentReportId:
      return LMIcon(
        type: LMIconType.svg,
        assetPath: kAssetReportIcon,
        color: color,
        size: size,
      );
    default:
      throw 'Invalid id passed';
  }
}

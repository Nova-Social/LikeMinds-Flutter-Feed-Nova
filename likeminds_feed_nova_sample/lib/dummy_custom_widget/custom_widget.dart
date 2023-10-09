import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:likeminds_feed_nova_sample/dummy_custom_widget/topic_dummy_widget.dart';
import 'package:likeminds_feed_nova_sample/dummy_custom_widget/user_connection.dart';

Map<int, Widget> customWidgets(Size screenSize) => {
      10: getDummyUserConnectionwidget(screenSize.width),
      15: getTopicDummyWidet(screenSize.width),
    };

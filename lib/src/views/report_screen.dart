import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:likeminds_feed/likeminds_feed.dart';
import 'package:likeminds_feed_nova_fl/likeminds_feed_nova_fl.dart';
import 'package:likeminds_feed_nova_fl/src/services/likeminds_service.dart';
import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';

class ReportScreen extends StatefulWidget {
  final GetDeleteReasonRequest request;

  const ReportScreen({Key? key, required this.request}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Future<GetDeleteReasonResponse>? getReportTagsFuture;
  Set<int> selectedTags = {};

  @override
  void initState() {
    // TODO: implement initState
    GetDeleteReasonRequest request = widget.request;
    super.initState();
    getReportTagsFuture = locator<LikeMindsService>().getReportTags(request);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Report',
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 22),
        ),
        leading: LMIconButton(
          icon: LMIcon(
            type: LMIconType.icon,
            size: 24,
            icon: CupertinoIcons.xmark,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          onTap: (value) {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    kVerticalPaddingLarge,
                    kVerticalPaddingLarge,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: LMTextView(
                        text:
                            'Thank you for looking out for yourself and your fellow Nova users by reporting that violet the rules. Let us know what’s happening, and we’ll look into it.',
                        textStyle: theme.textTheme.labelMedium,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    kVerticalPaddingLarge,
                    kVerticalPaddingMedium,
                    FutureBuilder<GetDeleteReasonResponse>(
                        future: getReportTagsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data!.success == true) {
                            return Wrap(
                                spacing: 12.0,
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: snapshot.data!.reportTags != null &&
                                        snapshot.data!.reportTags!.isNotEmpty
                                    ? snapshot.data!.reportTags!
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  if (selectedTags
                                                      .contains(e.id)) {
                                                    selectedTags.remove(e.id);
                                                  } else {
                                                    selectedTags = {e.id};
                                                  }
                                                },
                                              );
                                            },
                                            child: Chip(
                                              label: LMTextView(
                                                text: e.name,
                                                textStyle: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                  color: selectedTags
                                                          .contains(e.id)
                                                      ? theme
                                                          .colorScheme.primary
                                                      : theme.colorScheme
                                                          .onPrimaryContainer,
                                                ),
                                              ),
                                              backgroundColor: selectedTags
                                                      .contains(e.id)
                                                  ? theme.colorScheme.primary
                                                      .withOpacity(0.2)
                                                  : theme.colorScheme.surface,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                  color: selectedTags
                                                          .contains(e.id)
                                                      ? theme
                                                          .colorScheme.primary
                                                      : Colors.transparent,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              labelPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        )
                                        .toList()
                                    : []);
                          } else {
                            return const SizedBox();
                          }
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: LMTextButton(
                height: 56,
                backgroundColor: selectedTags.isEmpty
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : theme.colorScheme.primary,
                borderRadius: 12,
                text: LMTextView(
                  text: 'Submit',
                  textStyle: theme.textTheme.bodyLarge,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

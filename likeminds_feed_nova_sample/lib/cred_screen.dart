import 'dart:async';

import 'package:likeminds_feed_nova_fl/likeminds_feed_nova_fl.dart';
import 'package:likeminds_feed_nova_sample/credentials/credentials.dart';
import 'package:likeminds_feed_nova_sample/dummy_custom_widget/custom_widget.dart';
import 'package:likeminds_feed_nova_sample/likeminds_callback.dart';
import 'package:likeminds_feed_nova_sample/main.dart';
import 'package:likeminds_feed_nova_sample/network_handling.dart';
import 'package:flutter/material.dart';
import 'package:likeminds_feed_nova_sample/user_local_preference.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uni_links/uni_links.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(
        background: Colors.black,
        textColor: Colors.white,
        alignment: Alignment.bottomCenter,
      ),
      child: MaterialApp(
        title: 'Integration App for UI + SDK package',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        theme: ColorTheme.novaTheme,
        home: const CredScreen(),
      ),
    );
  }
}

class CredScreen extends StatefulWidget {
  const CredScreen({super.key});

  @override
  State<CredScreen> createState() => _CredScreenState();
}

class _CredScreenState extends State<CredScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  LMFeed? lmFeed;
  String? userId;

  @override
  void initState() {
    super.initState();
    NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
    networkConnectivity.initialise();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _userIdController.dispose();
    super.dispose();
  }s

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    // return lmFeed;
    userId = SampleUserLocalPreference.instance.fetchUserId();
    // If the local prefs have user id stored
    // Login using that user Id
    // otherwise show the cred screen for login
    if (userId != null && userId!.isNotEmpty) {
      return lmFeed = LMFeed.instance(
          userId: userId,
          userName: 'Test User',
          callback: LikeMindsCallback(),
          apiKey: "",
          customWidgets: customWidgets(screenSize));
    } else {
      return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 72),
              Text(
                "LikeMinds Feed\nSample App",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 64),
              Text(
                "Enter your credentials",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
              TextField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                controller: _usernameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Username',
                  labelStyle: theme.textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                cursorColor: Colors.white,
                controller: _userIdController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'User ID',
                  labelStyle: theme.textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 36),
              GestureDetector(
                onTap: () {
                  lmFeed = LMFeed.instance(
                      userId: _userIdController.text,
                      userName: _usernameController.text,
                      callback: LikeMindsCallback(),
                      apiKey: "",
                      customWidgets: customWidgets(screenSize));

                  if (_userIdController.text.isNotEmpty) {
                    SampleUserLocalPreference.instance
                        .storeUserId(_userIdController.text);
                  }
                  MaterialPageRoute route = MaterialPageRoute(
                    // INIT - Get the LMFeed instance and pass the credentials (if any)
                    builder: (context) => lmFeed!,
                  );
                  Navigator.of(context).pushReplacement(route);
                },
                child: Container(
                  width: 200,
                  height: 42,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text("Submit", style: theme.textTheme.bodyMedium)),
                ),
              ),
              const SizedBox(height: 72),
              SizedBox(
                child: Text(
                  "If no credentials are provided, the app will run with the default credentials of Bot user in your community",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

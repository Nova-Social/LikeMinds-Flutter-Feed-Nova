import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likeminds_feed_nova_fl/likeminds_feed_nova_fl.dart';
import 'package:likeminds_feed_nova_sample/user_local_preference.dart';
import 'package:likeminds_feed/likeminds_feed.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  CompanyUI dummyCompany = CompanyUI(
    id: "123456789",
    name: "Apple",
    imageUrl:
        "https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png?202208080158",
    description:
        "Discover the innovative world of Apple and shop everything iPhone, iPad, Apple Watch, Mac, and Apple TV, plus explore accessories, entertainment and expert",
  );

  @override
  void initState() {
    super.initState();
    // TODO Nova: Replace with your own Company Object
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Company Profile'),
        backgroundColor: ColorTheme.backgroundColor,
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
            backgroundColor: ColorTheme.primaryColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPostScreen(
                    company: dummyCompany,
                  ),
                ),
              );
            }),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),

          SliverToBoxAdapter(
            child: Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(dummyCompany.imageUrl),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  dummyCompany.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'Gantari',
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.lightWhite300,
                  ),
                ),
              ),
            ),
          ),

          // User Description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                dummyCompany.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorTheme.lightWhite300,
                  fontFamily: 'Gantari',
                ),
              ),
            ),
          ),
          CompanyFeedWidget(
            companyId: dummyCompany.id,
          ),
        ],
      ),
    );
  }
}

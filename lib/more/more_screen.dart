import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../all_utilities.dart';

class MoreScreen extends StatefulWidget {
  static const String routeName = "/moreScreen";

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();

    Prefs.instance.canShowGameScreenTourGuide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppTheme.kDirtyPurple),
        title: Text(Strings.more),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text(Strings.privacy_policy),
                  leading: Icon(Icons.security, color: AppTheme.kDirtyPurple),
                  onTap: _privacyPolicy,
                ),
                ListTile(
                  title: Text('Rate Us'),
                  leading: Icon(Icons.stars, color: AppTheme.kDirtyPurple),
                  onTap: _rateUs,
                ),
                ListTile(
                  title: Text('Share'),
                  leading: Icon(Icons.share, color: AppTheme.kDirtyPurple),
                  onTap: _share,
                ),
                ListTile(
                  title: Text('More Apps'),
                  leading: Icon(Icons.widgets, color: AppTheme.kDirtyPurple),
                  onTap: _moreApps,
                ),
                ListTile(
                  title: Text('Contact Us'),
                  leading: Icon(Icons.email, color: AppTheme.kDirtyPurple),
                  onTap: _mailTo,
                ),
                ListTile(
                  title: Text('About'),
                  leading:
                      Icon(Icons.info_outline, color: AppTheme.kDirtyPurple),
                  onTap: _showAboutDialog,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // _addWallpapers() =>
  //     Navigator.pushNamed(context, AddWallpaperScreen.routeName);

  _showAboutDialog() {
    AnalyticsManager.instance.logEvent('clicked_about_dialog');

    showAboutDialog(
        context: context,
        applicationName: AppInfo.instance.appName,
        applicationIcon:
            Image.asset('assets/images/welcome/sp_logo.png', width: 50),
        applicationVersion: 'version ' + AppInfo.instance.versionAndBuild,
        children: [
          Text(
              'Our game is an addictive flirting app with awesome levels. Don\'t forget to Rate-Us.\nIf you have any suggestions feel free to click on Contact Us button'),
        ]);
  }

  _mailTo() {
    AnalyticsManager.instance.logEvent('clicked_contact');

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'nalitt.apps@gmail.com',
        queryParameters: {'subject': AppInfo.instance.appName});

    _launchURL(_emailLaunchUri.toString());
  }

  _share() {
    AnalyticsManager.instance.logEvent('clicked_share');

    Share.share(
        'Hey there check out the best ${AppInfo.instance.appName}:          ' +
            'iOS: itms-apps://itunes.apple.com/app/apple-store/id${Strings.appStoreID}?mt=8           ' +
            '  Android: https://play.google.com/store/apps/details?id=${AppInfo.instance.packageName}',
        subject: AppInfo.instance.appName);
  }

  _rateUs() {
    AnalyticsManager.instance.logEvent('clicked_more_screen_rate_us');

    inAppReview.openStoreListing(appStoreId: Strings.appStoreID);
  }

  _moreApps() async {
    AnalyticsManager.instance.logEvent('clicked_more_apps');

    _launchURL(Platform.isIOS
        ? 'https://apps.apple.com/us/developer/' + Strings.iTunes_more_apps_link
        : 'market://search?q=pub:' + Strings.android_developer_name);
  }

  _privacyPolicy() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => PrivacyPolicyScreen()));

  _launchURL(String url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      _showDialog(
          'Failed', 'Failed to launch. Please check your internet connection');
    }
  }

  _showDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          content: Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import '../all_utilities.dart';
import '../services/ad_manager.dart';

class BannerAdvertisement extends StatefulWidget {
  static const BANNER_SIZE_USED = AdSize.banner;

  final double anchorTypeMargin;
  final AnchorType anchorType;
  BannerAdvertisement(
      {this.anchorType = AnchorType.bottom, this.anchorTypeMargin = 0});

  @override
  _BannerAdvertisementState createState() => _BannerAdvertisementState();
}

class _BannerAdvertisementState extends State<BannerAdvertisement> {
  BannerAd _bannerAd;
  bool _isReady = false;

  static bool get canDisplayBanner => true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: canDisplayBanner
          ? BannerAdvertisement.BANNER_SIZE_USED.height.toDouble()
          : 0,
    );
  }

  @override
  void initState() {
    if (canDisplayBanner) {
      _bannerAd = BannerAd(
        adUnitId: AdManager.bannerAdUnitId,
        size: BannerAdvertisement.BANNER_SIZE_USED,
        targetingInfo: AdManager.targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            setState(() => _isReady = true);
            _bannerAd?.show(
                anchorOffset: widget.anchorTypeMargin,
                anchorType: widget.anchorType);
          } else if (event == MobileAdEvent.failedToLoad) {
            print('ADMOB BANNER: failedToLoad');
          }
        },
      );

      _bannerAd?.load();
    }

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;

    super.dispose();
  }
}

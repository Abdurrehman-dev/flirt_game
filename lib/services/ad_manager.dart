import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_admob/firebase_admob.dart';

import '../all_utilities.dart';

class AdManager {
  // Singleton instance code
  static final AdManager _instance = AdManager._();
  static AdManager get instance => _instance;
  AdManager._();

  static Future<void> initAdManager() async {
    FirebaseAdMob.instance.initialize(appId: AdManager._appId);
    await FacebookAudienceNetwork.init(
      testingId:
          "75792c0b6f3fb93524bfab6baf9f9d58", // honor 8c Abdur Rehman Phone
    );
  }

  // TODO: comment its contents or empty it
  static String get facebookTesting => 'IMG_16_9_APP_INSTALL#';

  static String get _appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4423898417866629~2495310365";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4423898417866629~8290562527";
    } else {
      return "Unsupported platform";
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4423898417866629/4007987990";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4423898417866629/5664399183";
    } else {
      return "Unsupported platform";
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4423898417866629/6981350280";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4423898417866629/6785909160";
    } else {
      return "Unsupported platform";
    }
  }

  static String get facebookNativeAdPlacementId {
    if (Platform.isAndroid) {
      return "${facebookTesting}2839353962983671_2839447656307635";
    } else if (Platform.isIOS) {
      return "${facebookTesting}2839353962983671_2839446726307728";
    } else {
      return "Unsupported platform";
    }
  }

  static String get facebookNativeBannerAdPlacementId {
    if (Platform.isAndroid) {
      return "${facebookTesting}2839353962983671_2839447869640947";
    } else if (Platform.isIOS) {
      return "${facebookTesting}2839353962983671_2839445522974515";
    } else {
      return "Unsupported platform";
    }
  }

  static String get facebookInterstitialAdPlacementId {
    if (Platform.isAndroid) {
      return "${facebookTesting}2839353962983671_2839448022974265";
    } else if (Platform.isIOS) {
      return "${facebookTesting}2839353962983671_2839446916307709";
    } else {
      return "Unsupported Platform";
    }
  }

  static FacebookNativeAd getFacebookAd(NativeAdType adType,
      {double height, Function(NativeAdResult, dynamic) listener}) {
    final adTypePlacementID = adType == NativeAdType.NATIVE_BANNER_AD
        ? AdManager.facebookNativeBannerAdPlacementId
        : AdManager.facebookNativeAdPlacementId;

    return FacebookNativeAd(
      placementId: adTypePlacementID,
      adType: adType,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      height: height ?? 100,
      backgroundColor: AppTheme.primary,
      titleColor: AppTheme.primary,
      descriptionColor: AppTheme.kDirtyPurple,
      buttonColor: AppTheme.primary,
      buttonTitleColor: AppTheme.kDirtyPurple,
      keepExpandedWhileLoading: false,
      expandAnimationDuraion: 200,
      listener: (result, value) {
        listener?.call(result, value);
      },
    );
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: <String>[
        '75FD9557226308357210C0CBE80AEBFD', // adeel bhai tablet
        'F11A4F2CCD0BB447FC573BF58881166E', // adeel bhai oppo phone
        '12C7EC57A67C1E1DA69AB81FACB3CA86', // zahid nokia 6.1
        '00008030-00163022226A802E',
        '75792c0b6f3fb93524bfab6baf9f9d58', // hanzla's iPhone
        '072D2F3992EF5B4493042ADC632CE39F', // Mi Phone
        '0CAE94DF62B6C62D8EA6D89448803B48' // Abd Phone
      ],
      nonPersonalizedAds: true,
      childDirected: true,
      keywords: <String>[
        'Love',
        'Chat',
        'couple',
        'Flirt',
        'Kiss',
        'Wedding',
        'date',
      ]);

  // Interstitial Ad Logic
  InterstitialAd _admobInterstitialAd;
  bool _isAdmobInterstitialAdReady = false;
  bool _isFacebookInterstitialAdReady = false;
  Function _onInterstitialClosed;
  int _count = 0;

  _initAdmobInterstitialAd() {
    _isAdmobInterstitialAdReady = false;

    _admobInterstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      targetingInfo: targetingInfo,
      listener: _onInterstitialAdEvent,
    );
  }

  _loadFacebookInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: facebookInterstitialAdPlacementId,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          _isFacebookInterstitialAdReady = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _onInterstitialClosed?.call();

          _isFacebookInterstitialAdReady = false;
          _loadFacebookInterstitialAd();
        }

        if (result == InterstitialAdResult.ERROR)
          _isFacebookInterstitialAdReady = false;
      },
    );
  }

  loadInterstitial() {
    if (_admobInterstitialAd == null) _initAdmobInterstitialAd();

    if (!_isAdmobInterstitialAdReady) {
      _admobInterstitialAd.load();
    }

    if (!_isFacebookInterstitialAdReady) {
      _loadFacebookInterstitialAd();
    }
  }

  bool _showOrLoadFacebookAd(Function onInterstitialClosed) {
    if (_isFacebookInterstitialAdReady) {
      this._onInterstitialClosed = onInterstitialClosed;
      FacebookInterstitialAd.showInterstitialAd();
      return true;
    }

    _loadFacebookInterstitialAd();
    return false;
  }

  bool _showOrLoadAdmobAd(Function onInterstitialClosed) {
    if (_isAdmobInterstitialAdReady) {
      _admobInterstitialAd.show();
      this._onInterstitialClosed = onInterstitialClosed;
      return true;
    }

    loadInterstitial();
    return false;
  }

  bool showInterstitial({Function onInterstitialClosed}) {
    bool isAdFilled = false;
    if (Random().nextInt(2) == 0) {
      isAdFilled = _showOrLoadFacebookAd(onInterstitialClosed);
    }

    if (!isAdFilled) {
      isAdFilled = _showOrLoadAdmobAd(onInterstitialClosed);
    }

    return isAdFilled;
  }

  showCountedInterstitial() {
    _count++;
    if (_count == 5) {
      showInterstitial();
      _count = 0;
    } else {
      loadInterstitial();
    }
  }

  _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        print('interstitial ad loaded');
        _isAdmobInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isAdmobInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        _onInterstitialClosed?.call();

        _admobInterstitialAd = null;
        Timer(Duration(seconds: 1), loadInterstitial);
        break;
      default:
      // do nothing
    }
  }

// END - Interstitial Ad Logic
}

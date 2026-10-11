// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/AG.jpg
  AssetGenImage get ag => const AssetGenImage('assets/images/AG.jpg');

  /// File path: assets/images/AS.jpg
  AssetGenImage get as => const AssetGenImage('assets/images/AS.jpg');

  /// File path: assets/images/BackSearch.png
  AssetGenImage get backSearch =>
      const AssetGenImage('assets/images/BackSearch.png');

  /// File path: assets/images/Background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/Background.png');

  /// File path: assets/images/FR.jpg
  AssetGenImage get fr => const AssetGenImage('assets/images/FR.jpg');

  /// File path: assets/images/Logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/Logo.png');

  /// File path: assets/images/MA.jpg
  AssetGenImage get ma => const AssetGenImage('assets/images/MA.jpg');

  /// File path: assets/images/Qibla.png
  AssetGenImage get qibla => const AssetGenImage('assets/images/Qibla.png');

  /// File path: assets/images/SR.jpg
  AssetGenImage get sr => const AssetGenImage('assets/images/SR.jpg');

  /// File path: assets/images/ZH.jpg
  AssetGenImage get zh => const AssetGenImage('assets/images/ZH.jpg');

  /// File path: assets/images/isha.jpg
  AssetGenImage get isha => const AssetGenImage('assets/images/isha.jpg');

  /// File path: assets/images/logo_round.png
  AssetGenImage get logoRound =>
      const AssetGenImage('assets/images/logo_round.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        ag,
        as,
        backSearch,
        background,
        fr,
        logo,
        ma,
        qibla,
        sr,
        zh,
        isha,
        logoRound
      ];
}

class $AssetsLocaldbGen {
  const $AssetsLocaldbGen();

  /// File path: assets/localdb/azkar.json
  String get azkar => 'assets/localdb/azkar.json';

  /// List of all assets
  List<String> get values => [azkar];
}

class $AssetsMusicGen {
  const $AssetsMusicGen();

  /// File path: assets/music/click.wav
  String get click => 'assets/music/click.wav';

  /// List of all assets
  List<String> get values => [click];
}

abstract final class Assets {
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLocaldbGen localdb = $AssetsLocaldbGen();
  static const $AssetsMusicGen music = $AssetsMusicGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

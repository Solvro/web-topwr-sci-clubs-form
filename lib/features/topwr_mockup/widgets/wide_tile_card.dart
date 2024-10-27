import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../config/ui_config.dart";
import "../features/sci_clubs_tab/widgets/ensure_visible_tags.dart";
import "my_cached_image.dart";

class PhotoTrailingWideTileCard extends WideTileCard {
  PhotoTrailingWideTileCard({
    String? photoUrl,
    required super.title,
    super.subtitle,
    super.onTap,
    super.isActive,
    super.activeGradient,
    super.activeShadows,
    super.key,
  }) : super(
          trailing: SizedBox.square(
            dimension: WideTileCardConfig.imageSize,
            child: MyCachedImage(photoUrl),
          ),
        );
}

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    required this.title,
    this.subtitle = "",
    this.trailing,
    this.onTap,
    this.activeGradient,
    this.isActive = false,
    this.activeShadows = WideTileCardConfig.defaultActiveShadows,
    this.secondSubtitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    super.key,
    this.showBadge = false,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final String? secondSubtitle;

  final bool isActive;

  final VoidCallback? onTap;

  final List<BoxShadow>? activeShadows;
  final LinearGradient? activeGradient;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showBadge;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              gradient: isActive ? activeGradient : null,
              color: context.colorTheme.greyLight,
              borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
              boxShadow: isActive ? activeShadows : null,
            ),
            child: Row(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Expanded(
                  child: _TitlesColumn(
                    title,
                    subtitle,
                    secondSubtitle,
                    showBadge: showBadge,
                    isActive: isActive,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitlesColumn extends StatelessWidget {
  const _TitlesColumn(
    this.title,
    this.subtitle,
    this.secondSubtitle, {
    required this.isActive,
    this.showBadge = false,
  });

  final String title;
  final String? subtitle;
  final String? secondSubtitle;
  final bool isActive;
  final bool showBadge;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const basePadding = WideTileCardConfig.basePadding;

        return Padding(
          padding: const EdgeInsets.only(
            left: basePadding,
            top: basePadding,
            right: basePadding,
          ),
          child: EnsureVisibleTags(
            title: title,
            titleStyle: isActive
                ? context.textTheme.titleWhite
                : context.textTheme.title,
            subtitle: subtitle,
            subtitleStyle:
                isActive ? context.textTheme.bodyWhite : context.textTheme.body,
            spacing:
                secondSubtitle == null ? WideTileCardConfig.titlesSpacing : 2,
            secondSubtitle: secondSubtitle,
            secondSubtitleStyle: isActive
                ? context.textTheme.bodyWhite
                : context.textTheme.bodyBlue,
            maxTotalLines: 4,
            badge: showBadge,
          ),
        );
      },
    );
  }
}

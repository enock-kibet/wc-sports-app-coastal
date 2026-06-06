import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/utils/dotted.dart';

class PreviousTiles extends StatelessWidget {
  final MatchType match;
  const PreviousTiles({required this.match, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    // dynamic colors
    final backgroundColor =
        isDark ? colorScheme.surfaceVariant : colorScheme.surface;
    final textColor = colorScheme.onSurface;
    final secondaryTextColor = colorScheme.onSurface.withOpacity(0.7);

    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoute.previousGameRecap.name,
        extra: match,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          children: [
            // date + price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // ← This is the critical fix
                  child: Row(
                    children: [
                      _buildDateBox(match, textColor, isDark),
                      const SizedBox(width: 13),
                      Expanded(
                        // ← Also expand the Column inside
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getStringDate(match.matchDate,
                                  withoutWeekday: true),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: secondaryTextColor,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 7),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 190),
                              child: Text.rich(
                                TextSpan(
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: textColor,
                                    fontSize: 10,
                                  ),
                                  children: [
                                    TextSpan(text: "${match.matchLocation} - "),
                                    TextSpan(
                                      text: match.matchVenue,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Ksh ${match.matchPrice}",
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            const DottedDivider(),
            const SizedBox(height: 11),

            // teams row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _teamRow(
                    match.teamOne,
                    AppColors.defaultAppRed,
                    theme,
                    logoUrl: match.recap?.clubOne.pic,
                  ),
                ),
                SizedBox(
                  width: 76,
                  child: Text(
                    "${match.teamOneScore} - ${match.teamTwoScore}",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: _teamRow(
                    match.teamTwo,
                    AppColors.purpleColor,
                    theme,
                    alignRight: true,
                    logoUrl: match.recap?.clubTwo.pic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? colorScheme.onSurface.withValues(alpha: 0.12)
                      : const Color(0xffefefef),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "View Game Recap",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBox(MatchType match, Color textColor, bool isDark) {
    final darkBoxColor = const Color(0xff2d2d2d);
    final lightBoxColor = const Color(0xffd9d9d9);

    return Column(
      children: [
        Container(
          height: 17,
          width: 33,
          decoration: BoxDecoration(
            color: darkBoxColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            border: Border.all(color: darkBoxColor),
          ),
          child: Center(
            child: Text(
              truncateText(
                monthMap[match.matchDate.month].toString().toTitleCase(),
                limit: 3,
                show: false,
              ),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
        Container(
          height: 17,
          width: 33,
          decoration: BoxDecoration(
            color: lightBoxColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            border: Border.all(color: darkBoxColor),
          ),
          child: Center(
            child: Text(
              match.matchDate.day.toString(),
              style: TextStyle(color: darkBoxColor, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }

  String _getInitials(String team) {
    final parts = team.trim().split(' ').where((p) => p.isNotEmpty).toList();

    if (parts.isEmpty) return '?';

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Widget _teamRow(
    String team,
    Color color,
    ThemeData theme, {
    bool alignRight = false,
    String? logoUrl,
  }) {
    final hasLogo = !showTeamAbbrOnly && logoUrl != null && logoUrl.isNotEmpty;
    final avatar = CircleAvatar(
      backgroundColor: showTeamAbbrOnly ? const Color(0xFFF9D96B) : color,
      radius: 10,
      child: hasLogo
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: logoUrl,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _abbrText(team),
              ),
            )
          : _abbrText(team),
    );
    final name = Flexible(
      child: Text(
        truncateText(team),
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall,
      ),
    );

    return Row(
      mainAxisAlignment:
          alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!alignRight) ...[
          avatar,
          const SizedBox(width: kXSmall),
          name,
        ] else ...[
          name,
          const SizedBox(width: kXSmall),
          avatar,
        ],
      ],
    );
  }

  Widget _abbrText(String team) {
    return Text(
      _getInitials(team),
      style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
    );
  }
}

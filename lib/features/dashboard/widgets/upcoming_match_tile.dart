import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/utils/dotted.dart';

class UpcomingMatchTile extends StatelessWidget {
  const UpcomingMatchTile({
    super.key,
    required this.match,
    required this.onTap,
    required this.onBuyTicketTap,
    this.margin = const EdgeInsets.only(bottom: 14),
    this.buttonLabel = 'Buy Ticket',
  });

  final MatchType match;
  final VoidCallback onTap;
  final VoidCallback onBuyTicketTap;
  final EdgeInsetsGeometry margin;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final hasTicket = match.hasTicket;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? colorScheme.surfaceContainerHighest : colorScheme.surface;
    final textColor = colorScheme.onSurface;
    final secondaryTextColor =
        colorScheme.onSurface.withValues(alpha: isDark ? 0.78 : 0.7);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _DateBox(matchDate: match.matchDate),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _formatMatchDate(match.matchDate),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: secondaryTextColor,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text.rich(
                              TextSpan(
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: textColor,
                                  fontSize: 10,
                                ),
                                children: [
                                  TextSpan(text: '${match.matchLocation} - '),
                                  TextSpan(
                                    text: match.matchVenue,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  hasTicket
                      ? 'Ksh ${match.matchPrice.toStringAsFixed(0)}'
                      : 'Tickets unavailable',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _TeamRow(
                    team: match.teamOne,
                    color: AppColors.defaultAppRed,
                    theme: theme,
                    logoUrl: match.recap?.clubOne.pic,
                  ),
                ),
                SizedBox(
                  width: 76,
                  child: Text(
                    'VS',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: _TeamRow(
                    team: match.teamTwo,
                    color: AppColors.purpleColor,
                    theme: theme,
                    logoUrl: match.recap?.clubTwo.pic,
                    alignRight: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: hasTicket ? onBuyTicketTap : null,
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: hasTicket
                        ? AppColors.primaryColor
                        : colorScheme.onSurface.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      hasTicket ? buttonLabel : 'Ticket Unavailable',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: hasTicket ? textColor : secondaryTextColor,
                      ),
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

  String _formatMatchDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox({required this.matchDate});

  final DateTime matchDate;

  @override
  Widget build(BuildContext context) {
    const darkBoxColor = Color(0xff2d2d2d);
    const lightBoxColor = Color(0xffd9d9d9);

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
              DateFormat('MMM').format(matchDate),
              style: const TextStyle(color: Colors.white, fontSize: 10),
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
              matchDate.day.toString(),
              style: const TextStyle(color: darkBoxColor, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}

class _TeamRow extends StatelessWidget {
  const _TeamRow({
    required this.team,
    required this.color,
    required this.theme,
    this.alignRight = false,
    this.logoUrl,
  });

  final String team;
  final Color color;
  final ThemeData theme;
  final bool alignRight;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final hasLogo = !showTeamAbbrOnly && logoUrl != null && logoUrl!.isNotEmpty;
    final avatar = CircleAvatar(
      backgroundColor: color,
      radius: 10,
      child: hasLogo
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: logoUrl!,
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
      style: const TextStyle(
          fontSize: 8, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }

  String _getInitials(String value) {
    final parts = value.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

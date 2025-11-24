part of '../home_page.dart';

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
    final borderColor =
        isDark ? colorScheme.outlineVariant : const Color(0xffd9d9d9);
    final textColor = colorScheme.onSurface;
    final secondaryTextColor = colorScheme.onSurface.withOpacity(0.7);

    return GestureDetector(
      onTap: () => context.pushNamed(AppRoute.team.name, extra: match),
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
                            Text.rich(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTeamsColumn(match, theme),
                SizedBox(
                  width: 102,
                  child: Text("${match.teamOneScore} - ${match.teamTwoScore}"),
                ),
              ],
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

  Widget _buildTeamsColumn(MatchType match, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _teamRow(match.teamOne, AppColors.defaultAppRed, theme),
        const SizedBox(height: 4),
        _teamRow(match.teamTwo, AppColors.purpleColor, theme),
      ],
    );
  }

  Widget _teamRow(String team, Color color, ThemeData theme) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 10,
          child: Text(
            team.split(' ').first[0].toUpperCase() + team.split(' ').last[0],
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: kXSmall),
        Text(
          truncateText(team),
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

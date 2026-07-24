part of '../home_page.dart';

class ScheduledTiles extends StatelessWidget {
  final MatchType match;
  const ScheduledTiles({required this.match, super.key});

  void _openMatchDetails(BuildContext context) {
    final isGuest = service<AppPreferencesManager>().currentUserValue == null;
    if (isGuest) {
      context.go('/signIn');
      return;
    }
    context.pushNamed(AppRoute.matchDetails.name, extra: match);
  }

  Future<void> _handleBuyTicketTap(BuildContext context) async {
    final isGuest = service<AppPreferencesManager>().currentUserValue == null;
    if (isGuest) {
      context.go('/signIn');
      return;
    }

    final response =
        await service<ProductService>().getPreferredTicketType(match.matchId);
    if (!context.mounted) return;

    response.when(
      onError: (error) {
        SnackbarService.showError(error.error);
      },
      onSuccess: (_) {
        context.pushNamed(AppRoute.matchDetails.name, extra: match);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return UpcomingMatchTile(
      match: match,
      onTap: () => _openMatchDetails(context),
      onBuyTicketTap: () => _handleBuyTicketTap(context),
    );
  }
}

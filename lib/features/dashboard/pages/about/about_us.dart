import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/session/frontend_context.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  late final AppPreferencesManager _prefsManager;
  late final ContextService _contextService;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _prefsManager = service<AppPreferencesManager>();
    _contextService = service<ContextService>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshContext(showError: false);
    });
  }

  Future<void> _refreshContext({bool showError = true}) async {
    if (_isRefreshing) {
      return;
    }

    setState(() => _isRefreshing = true);

    final result = await _contextService.getContext();
    await result.when(
      onError: (error) async {
        if (!mounted || !showError) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.error.isEmpty
                  ? 'Unable to refresh About details right now.'
                  : error.error,
            ),
          ),
        );
      },
      onSuccess: (contextData) async {
        await _prefsManager.saveFrontendContext(contextData);
      },
    );

    if (mounted) {
      setState(() => _isRefreshing = false);
    }
  }

  Future<void> _launchExternalUrl(String rawUrl) async {
    final normalized = rawUrl.trim().isEmpty
        ? ''
        : (rawUrl.startsWith('http://') || rawUrl.startsWith('https://'))
            ? rawUrl
            : 'https://$rawUrl';

    if (normalized.isEmpty) {
      return;
    }

    final uri = Uri.tryParse(normalized);
    if (uri == null) {
      return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FrontendContextData?>(
      stream: _prefsManager.contextStream,
      initialData: _prefsManager.currentContextValue,
      builder: (context, snapshot) {
        final contextData = snapshot.data ?? const FrontendContextData();
        final theme = Theme.of(context);
        final primary = AppColors.fromHex(contextData.brandingPrimaryColor) ??
            AppColors.primaryColor;
        final secondary =
            AppColors.fromHex(contextData.brandingSecondaryColor) ??
                AppColors.purpleColor;
        final accent = AppColors.fromHex(contextData.brandingAccentColor) ??
            AppColors.pinkColor;
        final mutedColor = theme.colorScheme.onSurface.withValues(alpha: 0.68);
        final logoUrl = contextData.resolvedLogoUrl;
        final brandName = contextData.resolvedBrandName;
        final clubName = contextData.activeClubName ?? brandName;
        final leagueName = contextData.activeLeagueName ?? 'Active League';
        final description = contextData.activeClubDescription
                    ?.trim()
                    .isNotEmpty ==
                true
            ? contextData.activeClubDescription!.trim()
            : '$clubName is part of $leagueName. Follow the club for fixtures, highlights, merch, and everything happening around the team.';

        return Scaffold(
          body: AppBackground(
            childWidget: RefreshIndicator(
              onRefresh: _refreshContext,
              child: ListView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + kSmall,
                  bottom: kLarge,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kMedium),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(kXLarge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                              kMedium,
                              kMedium,
                              kMedium,
                              kLarge,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  primary,
                                  secondary,
                                  accent,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const AppBackButton(),
                                    const Spacer(),
                                    if (_isRefreshing)
                                      const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: kLarge),
                                Center(
                                  child: Container(
                                    width: 96,
                                    height: 96,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 98, 44, 44)
                                              .withValues(
                                        alpha: 0.18,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.38,
                                        ),
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: logoUrl.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: logoUrl,
                                              fit: BoxFit.cover,
                                              errorWidget: (_, __, ___) =>
                                                  _LogoFallback(
                                                label: brandName,
                                              ),
                                            )
                                          : _LogoFallback(label: brandName),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: kMedium),
                                Center(
                                  child: Text(
                                    brandName,
                                    textAlign: TextAlign.center,
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: kSmall),
                                Center(
                                  child: Text(
                                    clubName,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.88,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kMedium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Us',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: kSmall),
                                Text(
                                  description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.6,
                                    color: mutedColor,
                                  ),
                                ),
                                const SizedBox(height: kLarge),
                                Wrap(
                                  spacing: kSmall,
                                  runSpacing: kSmall,
                                  children: [
                                    _InfoChip(
                                      icon: Icons.sports_basketball_outlined,
                                      label: contextData.activeLeagueSport ??
                                          'Basketball',
                                    ),
                                    _InfoChip(
                                      icon: Icons.emoji_events_outlined,
                                      label: leagueName,
                                    ),
                                    if ((contextData.activeClubLocation ?? '')
                                        .isNotEmpty)
                                      _InfoChip(
                                        icon: Icons.location_on_outlined,
                                        label: contextData.activeClubLocation!,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: kLarge),
                                _SectionCard(
                                  title: 'Club Details',
                                  child: Column(
                                    children: [
                                      _InfoRow(
                                        icon: Icons.shield_outlined,
                                        label: 'Club',
                                        value: clubName,
                                      ),
                                      _InfoRow(
                                        icon: Icons.emoji_events_outlined,
                                        label: 'League',
                                        value: leagueName,
                                      ),
                                      if ((contextData.activeClubLocation ?? '')
                                          .isNotEmpty)
                                        _InfoRow(
                                          icon: Icons.place_outlined,
                                          label: 'Location',
                                          value:
                                              contextData.activeClubLocation!,
                                        ),
                                      if ((contextData.activeLeagueCountry ??
                                              '')
                                          .isNotEmpty)
                                        _InfoRow(
                                          icon: Icons.public_outlined,
                                          label: 'Country',
                                          value:
                                              contextData.activeLeagueCountry!,
                                        ),
                                      if ((contextData
                                                  .activeClubHeadCoachName ??
                                              '')
                                          .isNotEmpty)
                                        _InfoRow(
                                          icon: Icons.person_outline,
                                          label: 'Head Coach',
                                          value: contextData
                                              .activeClubHeadCoachName!,
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: kMedium),
                                _SectionCard(
                                  title: 'Find Us',
                                  child: Column(
                                    children: [
                                      if ((contextData.activeClubWebsite ?? '')
                                          .isNotEmpty)
                                        _ActionRow(
                                          icon: Icons.language_outlined,
                                          label: 'Website',
                                          value: contextData.activeClubWebsite!,
                                          onTap: () => _launchExternalUrl(
                                            contextData.activeClubWebsite!,
                                          ),
                                        ),
                                      if ((contextData
                                                  .activeClubContactNumber ??
                                              '')
                                          .isNotEmpty)
                                        _InfoRow(
                                          icon: Icons.call_outlined,
                                          label: 'Phone',
                                          value: contextData
                                              .activeClubContactNumber!,
                                        ),
                                      if ((contextData.activeClubEmail ?? '')
                                          .isNotEmpty)
                                        _InfoRow(
                                          icon: Icons.mail_outline,
                                          label: 'Email',
                                          value: contextData.activeClubEmail!,
                                        ),
                                      if ((contextData.activeClubWebsite ?? '')
                                              .isEmpty &&
                                          (contextData.activeClubContactNumber ??
                                                  '')
                                              .isEmpty &&
                                          (contextData.activeClubEmail ?? '')
                                              .isEmpty)
                                        Text(
                                          'No public contact details have been added for this club yet.',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: mutedColor,
                                            height: 1.5,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kMedium),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(kLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: kMedium),
          child,
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : AppColors.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kMedium,
        vertical: kSmall,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: kSmall),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = theme.colorScheme.onSurface.withValues(alpha: 0.68);
    final iconColor = isDark ? Colors.white : AppColors.primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: kMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: kSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: mutedColor,
                  ),
                ),
                const SizedBox(height: kXXSmall),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : AppColors.primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kMedium),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kMedium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: kSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.68),
                        ),
                  ),
                  const SizedBox(height: kXXSmall),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: kSmall),
            Icon(
              Icons.open_in_new,
              size: 16,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final safe = label.trim();
    final initials = safe.isEmpty
        ? 'K'
        : safe
            .split(' ')
            .where((part) => part.isNotEmpty)
            .take(2)
            .map((part) => part[0].toUpperCase())
            .join();

    return Center(
      child: Text(
        initials,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

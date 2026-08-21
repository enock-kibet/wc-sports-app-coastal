import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/services/service.dart';

class TicketDetailPage extends StatefulWidget {
  const TicketDetailPage({
    super.key,
    required this.ticketId,
  });

  final String ticketId;

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  bool _loading = true;
  Failure? _failure;
  Map<String, dynamic>? _ticket;

  @override
  void initState() {
    super.initState();
    _loadTicket();
  }

  Future<void> _loadTicket() async {
    setState(() {
      _loading = true;
      _failure = null;
    });

    Map<String, dynamic>? ticket;
    Failure? failure;

    final result = await service<TicketService>().getTicket(widget.ticketId);
    result.when(
      onError: (error) => failure = error,
      onSuccess: (data) => ticket = data,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _loading = false;
      _failure = failure;
      _ticket = ticket;
    });
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return const <String, dynamic>{};
  }

  String _read(dynamic value, {String fallback = '-'}) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? fallback : text;
  }

  String _formatDate(dynamic rawDate) {
    final value = rawDate?.toString().trim();
    if (value == null || value.isEmpty) {
      return '-';
    }

    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return value;
    }

    return DateFormat('MMM dd, yyyy • hh:mm a').format(parsed.toLocal());
  }

  String? _qrData(Map<String, dynamic> ticket) {
    final payload = _read(ticket['qr_payload'], fallback: '');
    if (payload.isNotEmpty) {
      return payload;
    }

    final publicUrl = _read(ticket['public_ticket_url'], fallback: '');
    if (publicUrl.isNotEmpty) {
      return publicUrl;
    }

    final token = _read(ticket['qr_token'], fallback: '');
    if (token.isNotEmpty) {
      return token;
    }

    return null;
  }

  Widget _qrCard(BuildContext context, Map<String, dynamic> ticket) {
    final qrData = _qrData(ticket);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kLarge),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(kMedium),
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Scan At Entry',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: kXSmall),
          Text(
            'Present this QR code at the gate for validation.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: kLarge),
          Container(
            padding: const EdgeInsets.all(kMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kMedium),
            ),
            child: qrData == null
                ? Icon(
                    Icons.qr_code_2_rounded,
                    size: 164,
                    color: colorScheme.onSurface.withValues(alpha: 0.3),
                  )
                : QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 164,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
          ),
          const SizedBox(height: kMedium),
          Text(
            _read(ticket['ticket_number']),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (qrData == null) ...[
            const SizedBox(height: kSmall),
            Text(
              'QR code is not available for this ticket yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoTile(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSmall),
      child: Container(
        padding: const EdgeInsets.all(kMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(kMedium),
          border: Border.all(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ticket = _ticket ?? const <String, dynamic>{};
    final match = _asMap(ticket['match']);
    final homeClub = _asMap(match['home_club']);
    final awayClub = _asMap(match['away_club']);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadTicket,
          child: ListView(
            padding: const EdgeInsets.all(kMedium),
            children: [
              Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: kSmall),
                  Text(
                    'Ticket Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kLarge),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.only(top: kXXLarge),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_failure != null)
                Center(child: Text(_failure!.error))
              else ...[
                _qrCard(context, ticket),
                const SizedBox(height: kMedium),
                _infoTile(
                    context, 'Ticket Number', _read(ticket['ticket_number'])),
                _infoTile(
                  context,
                  'Status',
                  _read(ticket['status']).replaceAll('_', ' '),
                ),
                _infoTile(context, 'Holder', _read(ticket['holder_name'])),
                _infoTile(context, 'Email', _read(ticket['holder_email'])),
                _infoTile(
                  context,
                  'Issued At',
                  _formatDate(ticket['issued_at']),
                ),
                // _infoTile(
                //   context,
                //   'Public Ticket URL',
                //   _read(ticket['public_ticket_url']),
                // ),
                _infoTile(context, 'QR Token', _read(ticket['qr_token'])),
                _infoTile(
                  context,
                  'Match',
                  '${_read(homeClub['name'])} vs ${_read(awayClub['name'])}',
                ),
                _infoTile(
                    context, 'Kickoff', _formatDate(match['scheduled_at'])),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

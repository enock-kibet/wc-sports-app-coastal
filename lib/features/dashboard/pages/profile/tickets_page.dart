import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  bool _loading = true;
  Failure? _failure;
  TicketSummaryData _summary = const TicketSummaryData(
    total: 0,
    issued: 0,
    used: 0,
    upcoming: 0,
  );
  List<Map<String, dynamic>> _tickets = const [];
  List<Map<String, dynamic>> _orders = const [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _failure = null;
    });

    TicketSummaryData summary = _summary;
    List<Map<String, dynamic>> tickets = _tickets;
    List<Map<String, dynamic>> orders = _orders;
    Failure? failure;

    final summaryResult = await service<TicketService>().getTicketSummary();
    summaryResult.when(
      onError: (error) => failure ??= error,
      onSuccess: (data) => summary = data,
    );

    final ticketsResult = await service<TicketService>().getTickets(
      upcomingOnly: true,
      perPage: 8,
    );
    ticketsResult.when(
      onError: (error) => failure ??= error,
      onSuccess: (data) => tickets = data,
    );

    final ordersResult = await service<OrderService>().getOrders(
      perPage: 6,
    );
    ordersResult.when(
      onError: (error) => failure ??= error,
      onSuccess: (data) => orders = data,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _loading = false;
      _failure = failure;
      _summary = summary;
      _tickets = tickets;
      _orders = orders;
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

  String _formatCurrency(dynamic amount) {
    final parsed = amount is num
        ? amount.toDouble()
        : double.tryParse(amount?.toString() ?? '') ?? 0;
    final formatter = NumberFormat.currency(
      symbol: 'Ksh ',
      decimalDigits: 0,
    );
    return formatter.format(parsed);
  }

  Color _statusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'issued':
      case 'upcoming':
        return Colors.green;
      case 'pending':
      case 'pending_payment':
      case 'unpaid':
        return Colors.orange;
      case 'used':
        return AppColors.defaultAppPurple;
      default:
        return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    }
  }

  Widget _summaryCard(
    BuildContext context, {
    required String label,
    required int value,
  }) {
    return Container(
      padding: const EdgeInsets.all(kMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(kMedium),
        border: Border.all(
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: kXXSmall),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _emptyCard(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(kMedium),
        border: Border.all(
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _ticketCard(BuildContext context, Map<String, dynamic> ticket) {
    final match = _asMap(ticket['match']);
    final status = (ticket['status'] ?? 'unknown').toString();
    final title =
        (match['name'] ?? ticket['ticket_number'] ?? 'Ticket').toString();
    final subtitle =
        (ticket['ticket_number'] ?? ticket['holder_name'] ?? '').toString();

    return InkWell(
      onTap: () {
        final ticketId = _read(ticket['id'], fallback: '');
        if (ticketId.isNotEmpty) {
          context.pushNamed(
            AppRoute.profileTicketDetails.name,
            pathParameters: {'ticketId': ticketId},
            extra: ticketId,
          );
        }
      },
      borderRadius: BorderRadius.circular(kMedium),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: kSmall),
        padding: const EdgeInsets.all(kMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(kMedium),
          border: Border.all(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSmall,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _statusColor(context, status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    status.replaceAll('_', ' '),
                    style: TextStyle(
                      color: _statusColor(context, status),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: kXXSmall),
              Text(
                subtitle,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
            const SizedBox(height: kSmall),
            Text(
              'Kickoff: ${_formatDate(match['kickoff_at'])}',
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Issued: ${_formatDate(ticket['issued_at'])}',
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderCard(BuildContext context, Map<String, dynamic> order) {
    final orderNumber = (order['order_number'] ?? 'Order').toString();
    final status = (order['status'] ?? 'unknown').toString();
    final paymentStatus = (order['payment_status'] ?? '').toString();

    return InkWell(
      onTap: () {
        final orderId = _read(order['id'], fallback: '');
        if (orderId.isNotEmpty) {
          context.pushNamed(
            AppRoute.profileOrderDetails.name,
            pathParameters: {'orderId': orderId},
            extra: orderId,
          );
        }
      },
      borderRadius: BorderRadius.circular(kMedium),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: kSmall),
        padding: const EdgeInsets.all(kMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(kMedium),
          border: Border.all(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    orderNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  _formatCurrency(order['total_amount']),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kXXSmall),
            Text(
              'Status: ${status.replaceAll('_', ' ')}',
              style: TextStyle(
                color: _statusColor(context, status),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (paymentStatus.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Payment: ${paymentStatus.replaceAll('_', ' ')}',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
            const SizedBox(height: 4),
            Text(
              'Placed: ${_formatDate(order['placed_at'])}',
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: ListView(
            padding: const EdgeInsets.all(kMedium),
            children: [
              Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: kSmall),
                  Text(
                    'My Tickets',
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
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else ...[
                if (_failure != null && _tickets.isEmpty && _orders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: kLarge),
                    child: _emptyCard(context, _failure!.error),
                  ),
                _sectionTitle(context, 'Ticket Summary'),
                const SizedBox(height: kSmall),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: kSmall,
                  crossAxisSpacing: kSmall,
                  childAspectRatio: 1.4,
                  children: [
                    _summaryCard(context,
                        label: 'Total', value: _summary.total),
                    _summaryCard(context,
                        label: 'Issued', value: _summary.issued),
                    _summaryCard(context, label: 'Used', value: _summary.used),
                    _summaryCard(context,
                        label: 'Upcoming', value: _summary.upcoming),
                  ],
                ),
                const SizedBox(height: kLarge),
                _sectionTitle(context, 'Upcoming Tickets'),
                const SizedBox(height: kSmall),
                if (_tickets.isEmpty)
                  _emptyCard(context, 'No upcoming tickets yet.')
                else
                  ..._tickets.map((ticket) => _ticketCard(context, ticket)),
                const SizedBox(height: kLarge),
                _sectionTitle(context, 'Recent Orders'),
                const SizedBox(height: kSmall),
                if (_orders.isEmpty)
                  _emptyCard(context, 'No recent orders found.')
                else
                  ..._orders.map((order) => _orderCard(context, order)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

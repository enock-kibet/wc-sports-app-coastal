import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/services/service.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool _loading = true;
  Failure? _failure;
  Map<String, dynamic>? _order;

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    setState(() {
      _loading = true;
      _failure = null;
    });

    Map<String, dynamic>? order;
    Failure? failure;

    final result = await service<OrderService>().getOrder(widget.orderId);
    result.when(
      onError: (error) => failure = error,
      onSuccess: (data) => order = data,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _loading = false;
      _failure = failure;
      _order = order;
    });
  }

  List<Map<String, dynamic>> _asList(dynamic value) {
    if (value is List) {
      return value.whereType<Map>().map(Map<String, dynamic>.from).toList();
    }
    return const [];
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
    final order = _order ?? const <String, dynamic>{};
    final items = _asList(order['items']);
    final appliedPromotion = order['applied_promotion'] is Map
        ? Map<String, dynamic>.from(order['applied_promotion'] as Map)
        : const <String, dynamic>{};
    final pointsRedemption = order['points_redemption'] is Map
        ? Map<String, dynamic>.from(order['points_redemption'] as Map)
        : const <String, dynamic>{};
    final discountAmount = order['discount_amount'] is num
        ? (order['discount_amount'] as num).toDouble()
        : double.tryParse(order['discount_amount']?.toString() ?? '') ?? 0;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadOrder,
          child: ListView(
            padding: const EdgeInsets.all(kMedium),
            children: [
              Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: kSmall),
                  Text(
                    'Order Details',
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
                _infoTile(
                    context, 'Order Number', _read(order['order_number'])),
                _infoTile(context, 'Buyer', _read(order['buyer_name'])),
                _infoTile(context, 'Email', _read(order['buyer_email'])),
                _infoTile(context, 'Phone', _read(order['buyer_phone'])),
                _infoTile(
                  context,
                  'Status',
                  _read(order['status']).replaceAll('_', ' '),
                ),
                _infoTile(
                  context,
                  'Payment',
                  _read(order['payment_status']).replaceAll('_', ' '),
                ),
                _infoTile(
                    context, 'Placed At', _formatDate(order['placed_at'])),
                if (appliedPromotion.isNotEmpty)
                  _infoTile(
                    context,
                    'Promotion',
                    '${_read(appliedPromotion['promotion_code'])} • ${_formatCurrency(appliedPromotion['discount_amount'])}',
                  ),
                if (pointsRedemption.isNotEmpty)
                  _infoTile(
                    context,
                    'Points Used',
                    '${_read(pointsRedemption['applied_points'])} • ${_formatCurrency(pointsRedemption['discount_amount'])}',
                  ),
                if (discountAmount > 0)
                  _infoTile(
                    context,
                    'Discount',
                    _formatCurrency(discountAmount),
                  ),
                _infoTile(
                    context, 'Total', _formatCurrency(order['total_amount'])),
                const SizedBox(height: kMedium),
                Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: kSmall),
                if (items.isEmpty)
                  _infoTile(context, 'Items', 'No order items returned.')
                else
                  ...items.map(
                    (item) => _infoTile(
                      context,
                      _read(item['item_name'] ?? item['name']),
                      '${_formatCurrency(item['total_amount'] ?? item['amount'])} x ${_read(item['quantity'], fallback: '1')}',
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

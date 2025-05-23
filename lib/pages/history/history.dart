import 'package:ferrous/misc/appsizing.dart';
import 'package:ferrous/pages/history/components/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// TODO:  i am not done here, change transaction tile to list tile

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    ///
    final isSmallScreen = AppSizing.width(context) < 600;

    ///
    final List<_Transaction> transactions = [
      _Transaction(
        title: 'Card deposit',
        subtitle: 'Card deposit · 17 January, 2025',
        amount: 100000.00,
        currency: '₦',
        type: TransactionType.deposit,
      ),
      _Transaction(
        title: 'NGN to USD',
        subtitle: 'Swap · 17 January, 2025',
        amount: 100000.00,
        currency: '₦',
        type: TransactionType.swap,
      ),
      _Transaction(
        title: 'OBIAJULU ANIGBOGU MBANEFO',
        subtitle: 'Bank account · 17 January, 2025',
        amount: 100000.00,
        currency: '₦',
        type: TransactionType.account,
      ),
      _Transaction(
        title: 'Card deposit',
        subtitle: 'Card deposit · 12 August, 2024',
        amount: -31.00,
        currency: ' 24',
        type: TransactionType.deposit,
      ),
      _Transaction(
        title: 'NGN to USD',
        subtitle: 'Swap · 12 August, 2024',
        amount: 50000.00,
        currency: '₦',
        type: TransactionType.swap,
      ),
      _Transaction(
        title: 'OBIAJULU ANIGBOGU MBANEFO',
        subtitle: 'Bank account · 12 August, 2024',
        amount: 50000.00,
        currency: '₦',
        type: TransactionType.account,
      ),
      _Transaction(
        title: 'Card deposit',
        subtitle: 'Card deposit · 02 August, 2024',
        amount: -239.00,
        currency: '\$',
        type: TransactionType.deposit,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),

      ///
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 6 : 12,
              vertical: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search here',

                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusColor: Colors.white,
                      // filled: true,
                      // fillColor: Colors.white,
                    ),
                  ),
                ),
                // const SizedBox(width: 12),

                ///
                IconButton(
                  icon: const Icon(
                    Icons.filter_list_rounded,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      enableDrag: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => const FilterModal(),
                    );
                  },
                ),
              ],
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'All Transactions',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),

          // const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 6 : 12,
                // vertical: 6,
              ),
              itemCount: transactions.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Color(0xFFF0F0F0)),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return _TransactionTile(
                  tx: tx,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Transaction {
  final String title;
  final String subtitle;
  final double amount;
  final String currency;
  final TransactionType type;
  _Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.currency,
    required this.type,
  });
}

// out; is red, every other thing is green
enum TransactionType { deposit, swap, account }

class _TransactionTile extends StatelessWidget {
  final _Transaction tx;
  final void Function() onTap;
  const _TransactionTile({required this.tx, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isNegative = tx.amount < 0;
    final amountText =
        '${isNegative ? '-' : (tx.type == TransactionType.account ? '+' : '')}${tx.currency}${NumberFormat('#,##0.00').format(tx.amount.abs())}';
    IconData icon;
    Color iconColor;
    switch (tx.type) {
      case TransactionType.deposit:
        icon = Icons.arrow_downward_rounded;
        iconColor = Colors.green.shade200;
        break;
      case TransactionType.swap:
        icon = Icons.swap_horiz_rounded;
        iconColor = Colors.teal.shade100;
        break;
      case TransactionType.account:
        icon = Icons.arrow_upward_rounded;
        iconColor = Colors.green.shade100;
        break;
    }
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      splashColor: tx.amount < 0
          ? Colors.red.withValues(alpha: 0.1)
          : Colors.green.withValues(alpha: 0.1),
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: iconColor,
        radius: 24,
        child: Icon(
          icon,
          color: Colors.teal,
          size: 28,
        ),
      ),
      title: Text(
        tx.title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        tx.subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Text(
        amountText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: isNegative ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

enum ShareableCardStyle {
  minimal,
  elegant,
  modern,
}

class ShareableQuoteCard extends StatelessWidget {
  final Quote quote;
  final ShareableCardStyle style;

  const ShareableQuoteCard({
    super.key,
    required this.quote,
    this.style = ShareableCardStyle.minimal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400, // Fixed width for consistent image generation
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 600, // Add max height constraint
      ),
      padding: const EdgeInsets.all(16),
      child: _buildCardByStyle(context),
    );
  }

  Widget _buildCardByStyle(BuildContext context) {
    switch (style) {
      case ShareableCardStyle.minimal:
        return _buildMinimalCard(context);
      case ShareableCardStyle.elegant:
        return _buildElegantCard(context);
      case ShareableCardStyle.modern:
        return _buildModernCard(context);
    }
  }

  Widget _buildMinimalCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote icon
            Icon(
              Icons.format_quote,
              size: 40,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            
            const SizedBox(height: 24),
            
            // Quote text
            Flexible(
              child: ThemedText.body(
                '"${quote.text}"',
                fontSize: 20,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Author
            ThemedText.body(
              '— ${quote.author}',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            
            const SizedBox(height: 8),
            
            // Date
            ThemedText.caption(
              _formatDate(quote.createdAt),
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElegantCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.1),
            Theme.of(context).cardColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorative top element
            Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Large quote marks
            Icon(
              Icons.format_quote,
              size: 56,
              color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            ),
            
            const SizedBox(height: 24),
            
            // Quote text
            Flexible(
              child: ThemedText.body(
                quote.text,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                textAlign: TextAlign.center,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Decorative divider
            Container(
              width: 100,
              height: 2,
              color: Theme.of(context).dividerColor,
            ),
            
            const SizedBox(height: 24),
            
            // Author
            ThemedText.body(
              quote.author,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Date
            ThemedText.caption(
              _formatDate(quote.createdAt),
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gradient
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'QUOTE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quote text
                    Flexible(
                      child: ThemedText.body(
                        '"${quote.text}"',
                        fontSize: 20,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Author section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                            child: Text(
                              quote.author.isNotEmpty ? quote.author[0].toUpperCase() : 'A',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ThemedText.body(
                                  quote.author,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 4),
                                ThemedText.caption(
                                  _formatDate(quote.createdAt),
                                  fontSize: 12,
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
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
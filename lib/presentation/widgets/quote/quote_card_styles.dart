import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/core/settings/text_size_provider.dart';

class QuoteCardStyles {
  static Widget defaultStyle({
    required Quote quote,
    VoidCallback? onFavorite,
    VoidCallback? onShare,
    bool isFavorited = false,
    bool showCategory = false,
  }) {
    return Builder(
      builder: (context) {
        final textSize = context.watch<TextSizeProvider>().textSize;

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category chip (if category exists and showCategory is true)
                if (showCategory && quote.category.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      quote.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Quote text
                ThemedText.body(
                  '"${quote.text}"',
                  fontSize: textSize,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),

                const SizedBox(height: 16),

                // Author and actions row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ThemedText.body(
                            '— ${quote.author}',
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 4),
                          ThemedText.caption(
                            _formatDate(quote.createdAt),
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),

                    // Action buttons
                    IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited
                            ? Theme.of(context).colorScheme.tertiary
                            : null,
                      ),
                    ),
                    IconButton(
                      onPressed: onShare,
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget minimal({
    required Quote quote,
    VoidCallback? onFavorite,
    VoidCallback? onShare,
    bool isFavorited = false,
  }) {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote icon
            Icon(
              Icons.format_quote,
              size: 32,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            
            const SizedBox(height: 16),
            
            // Quote text
            ThemedText.body(
              '"${quote.text}"',
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
            
            const SizedBox(height: 24),
            
            // Author and date
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ThemedText.body(
                        '— ${quote.author}',
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
                
                // Action buttons
                Row(
                  children: [
                    IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: onShare,
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget elegant({
    required Quote quote,
    VoidCallback? onFavorite,
    VoidCallback? onShare,
    bool isFavorited = false,
  }) {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
              Theme.of(context).cardColor,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Decorative top element
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Large quote marks
            Icon(
              Icons.format_quote,
              size: 48,
              color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            ),
            
            const SizedBox(height: 20),
            
            // Quote text
            ThemedText.body(
              quote.text,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              textAlign: TextAlign.center,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
            
            const SizedBox(height: 32),
            
            // Decorative divider
            Container(
              width: 80,
              height: 1,
              color: Theme.of(context).dividerColor,
            ),
            
            const SizedBox(height: 20),
            
            // Author
            ThemedText.body(
              quote.author,
              fontSize: 16,
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
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildElegantButton(
                  icon: isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited ? Colors.red : Colors.grey,
                  onPressed: onFavorite,
                ),
                const SizedBox(width: 20),
                _buildElegantButton(
                  icon: Icons.share,
                  color: Theme.of(context).primaryColor,
                  onPressed: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget modern({
    required Quote quote,
    VoidCallback? onFavorite,
    VoidCallback? onShare,
    bool isFavorited = false,
  }) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with gradient
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'QUOTE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quote text
                  ThemedText.body(
                    '"${quote.text}"',
                    fontSize: 18,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Author section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                          child: Text(
                            quote.author.isNotEmpty ? quote.author[0].toUpperCase() : 'A',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ThemedText.body(
                                quote.author,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 2),
                              ThemedText.caption(
                                _formatDate(quote.createdAt),
                                fontSize: 11,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildModernButton(
                          context: context,
                          icon: isFavorited ? Icons.favorite : Icons.favorite_border,
                          label: isFavorited ? 'Favorited' : 'Favorite',
                          color: isFavorited ? Colors.red : Colors.grey,
                          onPressed: onFavorite,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildModernButton(
                          context: context,
                          icon: Icons.share,
                          label: 'Share',
                          color: Theme.of(context).primaryColor,
                          onPressed: onShare,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildElegantButton({
    required IconData icon,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        iconSize: 20,
      ),
    );
  }

  static Widget _buildModernButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/quote/quote_card_styles.dart';
import 'package:quote_vault/presentation/widgets/quote/shareable_quote_card.dart';

enum QuoteCardStyle {
  defaultStyle,
  minimal,
  elegant,
  modern,
}

class QuoteCard extends StatefulWidget {
  final Quote quote;
  final QuoteCardStyle style;
  final VoidCallback? onFavorite;
  final bool isFavorited;
  final bool showCategory;

  const QuoteCard({
    super.key,
    required this.quote,
    this.style = QuoteCardStyle.minimal,
    this.onFavorite,
    this.isFavorited = false,
    this.showCategory = false,
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool _isSharing = false;
  ShareableCardStyle _selectedShareStyle = ShareableCardStyle.minimal;

  @override
  void initState() {
    super.initState();
    // Map QuoteCardStyle to ShareableCardStyle
    _selectedShareStyle = _mapToShareableStyle(widget.style);
  }

  ShareableCardStyle _mapToShareableStyle(QuoteCardStyle style) {
    switch (style) {
      case QuoteCardStyle.defaultStyle:
        return ShareableCardStyle.minimal;
      case QuoteCardStyle.minimal:
        return ShareableCardStyle.minimal;
      case QuoteCardStyle.elegant:
        return ShareableCardStyle.elegant;
      case QuoteCardStyle.modern:
        return ShareableCardStyle.modern;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: _buildCardByStyle(),
    );
  }

  Widget _buildCardByStyle() {
    switch (widget.style) {
      case QuoteCardStyle.defaultStyle:
        return QuoteCardStyles.defaultStyle(
          quote: widget.quote,
          onFavorite: widget.onFavorite,
          onShare: _showShareOptions,
          isFavorited: widget.isFavorited,
          showCategory: widget.showCategory,
        );
      case QuoteCardStyle.minimal:
        return QuoteCardStyles.minimal(
          quote: widget.quote,
          onFavorite: widget.onFavorite,
          onShare: _showShareOptions,
          isFavorited: widget.isFavorited,
        );
      case QuoteCardStyle.elegant:
        return QuoteCardStyles.elegant(
          quote: widget.quote,
          onFavorite: widget.onFavorite,
          onShare: _showShareOptions,
          isFavorited: widget.isFavorited,
        );
      case QuoteCardStyle.modern:
        return QuoteCardStyles.modern(
          quote: widget.quote,
          onFavorite: widget.onFavorite,
          onShare: _showShareOptions,
          isFavorited: widget.isFavorited,
        );
    }
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => _buildShareBottomSheet(setModalState),
      ),
    );
  }

  Widget _buildShareBottomSheet(StateSetter setModalState) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7, // Increased height for preview
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: 20),
          
          ThemedText.heading(
            'Share Quote',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          
          const SizedBox(height: 24),
          
          // Share options - wrapped in Expanded to fill available space
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Style preview section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.preview,
                              color: Theme.of(context).colorScheme.tertiary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            ThemedText.body(
                              'Style: ${_getShareableStyleName(_selectedShareStyle)}',
                              fontWeight: FontWeight.w600,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => _showStyleSelectorForSharing(setModalState),
                              child: Text('Change'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Mini preview of selected style
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: OverflowBox(
                              maxHeight: double.infinity,
                              child: Transform.scale(
                                scale: 0.25,
                                child: ShareableQuoteCard(
                                  quote: widget.quote,
                                  style: _selectedShareStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  _buildShareOption(
                    icon: Icons.text_fields,
                    title: 'Share as Text',
                    subtitle: 'Share quote text via system share',
                    onTap: () {
                      Navigator.pop(context);
                      _shareAsText();
                    },
                  ),
                  
                  _buildShareOption(
                    icon: Icons.image,
                    title: 'Share as Image',
                    subtitle: 'Generate and share quote card',
                    onTap: () {
                      Navigator.pop(context);
                      _shareAsImage();
                    },
                  ),
                  
                  _buildShareOption(
                    icon: Icons.save_alt,
                    title: 'Save to Gallery',
                    subtitle: 'Save quote card to device',
                    onTap: () {
                      Navigator.pop(context);
                      _saveToGallery();
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showStyleSelectorForSharing(StateSetter parentModalState) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildStyleSelectorForSharing(parentModalState),
    );
  }

  Widget _buildStyleSelectorForSharing(StateSetter parentModalState) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: 20),
          
          ThemedText.heading(
            'Choose Card Style',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          
          const SizedBox(height: 24),
          
          // Style options
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ShareableCardStyle.values.map((style) {
                  return _buildStyleOptionForSharing(
                    style: style,
                    isSelected: _selectedShareStyle == style,
                    onTap: () {
                      // Update both the main state and parent modal state
                      setState(() {
                        _selectedShareStyle = style;
                      });
                      parentModalState(() {
                        _selectedShareStyle = style;
                      });
                      Navigator.pop(context);
                      // Show a brief confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Style updated to ${_getShareableStyleName(style)}'),
                          duration: const Duration(milliseconds: 800),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStyleOptionForSharing({
    required ShareableCardStyle style,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).primaryColor 
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getShareableStyleColor(style),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getShareableStyleIcon(style),
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.body(
                    _getShareableStyleName(style),
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 2),
                  ThemedText.caption(
                    _getShareableStyleDescription(style),
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.tertiary.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.body(
                    title,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 2),
                  ThemedText.caption(
                    subtitle,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  void _shareAsText() {
    final text = '"${widget.quote.text}"\n\n— ${widget.quote.author}';
    Share.share(text);
  }

  Future<void> _shareAsImage() async {
    if (_isSharing) return;
    
    setState(() {
      _isSharing = true;
    });

    try {
      final imageFile = await _captureShareableWidget();
      if (imageFile != null) {
        await Share.shareXFiles([XFile(imageFile.path)]);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to share image: $e');
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  Future<void> _saveToGallery() async {
    if (_isSharing) return;
    
    setState(() {
      _isSharing = true;
    });

    try {
      final imageFile = await _captureShareableWidget();
      if (imageFile != null) {
        // Try to save directly to gallery first
        await Gal.putImage(imageFile.path);
        _showSuccessSnackBar('Quote card saved to gallery!');
      }
    } catch (e) {
      // If gallery save fails, fallback to share
      try {
        final imageFile = await _captureShareableWidget();
        if (imageFile != null) {
          await Share.shareXFiles(
            [XFile(imageFile.path)],
            text: 'Check out this quote!',
            subject: 'Quote Card',
          );
          _showSuccessSnackBar('Quote card ready to save! Use the share menu to save to gallery.');
        }
      } catch (shareError) {
        _showErrorSnackBar('Failed to prepare image: $shareError');
      }
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  Future<File?> _captureShareableWidget() async {
    try {
      // Create a temporary widget for capturing
      final captureKey = GlobalKey();
      
      // Create a temporary overlay for capturing
      final overlay = Overlay.of(context);
      late OverlayEntry overlayEntry;
      
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: -1000, // Position off-screen
          top: -1000,
          child: RepaintBoundary(
            key: captureKey,
            child: Material(
              child: ShareableQuoteCard(
                quote: widget.quote,
                style: _selectedShareStyle,
              ),
            ),
          ),
        ),
      );
      
      overlay.insert(overlayEntry);
      
      // Wait for the widget to be built
      await Future.delayed(const Duration(milliseconds: 100));
      
      final RenderRepaintBoundary boundary = captureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      
      // Remove the overlay
      overlayEntry.remove();
      
      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/quote_card_${DateTime.now().millisecondsSinceEpoch}.png');
        await file.writeAsBytes(pngBytes);
        return file;
      }
    } catch (e) {
      debugPrint('Error capturing widget: $e');
    }
    return null;
  }

  String _getShareableStyleName(ShareableCardStyle style) {
    switch (style) {
      case ShareableCardStyle.minimal:
        return 'Minimal';
      case ShareableCardStyle.elegant:
        return 'Elegant';
      case ShareableCardStyle.modern:
        return 'Modern';
    }
  }

  String _getShareableStyleDescription(ShareableCardStyle style) {
    switch (style) {
      case ShareableCardStyle.minimal:
        return 'Clean and simple design';
      case ShareableCardStyle.elegant:
        return 'Sophisticated with decorative elements';
      case ShareableCardStyle.modern:
        return 'Bold and contemporary look';
    }
  }

  IconData _getShareableStyleIcon(ShareableCardStyle style) {
    switch (style) {
      case ShareableCardStyle.minimal:
        return Icons.minimize;
      case ShareableCardStyle.elegant:
        return Icons.auto_awesome;
      case ShareableCardStyle.modern:
        return Icons.trending_up;
    }
  }

  Color _getShareableStyleColor(ShareableCardStyle style) {
    switch (style) {
      case ShareableCardStyle.minimal:
        return Colors.grey;
      case ShareableCardStyle.elegant:
        return Colors.purple;
      case ShareableCardStyle.modern:
        return Colors.blue;
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
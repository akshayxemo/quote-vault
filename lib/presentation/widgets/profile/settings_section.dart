import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildChildrenWithDividers(),
        ),
      ),
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> widgets = [];
    
    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      
      // Add divider between items (except for the last item)
      if (i < children.length - 1) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 56),
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
          ),
        );
      }
    }
    
    return widgets;
  }
}
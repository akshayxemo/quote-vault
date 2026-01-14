import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/presentation/widgets/quote/quote_card.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  // Demo quotes
  final List<Quote> _quotes = [
    Quote(
      id: '1',
      text: 'The only way to do great work is to love what you do. If you haven\'t found it yet, keep looking. Don\'t settle.',
      author: 'Steve Jobs',
      category: 'Motivation',
      createdAt: DateTime(2023, 10, 24),
      isFavorite: false,
    ),
    Quote(
      id: '2',
      text: 'Innovation distinguishes between a leader and a follower.',
      author: 'Steve Jobs',
      category: 'Innovation',
      createdAt: DateTime(2023, 11, 15),
      isFavorite: true,
    ),
    Quote(
      id: '3',
      text: 'Your time is limited, don\'t waste it living someone else\'s life.',
      author: 'Steve Jobs',
      category: 'Life',
      createdAt: DateTime(2023, 12, 1),
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new quote functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              context.push('/quote-card-demo');
            },
          ),
        ],
      ),
      body: _quotes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.format_quote,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  ThemedText.heading('No Quotes Yet'),
                  SizedBox(height: 8),
                  ThemedText.body(
                    'Your curated quotes will appear here',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _quotes.length,
              itemBuilder: (context, index) {
                final quote = _quotes[index];
                return QuoteCard(
                  quote: quote,
                  style: QuoteCardStyle.defaultStyle,
                  isFavorited: quote.isFavorite,
                  onFavorite: () {
                    setState(() {
                      _quotes[index] = quote.copyWith(
                        isFavorite: !quote.isFavorite,
                      );
                    });
                  },
                );
              },
            ),
    );
  }
}
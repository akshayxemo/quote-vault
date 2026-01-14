import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart' as app_auth;
import 'package:quote_vault/presentation/bloc/search/search_bloc.dart';
import 'package:quote_vault/presentation/bloc/search/search_event.dart';
import 'package:quote_vault/presentation/bloc/search/search_state.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/quote/quote_card.dart';

final sl = GetIt.instance;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: const _SearchScreenContent(),
    );
  }
}

class _SearchScreenContent extends StatefulWidget {
  const _SearchScreenContent();

  @override
  State<_SearchScreenContent> createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<_SearchScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  SearchType _searchType = SearchType.quote;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    final authState = context.read<AuthBloc>().state;
    final userId = authState is app_auth.AuthAuthenticated
        ? authState.session.user.id
        : null;

    context.read<SearchBloc>().add(
      SearchQuotes(query: query, searchType: _searchType, userId: userId),
    );
  }

  void _handleFavorite(String quoteId) {
    // This would need to be implemented similar to home screen
    // For now, show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Favorite functionality coming soon!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar and filter
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search TextField with button
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: (_) => _performSearch(),
                          decoration: InputDecoration(
                            hintText: _searchType == SearchType.quote
                                ? 'Search quotes...'
                                : 'Search by author...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<SearchBloc>().add(
                                  const ClearSearch(),
                                );
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _performSearch,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Search type selector
                  Row(
                    children: [
                      ThemedText.caption(
                        'Search by:',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(width: 12),
                      _SearchTypeChip(
                        label: 'Quote',
                        icon: Icons.format_quote,
                        isSelected: _searchType == SearchType.quote,
                        onTap: () {
                          setState(() {
                            _searchType = SearchType.quote;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _SearchTypeChip(
                        label: 'Author',
                        icon: Icons.person,
                        isSelected: _searchType == SearchType.author,
                        onTap: () {
                          setState(() {
                            _searchType = SearchType.author;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search results
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 80,
                              color: Colors.grey.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 16),
                            ThemedText.heading('Search Quotes', fontSize: 20),
                            const SizedBox(height: 8),
                            ThemedText.body(
                              'Search through thousands of inspiring quotes',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchOffline) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 64,
                              color: Colors.grey.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 16),
                            ThemedText.heading('You are offline', fontSize: 20),
                            const SizedBox(height: 8),
                            ThemedText.body(
                              'Please check your internet connection',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _performSearch,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is SearchError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ThemedText.body('Error: ${state.message}'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _performSearch,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is SearchLoaded) {
                      if (state.quotes.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey.withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 16),
                              ThemedText.heading(
                                'No results found',
                                fontSize: 20,
                              ),
                              const SizedBox(height: 8),
                              ThemedText.body(
                                'Try searching with different keywords',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ThemedText.body(
                              'Found ${state.quotes.length} result${state.quotes.length == 1 ? '' : 's'}',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 8),
                              itemCount: state.quotes.length,
                              itemBuilder: (context, index) {
                                final quote = state.quotes[index];
                                return QuoteCard(
                                  quote: quote,
                                  style: QuoteCardStyle.defaultStyle,
                                  onFavorite: () => _handleFavorite(quote.id),
                                  isFavorited: quote.isFavorite,
                                  showCategory: true, // Show category chip
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SearchTypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

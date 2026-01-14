import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart' as app_auth;
import 'package:quote_vault/presentation/bloc/home/home_bloc.dart';
import 'package:quote_vault/presentation/bloc/home/home_event.dart';
import 'package:quote_vault/presentation/bloc/home/home_state.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/quote/quote_card.dart';

final sl = GetIt.instance;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, app_auth.AuthState>(
      builder: (context, authState) {
        final userId = authState is app_auth.AuthAuthenticated
            ? authState.session.user.id
            : null;

        return BlocProvider(
          create: (context) =>
              sl<HomeBloc>()..add(LoadHomeData(userId: userId)),
          child: const _HomeScreenContent(),
        );
      },
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<HomeBloc>().state;
      if (state is HomeLoaded && !state.isLoadingMore && state.hasMoreQuotes) {
        // Pass the current selected category to maintain the filter
        context.read<HomeBloc>().add(
          LoadQuotes(categoryId: state.selectedCategoryId),
        );
      }
    }
  }

  void _handleFavorite(String quoteId) {
    final homeState = context.read<HomeBloc>().state;
    if (homeState is HomeLoaded && homeState.userId != null) {
      context.read<HomeBloc>().add(ToggleFavorite(quoteId));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in to favorite quotes'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeOffline) {
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
                        onPressed: () {
                          final authState = context.read<AuthBloc>().state;
                          final userId = authState is app_auth.AuthAuthenticated
                              ? authState.session.user.id
                              : null;
                          context.read<HomeBloc>().add(
                            LoadHomeData(userId: userId),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ThemedText.body('Error: ${state.message}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final authState = context.read<AuthBloc>().state;
                          final userId = authState is app_auth.AuthAuthenticated
                              ? authState.session.user.id
                              : null;
                          context.read<HomeBloc>().add(
                            LoadHomeData(userId: userId),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is HomeLoaded) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppConstants.largeSpacing,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TODAY'S REFLECTION",
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Quote of the day",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.quoteOfTheDay != null)
                      SliverToBoxAdapter(
                        child: QuoteCard(
                          quote: state.quoteOfTheDay!,
                          style: QuoteCardStyle.minimal,
                          onFavorite: () =>
                              _handleFavorite(state.quoteOfTheDay!.id),
                          isFavorited: state.quoteOfTheDay!.isFavorite,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.largeSpacing,
                          vertical: 8,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _CategoryChip(
                                label: 'All Quotes',
                                isSelected: state.selectedCategoryId == null,
                                onTap: () {
                                  context.read<HomeBloc>().add(
                                    const SelectCategory(null),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              ...state.categories.map((category) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: _CategoryChip(
                                    label: category.name,
                                    isSelected:
                                        state.selectedCategoryId == category.id,
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                        SelectCategory(category.id),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index >= state.quotes.length) {
                          return state.isLoadingMore
                              ? const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }

                        final quote = state.quotes[index];
                        return QuoteCard(
                          quote: quote,
                          style: QuoteCardStyle.defaultStyle,
                          onFavorite: () => _handleFavorite(quote.id),
                          isFavorited: quote.isFavorite,
                        );
                      }, childCount: state.quotes.length + 1),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Theme.of(context).textTheme.bodyMedium?.color,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

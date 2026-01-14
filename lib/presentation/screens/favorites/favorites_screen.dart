import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart' as app_auth;
import 'package:quote_vault/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:quote_vault/presentation/bloc/favorites/favorites_event.dart';
import 'package:quote_vault/presentation/bloc/favorites/favorites_state.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/quote/quote_card.dart';

final sl = GetIt.instance;

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, app_auth.AuthState>(
      builder: (context, authState) {
        if (authState is! app_auth.AuthAuthenticated) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: const Text('Favorites'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  ThemedText.heading('Sign in to view favorites', fontSize: 20),
                  const SizedBox(height: 8),
                  ThemedText.body(
                    'Save your favorite quotes and access them here',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final userId = authState.session.user.id;

        return BlocProvider(
          create: (context) =>
              sl<FavoritesBloc>()..add(LoadFavorites(userId: userId)),
          child: const _FavoritesScreenContent(),
        );
      },
    );
  }
}

class _FavoritesScreenContent extends StatefulWidget {
  const _FavoritesScreenContent();

  @override
  State<_FavoritesScreenContent> createState() =>
      _FavoritesScreenContentState();
}

class _FavoritesScreenContentState extends State<_FavoritesScreenContent> {
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
      final state = context.read<FavoritesBloc>().state;
      if (state is FavoritesLoaded && !state.isLoadingMore && state.hasMore) {
        context.read<FavoritesBloc>().add(const LoadMoreFavorites());
      }
    }
  }

  void _handleRemoveFavorite(String quoteId) {
    context.read<FavoritesBloc>().add(RemoveFavorite(quoteId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavoritesOffline) {
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
                        if (authState is app_auth.AuthAuthenticated) {
                          context.read<FavoritesBloc>().add(
                            LoadFavorites(userId: authState.session.user.id),
                          );
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is FavoritesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ThemedText.body('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState is app_auth.AuthAuthenticated) {
                          context.read<FavoritesBloc>().add(
                            LoadFavorites(userId: authState.session.user.id),
                          );
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is FavoritesLoaded) {
              if (state.quotes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const SizedBox(height: 16),
                      ThemedText.heading('No favorites yet', fontSize: 20),
                      const SizedBox(height: 8),
                      ThemedText.body(
                        'Start adding quotes to your favorites',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 8),
                itemCount: state.quotes.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.quotes.length) {
                    return state.isLoadingMore
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink();
                  }

                  final quote = state.quotes[index];
                  return QuoteCard(
                    quote: quote,
                    style: QuoteCardStyle.defaultStyle,
                    onFavorite: () => _handleRemoveFavorite(quote.id),
                    isFavorited: true,
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
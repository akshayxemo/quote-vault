import 'package:quote_vault/data/models/category_model.dart';
import 'package:quote_vault/data/models/quote_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel?> getQuoteOfTheDay();
  Future<List<CategoryModel>> getCategories();
  Future<List<QuoteModel>> getQuotes({
    String? categoryId,
    int? limit,
    int? offset,
    String? userId,
  });
  Future<List<QuoteModel>> getFavoriteQuotes({
    required String userId,
    int? limit,
    int? offset,
  });
  Future<bool> toggleFavorite({
    required String quoteId,
    required String userId,
  });
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final SupabaseClient supabaseClient;

  QuoteRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<QuoteModel?> getQuoteOfTheDay() async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      
      final response = await supabaseClient
          .from('quote_of_the_day')
          .select('quote_id, quotes(*)')
          .eq('date', today)
          .maybeSingle();

      if (response == null) return null;

      final quoteData = response['quotes'];
      return QuoteModel.fromJson(quoteData);
    } catch (e) {
      throw Exception('Failed to get quote of the day: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await supabaseClient
          .from('categories')
          .select()
          .order('name');

      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  @override
  Future<List<QuoteModel>> getQuotes({
    String? categoryId,
    int? limit,
    int? offset,
    String? userId,
  }) async {
    try {
      dynamic query = supabaseClient.from('quotes').select('''
        *,
        quote_categories!inner(category_id),
        favorite_quotes(id)
      ''');

      if (categoryId != null) {
        query = query.eq('quote_categories.category_id', categoryId);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query.order('created_at', ascending: false);

      return (response as List).map((json) {
        final isFavorite = userId != null && 
            (json['favorite_quotes'] as List).any((fav) => fav != null);
        
        return QuoteModel.fromJson({
          ...json,
          'is_favorite': isFavorite,
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to get quotes: $e');
    }
  }

  @override
  Future<List<QuoteModel>> getFavoriteQuotes({
    required String userId,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = supabaseClient
          .from('favorite_quotes')
          .select('quotes(*)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;

      return (response as List)
          .map((item) => QuoteModel.fromJson({
                ...item['quotes'],
                'is_favorite': true,
              }))
          .toList();
    } catch (e) {
      throw Exception('Failed to get favorite quotes: $e');
    }
  }

  @override
  Future<bool> toggleFavorite({
    required String quoteId,
    required String userId,
  }) async {
    try {
      final existing = await supabaseClient
          .from('favorite_quotes')
          .select()
          .eq('quote_id', quoteId)
          .eq('user_id', userId)
          .maybeSingle();

      if (existing != null) {
        await supabaseClient
            .from('favorite_quotes')
            .delete()
            .eq('id', existing['id']);
        return false;
      } else {
        await supabaseClient.from('favorite_quotes').insert({
          'quote_id': quoteId,
          'user_id': userId,
        });
        return true;
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }
}

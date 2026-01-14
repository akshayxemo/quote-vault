import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String userName = 'Guest User';
        String userEmail = 'Not logged in';

        if (state is AuthAuthenticated) {
          final user = state.session.user;
          userName =
              user.userMetadata?['full_name'] ??
              user.email?.split('@').first ??
              'User';
          userEmail = user.email ?? 'No email';
        }

        return Center(
          child: Column(
            children: [
              // Profile Avatar with Edit Button
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar_placeholder.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 50,
                            color: Theme.of(context).iconTheme.color,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.tertiary,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // User Name
              ThemedText.heading(
                userName,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 4),

              // Email
              ThemedText.subText(
                userEmail, fontSize: 14),

              const SizedBox(height: 16),

              // Premium Badge
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).cardColor,
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(
              //       color: Theme.of(context).dividerColor,
              //     ),
              //   ),
              //   child: ThemedText.body(
              //     'Premium Member',
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
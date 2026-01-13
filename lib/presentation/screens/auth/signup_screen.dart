import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/common/custom_card.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_event.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart';
import 'package:quote_vault/presentation/widgets/auth/auth_text_field.dart';
import 'package:quote_vault/presentation/widgets/auth/auth_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/home');
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.mediumSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.extraLargeSpacing),

                // Header
                _buildHeader(),

                const SizedBox(height: AppConstants.extraLargeSpacing),

                // Sign Up Form
                _buildSignUpForm(),

                const SizedBox(height: AppConstants.largeSpacing),

                // Sign In Link
                _buildSignInLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App Logo/Icon
        Image.asset("assets/images/logo.png", height: 70, width: 70),

        const SizedBox(height: AppConstants.mediumSpacing),

        ThemedText.heading(
          'Create Account',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppConstants.smallSpacing),

        ThemedText.subText(
          'Join Quote Vault and start collecting wisdom',
          textAlign: TextAlign.center,
          fontSize: 16,
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.largeSpacing),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full Name Field
            AuthTextField(
              controller: _fullNameController,
              labelText: 'Full Name (Optional)',
              hintText: 'Enter your full name',
              prefixIcon: Icons.person_outline,
              textInputAction: TextInputAction.next,
              validator: null, // Optional field
            ),

            const SizedBox(height: AppConstants.mediumSpacing),

            // Email Field
            AuthTextField(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: _validateEmail,
            ),

            const SizedBox(height: AppConstants.mediumSpacing),

            // Password Field
            AuthTextField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              validator: _validatePassword,
            ),

            const SizedBox(height: AppConstants.mediumSpacing),

            // Confirm Password Field
            AuthTextField(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              hintText: 'Confirm your password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              validator: _validateConfirmPassword,
            ),

            const SizedBox(height: AppConstants.largeSpacing),

            // Sign Up Button
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AuthButton(
                  text: 'Create Account',
                  isLoading: state is AuthLoading,
                  onPressed: _handleSignUp,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemedText.body('Already have an account? '),
        GestureDetector(
          onTap: () => context.go('/signin'),
          child: ThemedText.accent(
            'Sign In',
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignUpEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          fullName: _fullNameController.text.trim().isEmpty
              ? null
              : _fullNameController.text.trim(),
        ),
      );
    }
  }
}
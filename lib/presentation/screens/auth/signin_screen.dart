import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_event.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart';
import 'package:quote_vault/presentation/widgets/auth/auth_button.dart';
import 'package:quote_vault/presentation/widgets/auth/auth_text_field.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                content: Text('Login successfull!'),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/home');
          }
        },
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.mediumSpacing,
                horizontal: AppConstants.extraLargeSpacing,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      (AppConstants.mediumSpacing * 2),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 70,
                        width: 70,
                      ),
                      const SizedBox(height: 10),
                      ThemedText.heading(
                        "Welcome Back",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      ThemedText.subText(
                        "Signin to access your collection",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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

                            _buildForgetPasswordLink(),

                            const SizedBox(height: AppConstants.largeSpacing),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthButton(
                                  text: 'Sign In',
                                  isLoading: state is AuthLoading,
                                  onPressed: _handleSignIn,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      _buildSignUpLink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemedText.body("Don't have an account? "),
        GestureDetector(
          onTap: () => context.go('/signup'),
          child: ThemedText.accent(
            'Sign Up',
            fontWeight: FontWeight.w600,
            // decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Widget _buildForgetPasswordLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => context.go('/signup'),
          child: ThemedText.accent(
            "Forgot Password ?",
            fontWeight: FontWeight.w600,
            // decoration: TextDecoration.underline,
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

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignInEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }
}

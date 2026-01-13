import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/core/theme/text_theme_extension.dart';
import 'package:quote_vault/core/theme/app_colors.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToHome();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/signin');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
            AppColors.splash,
            Colors.white,
          ])
        ),
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largeSpacing, vertical: AppConstants.mediumSpacing),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      // App Logo/Icon
                      Image.asset('assets/images/logo_vertical.png'),
                      
                      // Main tagline with advanced styling
                      ThemedText.accent(
                        'CURATED WISDOM',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0,
                        textAlign: TextAlign.center,
                        shadows: [
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                        ],
                      ),
                      
                      // Subtitle with different styling
                      ThemedText.subText(
                        'Discover • Collect • Inspire',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                        textAlign: TextAlign.center,
                        fontStyle: FontStyle.italic,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      
                      const SizedBox(height: AppConstants.extraLargeSpacing),
                      
                      // Loading indicator
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.textColors.accentColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      
                      // Quote with rich styling
                      ThemedText.subText(
                        '"Words are, in my not-so-humble opinion, our most inexhaustible source of magic."',
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        height: 1.4, // Line height
                        letterSpacing: 0.3,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      
                      // Author attribution
                      ThemedText.caption(
                        '— Albus Dumbledore',
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        letterSpacing: 1.0,
                        padding: const EdgeInsets.only(top: 8),
                      ),
                      // const SizedBox(height: AppConstants.largeSpacing,),
                      // const Text(
                      //   'DISCOVER YOUR NEXT SPEARK',
                      //   style: TextStyle(fontSize: 10, letterSpacing: 3)
                      // ),
                      const SizedBox(height: AppConstants.extraLargeSpacing,),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
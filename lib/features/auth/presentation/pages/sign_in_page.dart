import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:demodoumentation/app_route.gr.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _initializeGoogleSignIn();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeGoogleSignIn() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    try {
      await signIn.initialize(
        clientId:
            "1089380465346-72ucmurv2iigj0sd1asu1hrefvofji67.apps.googleusercontent.com",
        serverClientId:
            "72557827596-t3q9ku3hqq2d58v74omdf08j8p6fl71r.apps.googleusercontent.com",
      );

      // Set up the authentication event listener only once
      _authSubscription = signIn.authenticationEvents.listen(
        _handleAuthenticationEvent,
        onError: _handleAuthenticationError,
      );

      // Attempt lightweight authentication to check if user is already signed in
      // signIn.attemptLightweightAuthentication();
    } catch (error) {
      debugPrint('Google Sign-In initialization failed: $error');
    }
  }

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    debugPrint('Authentication event: $event');

    if (event is GoogleSignInAuthenticationEventSignIn) {
      // Extract real user data from the sign-in event
      _extractUserInfoAndNavigate(event);
    }
  }

  void _handleAuthenticationError(Object error) {
    // Handle authentication errors
    debugPrint('Authentication error: $error');
    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Authentication failed: $error')));
    }
  }

  Future<void> _extractUserInfoAndNavigate([
    GoogleSignInAuthenticationEvent? event,
  ]) async {
    try {
      Map<String, dynamic> userInfo;

      if (event is GoogleSignInAuthenticationEventSignIn) {
        // Get the actual user data from the sign-in event
        final GoogleSignInAccount user = event.user;

        debugPrint('Real user signed in: ${user.displayName}, ${user.email}');

        // Extract real user information from Google account
        userInfo = {
          'displayName': user.displayName ?? 'No Name',
          'email': user.email,
          'id': user.id,
          'photoUrl': user.photoUrl,
          'authStatus': 'Authenticated',
          'authTime': DateTime.now().toString(),
        };

        debugPrint('Real User Info: $userInfo');
      } else {
        // Fallback user info (this shouldn't happen with the new implementation)
        userInfo = {
          'displayName': 'Demo User',
          'email': 'demo@google.com',
          'id': 'demo_id_123',
          'photoUrl': null,
          'authStatus': 'Authenticated',
          'authTime': DateTime.now().toString(),
        };

        debugPrint('Using fallback user data');
      }

      setState(() {
        _isLoading = false;
      });

      // Navigate to user details page with real extracted info
      if (mounted) {
        context.router.push(UserDetailsRoute(userInfo: userInfo));
      }
    } catch (error) {
      debugPrint('Error extracting user info: $error');
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get user info: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sign in with your Google account to continue',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            if (GoogleSignIn.instance.supportsAuthenticate())
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          await GoogleSignIn.instance.authenticate();
                        } catch (e) {
                          debugPrint('Caught: $e');
                          setState(() {
                            _isLoading = false;
                          });

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Authentication failed: $e'),
                              ),
                            );
                          }
                        }
                      },
                      icon: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          "assets/images/google.webp",
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.g_mobiledata,
                                size: 24,
                                color: Colors.blue,
                              ),
                        ),
                      ),
                      label: const Text('Sign in with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
            if (!GoogleSignIn.instance.supportsAuthenticate())
              const Text(
                'Google Sign-In is not supported on this platform',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    // Handle successful authentication
    debugPrint('Authentication event: $event');
  }

  void _handleAuthenticationError(Object error) {
    // Handle authentication errors
    debugPrint('Authentication error: $error');
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    unawaited(
      signIn
          .initialize(
            clientId:
                "1089380465346-72ucmurv2iigj0sd1asu1hrefvofji67.apps.googleusercontent.com",
            serverClientId:
                "72557827596-t3q9ku3hqq2d58v74omdf08j8p6fl71r.apps.googleusercontent.com",
          )
          .then((_) {
            signIn.authenticationEvents
                .listen(_handleAuthenticationEvent)
                .onError(_handleAuthenticationError);

            /// This example always uses the stream-based approach to determining
            /// which UI state to show, rather than using the future returned here,
            /// if any, to conditionally skip directly to the signed-in state.
            signIn.attemptLightweightAuthentication();
          }),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign In")),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (GoogleSignIn.instance.supportsAuthenticate())
              IconButton(
                onPressed: () async {
                  try {
                    await GoogleSignIn.instance.authenticate();
                  } catch (e) {
                    debugPrint('Caught: $e');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Authentication failed: $e')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.login),
              ),
          ],
        ),
      ),
    );
  }
}

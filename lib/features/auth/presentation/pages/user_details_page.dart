import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

@RoutePage()
class UserDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? userInfo;

  const UserDetailsPage({super.key, this.userInfo});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool _isLoading = false;
  Map<String, dynamic>? _userInfo;

  @override
  void initState() {
    super.initState();
    _userInfo =
        widget.userInfo ??
        {
          'displayName': 'Demo User',
          'email': 'demo@example.com',
          'id': '123456789',
          'photoUrl': null,
        };
  }

  Future<void> _handleSignOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await GoogleSignIn.instance.signOut();

      if (mounted) {
        // Navigate back to sign-in page
        context.router.popUntilRoot();
      }
    } catch (error) {
      debugPrint('Sign out error: $error');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sign out failed: $error')));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            onPressed: _handleSignOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userInfo == null
          ? const Center(child: Text('No user signed in'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile Section
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _userInfo!['photoUrl'] != null
                              ? NetworkImage(_userInfo!['photoUrl']!)
                              : null,
                          child: _userInfo!['photoUrl'] == null
                              ? const Icon(Icons.account_circle, size: 50)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _userInfo!['displayName'] ?? 'No Name',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _userInfo!['email'] ?? 'No Email',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // User Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Information',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            'Display Name',
                            _userInfo!['displayName'] ?? 'Not available',
                          ),
                          _buildInfoRow(
                            'Email',
                            _userInfo!['email'] ?? 'Not available',
                          ),
                          _buildInfoRow(
                            'User ID',
                            _userInfo!['id'] ?? 'Not available',
                          ),
                          _buildInfoRow(
                            'Photo URL',
                            _userInfo!['photoUrl'] ?? 'Not available',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Actions
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _handleSignOut,
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 2),
          SelectableText(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

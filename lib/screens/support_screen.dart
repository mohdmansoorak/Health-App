import 'package:flutter/material.dart';

/// Support / Contact Us Screen
/// Shows contact information and support options
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 64,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'How can we help you?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We're here to help 24/7",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact options
            const Text(
              'Contact Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Phone support
            _buildContactCard(
              context,
              icon: Icons.phone,
              title: 'Call Support',
              subtitle: '+966 800 123 4567',
              description: 'Available 24/7',
              color: const Color(0xFF10B981),
              onTap: () {
                _showMessage(context, 'Calling support...');
              },
            ),

            // Email support
            _buildContactCard(
              context,
              icon: Icons.email,
              title: 'Email Support',
              subtitle: 'support@insuranceapp.com',
              description: 'Response within 24 hours',
              color: const Color(0xFF2563EB),
              onTap: () {
                _showMessage(context, 'Opening email client...');
              },
            ),

            // WhatsApp support
            _buildContactCard(
              context,
              icon: Icons.message,
              title: 'WhatsApp',
              subtitle: '+966 50 123 4567',
              description: 'Chat with us',
              color: const Color(0xFF10B981),
              onTap: () {
                _showMessage(context, 'Opening WhatsApp...');
              },
            ),

            const SizedBox(height: 24),

            // FAQ section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildFaqItem(
              'How do I file a claim?',
              'You can file a claim by going to the "My Claims" section and tapping on "File New Claim". Follow the steps to submit your claim.',
            ),

            _buildFaqItem(
              'How long does claim processing take?',
              'Most claims are processed within 5-7 business days. You will receive notifications about your claim status.',
            ),

            _buildFaqItem(
              'How do I renew my policy?',
              'You will receive a notification 30 days before your policy expires. You can renew it from the "My Policies" section.',
            ),

            _buildFaqItem(
              'Can I add family members to my policy?',
              'Yes, you can add family members to your policy. Please contact our support team for assistance.',
            ),
          ],
        ),
      ),
    );
  }

  /// Build contact card
  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build FAQ item
  Widget _buildFaqItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show message
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

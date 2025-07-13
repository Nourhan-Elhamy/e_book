import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/home_models.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookModel book;
  const BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Image
          SliverAppBar(
            expandedHeight: screenHeight * 0.5,
            floating: false,
            pinned: true,
            backgroundColor: Colors.brown[50],
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.brown[50]!.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.brown[800]),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Book Cover Image
                  Hero(
                    tag: book.title,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.brown[700]!, Colors.brown[600]!],
                        ),
                      ),
                      child: book.thumbnail.isNotEmpty
                          ? Image.network(
                              book.thumbnail,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(isTablet ? 32 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Title Section
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      book.title,
                      style: TextStyle(
                        fontSize: isTablet ? 32 : 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.brown[900],
                        height: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Book Info Cards
                  _buildInfoSection(context, isTablet),

                  const SizedBox(height: 32),

                  // Description Section
                  _buildDescriptionSection(context, isTablet),

                  const SizedBox(height: 40),

                  // Action Buttons
                  _buildActionButtons(context, isTablet),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.brown[600],
      child: const Center(
        child: Icon(Icons.menu_book, size: 80, color: Colors.white70),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, bool isTablet) {
    final infoItems = [
      {'label': 'Authors', 'value': book.authors, 'icon': Icons.person},
      {'label': 'Publisher', 'value': book.publisher, 'icon': Icons.business},
      {
        'label': 'Published Date',
        'value': book.publishedDate,
        'icon': Icons.calendar_today,
      },
      {
        'label': 'Categories',
        'value': book.categories.isNotEmpty
            ? book.categories.join(", ")
            : 'Not specified',
        'icon': Icons.category,
      },
    ];

    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          for (int i = 0; i < infoItems.length; i++)
            _buildInfoCard(
              context,
              infoItems[i]['label'] as String,
              infoItems[i]['value'] as String,
              infoItems[i]['icon'] as IconData,
              i * 100,
              isTablet,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    int delay,
    bool isTablet,
  ) {
    return FadeInUp(
      duration: Duration(milliseconds: 800 + delay),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.brown, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown[800],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context, bool isTablet) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1200),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.brown[300]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.description,
                    color: Colors.brown[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.brown[900],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              book.description,
              style: TextStyle(
                fontSize: isTablet ? 16 : 15,
                color: Colors.brown[700],
                height: 1.6,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isTablet) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1400),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.brown[700]!.withOpacity(0.3),
              ),
              icon: const Icon(Icons.open_in_browser, size: 24),
              label: Text(
                "Preview Book",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              onPressed: () async {
                final Uri url = Uri.parse(book.previewLink);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Could not open preview link'),
                        backgroundColor: Colors.brown[600],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.brown[700],
                side: BorderSide(color: Colors.brown[700]!, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.share, size: 24),
              label: Text(
                "Share Book",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              onPressed: () {
                // TODO: Implement share functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Share functionality coming soon!'),
                    backgroundColor: Colors.brown[500],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class QuizUploadPage extends StatefulWidget {
  const QuizUploadPage({super.key});

  @override
  State<QuizUploadPage> createState() => _QuizUploadPageState();
}

class _QuizUploadPageState extends State<QuizUploadPage> {
  // Track uploaded images
  final List<String> _uploadedImages = [];
  final int _maxImages = 10;

  void _selectImages() {
    // This would use image_picker in a real implementation
    // For now, just simulate adding an image
    if (_uploadedImages.length < _maxImages) {
      setState(() {
        _uploadedImages.add('placeholder');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define colors from the HTML design
    final primaryColor = Theme.of(context).colorScheme.primary; // #FFDF12
    final backgroundColor = Theme.of(context).colorScheme.surface; // #FFFFFF
    final textPrimary = Theme.of(context).colorScheme.onSurface; // #1F2937
    final textSecondary = const Color(0xFF6B7280); // #6B7280
    final accentColor = const Color(0xFFF3F4F6); // #F3F4F6

    return Scaffold(
      backgroundColor: backgroundColor,
      // AppBar with back button
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Buat Kuis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // Main content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title and description
              const Text(
                'Unggah Gambar Anda',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Unggah 10 gambar untuk membuat kuis yang kocak. AI kami akan menganalisis gambar dan menghasilkan pertanyaan yang menghibur.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Upload area
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    // Circle with plus icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 32,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pilih Gambar',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Klik untuk menulusuri dari perangkat Anda',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Upload button
                    ElevatedButton(
                      onPressed: _selectImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: textPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Pilih Gambar untuk Diunggah',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Anda telah mengunggah ${_uploadedImages.length} dari $_maxImages gambar.',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Preview section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pratinjau',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Grid of images
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsive grid: 2 columns on small screens, 3 on medium, 5 on large
                      int crossAxisCount = 2;
                      if (constraints.maxWidth > 600) {
                        crossAxisCount = 3;
                      }
                      if (constraints.maxWidth > 900) {
                        crossAxisCount = 5;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1, // Square aspect ratio
                        ),
                        itemCount: _maxImages,
                        itemBuilder: (context, index) {
                          final bool hasImage = index < _uploadedImages.length;

                          return Container(
                            decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: hasImage
                                  ? const Icon(Icons.image) // Placeholder for actual image
                                  : index == 0 && _uploadedImages.isEmpty
                                      ? Icon(
                                          Icons.photo_size_select_actual_outlined,
                                          color: Colors.grey.shade400,
                                          size: 24,
                                        )
                                      : null,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _uploadedImages.isNotEmpty ? () {} : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size.fromHeight(48), // Full width button
          ),
          child: const Text(
            'Buat Kuis',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

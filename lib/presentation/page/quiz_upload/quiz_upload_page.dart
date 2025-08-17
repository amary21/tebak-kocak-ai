import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QuizUploadPage extends StatefulWidget {
  const QuizUploadPage({super.key});

  @override
  State<QuizUploadPage> createState() => _QuizUploadPageState();
}

class _QuizUploadPageState extends State<QuizUploadPage> {
  // Track uploaded images
  final List<File> _uploadedImages = [];
  final int _maxImages = 10;
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImages() async {
    try {
      // Calculate how many more images can be selected
      final remainingSlots = _maxImages - _uploadedImages.length;

      if (remainingSlots <= 0) {
        _showSnackBar('Maksimal $_maxImages gambar sudah tercapai');
        return;
      }

      // Pick multiple images from gallery
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        // Limit the selection to remaining slots
        final filesToAdd = pickedFiles.take(remainingSlots).toList();

        // Convert XFile to File and add to list
        final List<File> newImages = filesToAdd
            .map((xFile) => File(xFile.path))
            .toList();

        setState(() {
          _uploadedImages.addAll(newImages);
        });

        // Show feedback to user
        final addedCount = newImages.length;
        final totalCount = _uploadedImages.length;

        if (pickedFiles.length > remainingSlots) {
          _showSnackBar(
            '$addedCount gambar ditambahkan. Maksimal $_maxImages gambar.',
          );
        } else {
          _showSnackBar(
            '$addedCount gambar berhasil ditambahkan ($totalCount/$_maxImages)',
          );
        }
      }
    } catch (e) {
      _showSnackBar('Gagal memilih gambar: ${e.toString()}');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
    });
    _showSnackBar('Gambar dihapus (${_uploadedImages.length}/$_maxImages)');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
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
        shadowColor: Colors.black.withValues(alpha: 0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Buat Kuis',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Unggah 10 gambar untuk membuat kuis yang kocak. AI kami akan menganalisis gambar dan menghasilkan pertanyaan yang menghibur.',
                style: TextStyle(color: Color(0xFF6B7280)),
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
                      style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    // Upload button
                    ElevatedButton(
                      onPressed: _uploadedImages.length < _maxImages
                          ? _selectImages
                          : null,
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
                      child: Text(
                        _uploadedImages.length < _maxImages
                            ? 'Pilih Gambar (${_uploadedImages.length}/$_maxImages)'
                            : 'Maksimal $_maxImages Gambar Tercapai',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Anda telah mengunggah ${_uploadedImages.length} dari $_maxImages gambar.',
                      style: TextStyle(fontSize: 12, color: textSecondary),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: hasImage
                                ? Stack(
                                    children: [
                                      // Display actual image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          _uploadedImages[index],
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Remove button
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () => _removeImage(index),
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withValues(
                                                alpha: 0.8,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: index == 0 && _uploadedImages.isEmpty
                                        ? Icon(
                                            Icons
                                                .photo_size_select_actual_outlined,
                                            color: Colors.grey.shade400,
                                            size: 24,
                                          )
                                        : Icon(
                                            Icons.add_photo_alternate_outlined,
                                            color: Colors.grey.shade300,
                                            size: 20,
                                          ),
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
              color: Colors.black.withValues(alpha: 0.1),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

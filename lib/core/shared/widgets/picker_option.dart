import 'package:belyfted/belyfted.dart';

class PickerOption extends StatelessWidget {
  const PickerOption({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 40.r,
        width: 40.r,
        decoration: BoxDecoration(
          color: AppColors.belyftedPrimaryColor.shade100,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppColors.belyftedPrimaryColor, size: 20.r),
      ),
      title: TextWidget(
        text: label,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        textColor: AppColors.belyftedNeutralColor.shade800,
      ),
      subtitle: TextWidget(
        text: subtitle,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        textColor: AppColors.belyftedNeutralColor.shade500,
      ),
    );
  }
}

class PickOptions extends StatelessWidget {
  const PickOptions({required this.onFileSelected, super.key});

  final void Function(String fileName, String filePath) onFileSelected;

  Future<void> _pickFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (image != null) {
      onFileSelected(image.name, image.path);
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      onFileSelected(image.name, image.path);
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      onFileSelected(file.name, file.path ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PickerOption(
          icon: Icons.camera_alt_outlined,
          label: 'Take a Photo',
          subtitle: 'Use your camera',
          onTap: _pickFromCamera,
        ),
        Divider(height: 1, color: AppColors.belyftedNeutralColor.shade200),
        PickerOption(
          icon: Icons.photo_library_outlined,
          label: 'Choose from Gallery',
          subtitle: 'Select an image',
          onTap: _pickFromGallery,
        ),
        Divider(height: 1, color: AppColors.belyftedNeutralColor.shade200),
        PickerOption(
          icon: Icons.insert_drive_file_outlined,
          label: 'Browse Files',
          subtitle: 'PDF, DOC, JPG, PNG',
          onTap: _pickDocument,
        ),
      ],
    );
  }
}

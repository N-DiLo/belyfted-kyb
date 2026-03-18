import 'package:belyfted/belyfted.dart';

class NewDirectorDetails extends StatefulWidget {
  const NewDirectorDetails({
    super.key,
    this.initialDirector,
    required this.onSaved,
    required this.onCancel,
  });

  final DirectorItem? initialDirector;
  final void Function(DirectorItem) onSaved;
  final VoidCallback onCancel;

  @override
  State<NewDirectorDetails> createState() => _NewDirectorDetailsState();
}

class _NewDirectorDetailsState extends State<NewDirectorDetails> {
  late final TextEditingController _emailController;
  late final TextEditingController _ownerController;
  late final TextEditingController _sharesController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    final d = widget.initialDirector;
    _emailController = TextEditingController(text: d?.email ?? '');
    _ownerController = TextEditingController(text: d?.ownership ?? '');
    _sharesController = TextEditingController(text: d?.shares ?? '');
    _phoneController = TextEditingController(text: d?.phone ?? '');
    _addressController = TextEditingController(text: d?.address ?? '');
    _selectedRole = d?.role;

    for (final c in [
      _emailController,
      _ownerController,
      _sharesController,
      _phoneController,
      _addressController,
    ]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _ownerController.dispose();
    _sharesController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _emailController.text.trim().isNotEmpty &&
      _ownerController.text.trim().isNotEmpty &&
      _sharesController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _addressController.text.trim().isNotEmpty &&
      _selectedRole != null;

  Future<void> _save() async {
    if (!_isValid) return;
    widget.onSaved(
      DirectorItem(
        name: _emailController.text.trim(),
        email: _emailController.text.trim(),
        ownership: _ownerController.text.trim(),
        shares: _sharesController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        role: _selectedRole!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 0.5,
          color: AppColors.belyftedNeutralColor.shade300,
        ),
      ),
      padding: po(t: 16, r: 16, b: 28, l: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: widget.initialDirector != null
                    ? 'Edit Director'
                    : 'New Director Details',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textColor: AppColors.belyftedPrimaryColor,
              ),
              GestureDetector(
                onTap: widget.onCancel,
                child: Container(
                  padding: 4.pa,
                  decoration: BoxDecoration(
                    color: AppColors.belyftedNeutralColor.shade200,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.r,
                    color: AppColors.darkColor,
                  ),
                ),
              ),
            ],
          ),
          24.fhs,
          CustomTextfield(
            labelText: 'Email Address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextfield(
            labelText: 'Ownership',
            controller: _ownerController,
            hintText: 'e.g 50%',
            keyboardType: TextInputType.number,
          ),
          CustomTextfield(
            labelText: 'Shares Allocated',
            controller: _sharesController,
            hintText: 'e.g 100000',
            keyboardType: TextInputType.number,
          ),
          CustomTextfield(
            labelText: 'Phone Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          CustomTextfield(
            labelText: 'Full Address',
            controller: _addressController,
          ),
          CustomTextfield(
            labelText: 'Role',
            hintText: 'Select Role',
            controller: TextEditingController(text: _selectedRole ?? ''),
            hasDrop: true,
            suffixIcon: ImageWidget(url: AppImages.arrowDown),
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Select Role',
                child: DialogContent(
                  items: MockKYBData.roles,
                  selectedValue: _selectedRole,
                ),
              );
              if (result != null) setState(() => _selectedRole = result);
            },
          ),
          8.fhs,
          CustomButton(
            onTap: _isValid ? _save : null,
            enabled: _isValid,
            text: widget.initialDirector != null
                ? 'Update Director'
                : 'Save Director',
          ),
        ],
      ),
    );
  }
}

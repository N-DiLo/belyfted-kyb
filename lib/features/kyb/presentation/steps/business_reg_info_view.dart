import 'package:belyfted/belyfted.dart';

class BusinessRegInfoView extends StatefulWidget {
  const BusinessRegInfoView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<BusinessRegInfoView> createState() => _BusinessRegInfoViewState();
}

class _BusinessRegInfoViewState extends State<BusinessRegInfoView> {
  final _businessNameController = TextEditingController();
  final _taxController = TextEditingController();
  final _scopeController = TextEditingController();
  final _descController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedYear;
  String? _selectedScope;
  String? _selectedCountry;

  @override
  void dispose() {
    _businessNameController.dispose();
    _taxController.dispose();
    _scopeController.dispose();
    _descController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: ps(h: 16),
      children: [
        24.fhs,
        TextWidget(
          text: 'Business Registration Info',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        TextWidget(
          text: 'Compliance details',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          textColor: AppColors.belyftedNeutralColor,
        ),
        32.fhs,
        CustomTextfield(
          labelText: 'Registered Country',
          hintText: 'Select Country',
          hasDrop: true,
          controller: TextEditingController(text: _selectedCountry ?? ''),
          onTap: () async {
            final result = await CustomDialog.show<String>(
              context: context,
              title: 'Country',
              child: DialogContent(
                items: MockKYBData.countries,
                selectedValue: _selectedCountry,
              ),
            );
            if (result != null) setState(() => _selectedCountry = result);
          },
        ),
        CustomTextfield(
          labelText: 'Registered Year',
          hintText: 'Select Registered Year',
          hasDrop: true,
          controller: TextEditingController(text: _selectedYear ?? ''),
          onTap: () async {
            final result = await CustomDialog.show<String>(
              context: context,
              title: 'Year',
              child: DialogContent(
                items: MockKYBData.years,
                selectedValue: _selectedYear,
              ),
            );
            if (result != null) setState(() => _selectedYear = result);
          },
        ),
        CustomTextfield(
          labelText: 'Business Name',
          controller: _businessNameController,
        ),
        CustomTextfield(labelText: 'Tax/VAT ID', controller: _taxController),
        CustomTextfield(
          labelText: 'Business Scope',
          hintText: 'Select Business Scope',
          hasDrop: true,
          controller: TextEditingController(text: _selectedScope ?? ''),
          onTap: () async {
            final result = await CustomDialog.show<String>(
              context: context,
              title: 'Business Scope',
              child: DialogContent(
                items: MockKYBData.scope,
                selectedValue: _selectedScope,
              ),
            );
            if (result != null) setState(() => _selectedScope = result);
          },
        ),
        CustomTextfield(
          maxLines: 5,
          maxLength: 200,
          labelText: 'Business Description',
          controller: _descController,
        ),
        69.fhs,
        CustomButton(
          onTap: () async => widget.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          text: 'Continue',
          enabled: true,
        ),
        16.fhs,
      ],
    );
  }
}

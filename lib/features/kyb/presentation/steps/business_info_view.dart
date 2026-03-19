import 'package:belyfted/belyfted.dart';

class BusinessInfoView extends ConsumerStatefulWidget {
  const BusinessInfoView({super.key, required this.pageController});
  final PageController pageController;

  @override
  ConsumerState<BusinessInfoView> createState() => _BusinessInfoViewState();
}

class _BusinessInfoViewState extends ConsumerState<BusinessInfoView> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  String? _selectedBusinessType;
  String? _selectedIndustry;
  String? _selectedEntity;
  String? _selectedCountry;

  final _canProceed = ValueNotifier<bool>(false);

  List<TextEditingController> get _requiredControllers => [
    _businessNameController,
    _firstNameController,
    _lastNameController,
    _phoneController,
    _emailController,
    _address1Controller,
    _cityController,
    _stateController,
    _zipCodeController,
  ];

  void _updateCanProceed() {
    final allFilled = _requiredControllers.every(
      (c) => c.text.trim().isNotEmpty,
    );
    final allDropdowns =
        _selectedBusinessType != null &&
        _selectedIndustry != null &&
        _selectedEntity != null &&
        _selectedCountry != null;

    _canProceed.value = allFilled && allDropdowns;
  }

  @override
  void initState() {
    super.initState();
    for (final c in _requiredControllers) {
      c.addListener(_updateCanProceed);
    }
  }

  @override
  void dispose() {
    for (final c in _requiredControllers) {
      c.removeListener(_updateCanProceed);
    }
    _businessNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _canProceed.dispose();
    super.dispose();
  }

  void _onDropSelected(String? result, VoidCallback onSet) {
    if (result != null) {
      setState(() => onSet());
      _updateCanProceed();
    }
  }

  Future<void> _onContinue() async {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(kybSubmissionProvider.notifier)
          .updateBusinessInfo(
            businessName: _businessNameController.text.trim(),
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            businessType: _selectedBusinessType ?? '',
            industry: _selectedIndustry ?? '',
            entity: _selectedEntity ?? '',
            website: _websiteController.text.trim(),
            phone: _phoneController.text.trim(),
            email: _emailController.text.trim(),
            address1: _address1Controller.text.trim(),
            address2: _address2Controller.text.trim(),
            city: _cityController.text.trim(),
            stateValue: _stateController.text.trim(),
            country: _selectedCountry ?? '',
            zipCode: _zipCodeController.text.trim(),
          );
      await widget.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: ps(h: 16),
        children: [
          24.fhs,
          TextWidget(
            text: 'Business Information',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          TextWidget(
            text: 'Kindly input your details',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            textColor: AppColors.belyftedNeutralColor,
          ),
          32.fhs,
          CustomTextfield(
            labelText: 'Business Name',
            controller: _businessNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: (v) => Validators.isNotEmpty(v, 'Business name'),
          ),
          CustomTextfield(
            labelText: 'First Name',
            controller: _firstNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: (v) => Validators.isNotEmpty(v, 'First name'),
          ),
          CustomTextfield(
            labelText: 'Last Name',
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: (v) => Validators.isNotEmpty(v, 'Last name'),
          ),
          CustomTextfield(
            labelText: 'Business Type',
            hintText: 'Select Business Type',
            controller: TextEditingController(
              text: _selectedBusinessType ?? '',
            ),
            hasDrop: true,
            validator: (_) => _selectedBusinessType == null
                ? 'Please select a business type'
                : null,
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Business Type',
                child: DialogContent(
                  items: MockKYBData.businessTypes,
                  selectedValue: _selectedBusinessType,
                ),
              );
              _onDropSelected(result, () => _selectedBusinessType = result);
            },
          ),
          CustomTextfield(
            labelText: 'Industry',
            hintText: 'Select Industry',
            hasDrop: true,
            controller: TextEditingController(text: _selectedIndustry ?? ''),
            validator: (_) =>
                _selectedIndustry == null ? 'Please select an industry' : null,
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Industry',
                child: DialogContent(
                  items: MockKYBData.industries,
                  selectedValue: _selectedIndustry,
                ),
              );
              _onDropSelected(result, () => _selectedIndustry = result);
            },
          ),
          CustomTextfield(
            labelText: 'Entity',
            hintText: 'Select Entity',
            hasDrop: true,
            controller: TextEditingController(text: _selectedEntity ?? ''),
            validator: (_) =>
                _selectedEntity == null ? 'Please select an entity' : null,
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Entity',
                child: DialogContent(
                  items: MockKYBData.entities,
                  selectedValue: _selectedEntity,
                ),
              );
              _onDropSelected(result, () => _selectedEntity = result);
            },
          ),
          CustomTextfield(
            labelText: 'Website',
            controller: _websiteController,
            keyboardType: TextInputType.url,
            validator: (v) =>
                v != null && v.trim().isNotEmpty && !Validators.isValidUrl(v)
                ? 'Enter a valid URL'
                : null,
          ),
          CustomTextfield(
            labelText: 'Phone Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (v) => Validators.isValidPhone(v),
          ),
          CustomTextfield(
            labelText: 'Business Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => Validators.isValidEmail(v),
          ),
          CustomTextfield(
            labelText: 'Address 1',
            controller: _address1Controller,
            keyboardType: TextInputType.streetAddress,
            validator: (v) => Validators.isNotEmpty(v, 'Address'),
          ),
          CustomTextfield(
            labelText: 'Address 2',
            controller: _address2Controller,
            keyboardType: TextInputType.streetAddress,
          ),
          CustomTextfield(
            labelText: 'City',
            controller: _cityController,
            keyboardType: TextInputType.text,
            validator: (v) => Validators.isNotEmpty(v, 'City'),
          ),
          CustomTextfield(
            labelText: 'State',
            controller: _stateController,
            keyboardType: TextInputType.text,
            validator: (v) => Validators.isNotEmpty(v, 'State'),
          ),
          CustomTextfield(
            labelText: 'Country',
            hintText: 'Select Country',
            hasDrop: true,
            controller: TextEditingController(text: _selectedCountry ?? ''),
            validator: (_) =>
                _selectedCountry == null ? 'Please select a country' : null,
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Country',
                child: DialogContent(
                  items: MockKYBData.countries,
                  selectedValue: _selectedCountry,
                ),
              );
              _onDropSelected(result, () => _selectedCountry = result);
            },
          ),
          CustomTextfield(
            labelText: 'Zip Code',
            controller: _zipCodeController,
            keyboardType: TextInputType.number,
            validator: (v) => Validators.isNotEmpty(v, 'Zip code'),
          ),
          69.fhs,
          CustomButton(
            onTap: _onContinue,
            text: 'Continue',
            enabledListenable: _canProceed,
          ),
          16.fhs,
          Center(
            child: TextWidget(
              text: 'Create Personal Account',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                color: AppColors.belyftedPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          9.fhs,
        ],
      ),
    );
  }
}

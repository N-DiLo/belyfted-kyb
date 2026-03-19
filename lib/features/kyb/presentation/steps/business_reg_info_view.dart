import 'package:belyfted/belyfted.dart';

class BusinessRegInfoView extends ConsumerStatefulWidget {
  const BusinessRegInfoView({super.key, required this.pageController});

  final PageController pageController;

  @override
  ConsumerState<BusinessRegInfoView> createState() =>
      _BusinessRegInfoViewState();
}

class _BusinessRegInfoViewState extends ConsumerState<BusinessRegInfoView> {
  @override
  void initState() {
    super.initState();
    for (final c in _requiredControllers) {
      c.addListener(_updateCanProceed);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _canProceed = ValueNotifier<bool>(false);

  List<TextEditingController> get _requiredControllers => [
    _businessNameController,
    _taxController,
    _descController,
  ];

  void _updateCanProceed() {
    final allFilled = _requiredControllers.every(
      (c) => c.text.trim().isNotEmpty,
    );
    final allDropdowns =
        _selectedYear != null &&
        _selectedScope != null &&
        _selectedCountry != null;

    _canProceed.value = allFilled && allDropdowns;
  }

  final _businessNameController = TextEditingController();
  final _taxController = TextEditingController();
  final _descController = TextEditingController();

  String? _selectedYear;
  String? _selectedScope;
  String? _selectedCountry;

  @override
  void dispose() {
    for (final c in _requiredControllers) {
      c.removeListener(_updateCanProceed);
    }
    _canProceed.dispose();
    _businessNameController.dispose();
    _taxController.dispose();
    _descController.dispose();
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
          .updateRegInfo(
            taxID: _taxController.text.trim(),
            businessDesc: _descController.text.trim(),
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
            labelText: 'Registered Year',
            hintText: 'Select Registered Year',
            hasDrop: true,
            controller: TextEditingController(text: _selectedYear ?? ''),
            validator: (_) =>
                _selectedYear == null ? 'Please select a year' : null,
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Year',
                child: DialogContent(
                  items: MockKYBData.years,
                  selectedValue: _selectedYear,
                ),
              );
              _onDropSelected(result, () => _selectedYear = result);
            },
          ),
          CustomTextfield(
            labelText: 'Business Name',
            controller: _businessNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: (v) => Validators.isNotEmpty(v, 'Business name'),
          ),
          CustomTextfield(
            labelText: 'Tax/VAT ID',
            controller: _taxController,
            keyboardType: TextInputType.number,
            validator: (v) => Validators.isNotEmpty(v, 'Tax/VAT ID'),
          ),
          CustomTextfield(
            labelText: 'Business Scope',
            hintText: 'Select Business Scope',
            hasDrop: true,
            controller: TextEditingController(text: _selectedScope ?? ''),
            validator: (_) => _selectedScope == null
                ? 'Please select a business scope'
                : null,
            onTap: () async {
              final result = await CustomDialog.show<String>(
                context: context,
                title: 'Business Scope',
                child: DialogContent(
                  items: MockKYBData.scope,
                  selectedValue: _selectedScope,
                ),
              );
              _onDropSelected(result, () => _selectedScope = result);
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
            onTap: _onContinue,
            text: 'Continue',
            enabledListenable: _canProceed,
          ),
          16.fhs,
        ],
      ),
    );
  }
}

import 'package:belyfted/belyfted.dart';

class BusinessInfoView extends StatefulWidget {
  const BusinessInfoView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<BusinessInfoView> createState() => _BusinessInfoViewState();
}

class _BusinessInfoViewState extends State<BusinessInfoView> {
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

  @override
  void dispose() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        ),
        CustomTextfield(
          labelText: 'First Name',
          controller: _firstNameController,
        ),
        CustomTextfield(
          labelText: 'Last Name',
          controller: _lastNameController,
        ),
        CustomTextfield(
          labelText: 'Business Type',
          hintText: 'Select Business Type',
          controller: TextEditingController(text: _selectedBusinessType ?? ''),
          hasDrop: true,
          onTap: () async {
            final result = await CustomDialog.show<String>(
              context: context,
              title: 'Business Type',
              child: DialogContent(
                items: MockKYBData.businessTypes,
                selectedValue: _selectedBusinessType,
              ),
            );
            if (result != null) setState(() => _selectedBusinessType = result);
          },
        ),
        CustomTextfield(
          labelText: 'Industry',
          hintText: 'Select Industry',
          hasDrop: true,
          controller: TextEditingController(text: _selectedIndustry ?? ''),
          onTap: () async {
            final result = await CustomDialog.show<String>(
              context: context,
              title: 'Industry',
              child: DialogContent(
                items: MockKYBData.industries,
                selectedValue: _selectedIndustry,
              ),
            );
            if (result != null) setState(() => _selectedIndustry = result);
          },
        ),
        CustomTextfield(
          labelText: 'Entity',
          hintText: 'Select Entity',
          hasDrop: true,
          controller: TextEditingController(text: _selectedEntity ?? ''),
          onTap: () async {
            final result = await CustomDialog.show<String>(
              context: context,
              title: 'Entity',
              child: DialogContent(
                items: MockKYBData.entities,
                selectedValue: _selectedEntity,
              ),
            );
            if (result != null) setState(() => _selectedEntity = result);
          },
        ),
        CustomTextfield(
          labelText: 'Website',
          controller: _websiteController,
          keyboardType: TextInputType.url,
        ),
        CustomTextfield(
          labelText: 'Phone Number',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
        ),
        CustomTextfield(
          labelText: 'Business Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        CustomTextfield(
          labelText: 'Address 1',
          controller: _address1Controller,
        ),
        CustomTextfield(
          labelText: 'Address 2',
          controller: _address2Controller,
        ),
        CustomTextfield(labelText: 'City', controller: _cityController),
        CustomTextfield(labelText: 'State', controller: _stateController),
        CustomTextfield(
          labelText: 'Country',
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
          labelText: 'Zip Code',
          controller: _zipCodeController,
          keyboardType: TextInputType.number,
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
    );
  }
}

import 'package:belyfted/belyfted.dart';

class BeneficiaryOfficerView extends StatefulWidget {
  const BeneficiaryOfficerView({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<BeneficiaryOfficerView> createState() => _BeneficiaryOfficerViewState();
}

class _BeneficiaryOfficerViewState extends State<BeneficiaryOfficerView> {
  late final List<DirectorItem> _directors;
  bool _showAddForm = false;
  int? _editingIndex;

  @override
  void initState() {
    super.initState();
    _directors = List.from(MockKYBData.seedDirectors);
  }

  bool get _canContinue => _directors.isNotEmpty;

  void _openAddForm() => setState(() {
    _showAddForm = true;
    _editingIndex = null;
  });

  void _openEditForm(int index) => setState(() {
    _showAddForm = true;
    _editingIndex = index;
  });

  void _closeForm() => setState(() {
    _showAddForm = false;
    _editingIndex = null;
  });

  void _onDirectorSaved(DirectorItem director) {
    setState(() {
      if (_editingIndex != null) {
        _directors[_editingIndex!] = director;
      } else {
        _directors.add(director);
      }
      _showAddForm = false;
      _editingIndex = null;
    });
  }

  void _deleteDirector(int index) => setState(() => _directors.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: ps(h: 16),
      children: [
        24.fhs,
        TextWidget(
          text: 'Ultimate Beneficiary Officer',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        TextWidget(
          text: 'Add business directors and owners',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          textColor: AppColors.belyftedNeutralColor,
        ),
        32.fhs,

        Visibility(
          visible: !_showAddForm,
          child: Column(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(12.r),
                  dashPattern: const [6, 4],
                  color: AppColors.belyftedPrimaryColor.shade500,
                  strokeWidth: 0.5,
                ),
                child: Container(
                  width: double.infinity,
                  padding: 16.pa,
                  decoration: BoxDecoration(
                    color: AppColors.belyftedPrimaryColor.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Total Directors',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            textColor: AppColors.belyftedPrimaryColor.shade500,
                          ),
                          TextWidget(
                            text: '${_directors.length}',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            textColor: AppColors.belyftedPrimaryColor.shade500,
                          ),
                        ],
                      ),
                      ImageWidget(url: AppImages.profileUser),
                    ],
                  ),
                ),
              ),
              24.fhs,
            ],
          ),
        ),

        ..._directors.asMap().entries.map((entry) {
          final index = entry.key;
          final director = entry.value;
          return Visibility(
            visible: !_showAddForm,
            child: Padding(
              padding: po(b: 24),
              child: DirectorCard(
                director: director,
                onEdit: () => _openEditForm(index),
                onDelete: _directors.length > 1
                    ? () => _deleteDirector(index)
                    : null,
              ),
            ),
          );
        }),

        Visibility(
          visible: _showAddForm,
          maintainState: true,
          child: Padding(
            padding: po(b: 24),
            child: NewDirectorDetails(
              initialDirector: _editingIndex != null
                  ? _directors[_editingIndex!]
                  : null,
              onSaved: _onDirectorSaved,
              onCancel: _closeForm,
            ),
          ),
        ),

        Visibility(
          visible: !_showAddForm,
          child: DottedBorderButton(label: 'Add Director', onTap: _openAddForm),
        ),

        _directors.length < 2 ? 290.fhs : 69.fhs,

        Visibility(
          visible: !_showAddForm,
          child: CustomButton(
            enabled: _canContinue,
            onTap: _canContinue
                ? () async => widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
                : null,
            text: 'Continue',
          ),
        ),
        73.fhs,
      ],
    );
  }
}

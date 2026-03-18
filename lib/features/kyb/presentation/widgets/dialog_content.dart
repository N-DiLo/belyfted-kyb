import 'package:belyfted/belyfted.dart';

class DialogContent extends StatefulWidget {
  const DialogContent({super.key, required this.items, this.selectedValue});

  final List<String> items;
  final String? selectedValue;

  @override
  State<DialogContent> createState() => _SelectionDialogContentState();
}

class _SelectionDialogContentState extends State<DialogContent> {
  late List<String> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? widget.items
          : widget.items
                .where((i) => i.toLowerCase().contains(query.toLowerCase()))
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextfield(
          controller: _searchController,
          hintText: 'Search...',
          onChanged: _onSearch,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.belyftedNeutralColor.shade500,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300.r),
          child: _filtered.isEmpty
              ? Padding(
                  padding: 24.pa,
                  child: TextWidget(
                    text: 'No results found',
                    textColor: AppColors.belyftedNeutralColor.shade500,
                    fontSize: 14,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: _filtered.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: AppColors.belyftedNeutralColor.shade200,
                  ),
                  itemBuilder: (_, index) {
                    final item = _filtered[index];
                    final isSelected = item == widget.selectedValue;
                    return ListTile(
                      dense: true,
                      onTap: () => navigations.pop(item),
                      title: TextWidget(
                        text: item,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        textColor: isSelected
                            ? AppColors.belyftedPrimaryColor
                            : AppColors.belyftedNeutralColor.shade800,
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check,
                              size: 16.r,
                              color: AppColors.belyftedPrimaryColor,
                            )
                          : null,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

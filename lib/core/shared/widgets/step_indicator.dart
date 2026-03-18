import 'package:belyfted/belyfted.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(totalPages, (index) {
        final step = index + 1;
        final isCompleted = step < currentPage;
        final isActive = step == currentPage;

        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 28.r,
              width: 28.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.belyftedGreenColor
                    : isActive
                    ? AppColors.belyftedPrimaryColor
                    : AppColors.belyftedNeutralColor.shade200,
              ),
              child: Center(
                child: isCompleted
                    ? Icon(Icons.check, size: 14.r, color: Colors.white)
                    : TextWidget(
                        text: '$step',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: isActive
                            ? AppColors.whiteColor
                            : AppColors.belyftedPrimaryColor.shade300,
                      ),
              ),
            ),
            if (step < totalPages)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 84.r,
                height: 1,
                color: step < currentPage
                    ? AppColors.belyftedPrimaryColor.shade50
                    : AppColors.belyftedPrimaryColor.shade50,
              ),
          ],
        );
      }),
    );
  }
}

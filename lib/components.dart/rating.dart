part of 'components.dart';

class RatingViewer extends StatelessWidget {
  const RatingViewer({required this.rating, this.size = 19, super.key});
  final ProductRating rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Row(
          children: List.generate(5, (index) {
            return SvgPicture.asset(
              'assets/images/star.svg',
              height: size,
              width: size,
              colorFilter: const ColorFilter.mode(
                Color(0xFFE4E4E4),
                BlendMode.srcIn,
              ),
            );
          }),
        ),
        Positioned.fill(
          child: Row(
            children: List.generate(rating.rate.toInt(), (index) {
              return SvgPicture.asset(
                'assets/images/star.svg',
                height: size,
                width: size,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFE072),
                  BlendMode.srcIn,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

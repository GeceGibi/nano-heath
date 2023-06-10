part of 'components.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({required this.product, this.onTap, super.key});
  final Product product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.6,
                child: AdaptiveImage(
                  product.image,
                  backgroundColor: const Color(0x11000000),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    RatingViewer(rating: product.rating)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 18),
          Text(
            product.title,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

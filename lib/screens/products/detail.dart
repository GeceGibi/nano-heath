import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nano/components.dart/components.dart';
import 'package:nano/models/product.dart';
import 'package:nano/repos/repos.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(this.productId, {super.key});
  final int productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var isOpenCard = false;

  Product? product;

  Future<void> getData() async {
    product = await ProductRepo.instance.getDetail(widget.productId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Builder(builder: (context) {
            if (product == null) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            return Column(
              children: [
                SizedBox(height: mediaQuery.padding.top + kToolbarHeight),
                Expanded(child: AdaptiveImage(product!.image)),
                AnimatedSize(
                  duration: const Duration(milliseconds: 350),
                  alignment: Alignment.topCenter,
                  curve: Curves.easeOutQuart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Text(
                          '\$${product!.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: Color(0xff2A404B),
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Color.fromRGBO(107, 127, 153, 0.25),
                            )
                          ],
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 14)
                              .copyWith(bottom: mediaQuery.padding.bottom + 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isOpenCard = !isOpenCard;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Center(
                                    child: RotatedBox(
                                      quarterTurns: isOpenCard ? 2 : 0,
                                      child: SvgPicture.asset(
                                        'assets/images/arrow-up.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  ShadowedIconButton(
                                    onTap: () {},
                                    icon: SvgPicture.asset(
                                      'assets/images/share.svg',
                                    ),
                                  ),
                                  const SizedBox(width: 40),
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                          EdgeInsets.all(20),
                                        ),
                                      ),
                                      child: const Text('Order Now'),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product!.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff838396),
                                ),
                              ),
                              if (isOpenCard) ...[
                                const SizedBox(height: 8),
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Color(0xfff1f1f1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Reviews (${product!.rating.count})',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${product!.rating.rate}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 32,
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              RatingViewer(
                                                rating: product!.rating,
                                                size: 32,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
          const Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: DetailScreenAppBar(),
          )
        ],
      ),
    );
  }
}

class DetailScreenAppBar extends StatelessWidget {
  const DetailScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.6),
              Color.fromRGBO(0, 0, 0, 0.0001),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9).copyWith(
            top: MediaQuery.of(context).padding.top,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/images/more-dots.svg'),
                  ),
                ],
              ),
              const Text(
                'Detail',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

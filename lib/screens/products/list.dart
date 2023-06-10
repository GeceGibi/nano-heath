import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nano/components.dart/components.dart';
import 'package:nano/models/product.dart';
import 'package:nano/repos/repos.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final products = <Product>[];

  Future<void> getData() async {
    products.addAll(await ProductRepo.instance.getList());
    setState(() {});
  }

  void onTapItemHandler(Product product) {
    Navigator.of(context).pushNamed(
      '/product-detail',
      arguments: product.id,
    );
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: const ListAppBar(),
        bottomNavigationBar: AppHomeNavigationBar(),
        body: ListView.separated(
          padding: const EdgeInsets.all(26),
          separatorBuilder: (context, index) {
            return const Divider(
              height: 52,
              color: Color(0xffD8D8D8),
            );
          },
          itemCount: products.length,
          itemBuilder: (context, index) {
            ///
            final product = products[index];

            ///
            return ProductListItem(
              product: product,
              onTap: () => onTapItemHandler(product),
            );
          },
        ),
      ),
    );
  }
}

class ListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Color.fromRGBO(107, 127, 153, 0.25),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 22,
        ),
        child: const Text(
          'All Products',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class AppHomeNavigationBar extends StatelessWidget {
  const AppHomeNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.05),
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset('assets/images/home.svg'),
              SvgPicture.asset('assets/images/cart.svg'),
              SvgPicture.asset('assets/images/like.svg'),
              SvgPicture.asset('assets/images/user.svg'),
            ],
          ),
        ),
      ),
    );
  }
}

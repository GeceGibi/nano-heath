part of 'components.dart';

class ShadowedIconButton extends StatelessWidget {
  const ShadowedIconButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final void Function() onTap;

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
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: icon,
      ),
    );
  }
}

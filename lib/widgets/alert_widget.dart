import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  final Color iconColor;
  final String text;
  final void Function()? onTap;

  const AlertWidget({
    Key? key,
    required this.iconColor,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              color: iconColor,
              size: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            if (onTap != null)
              TextButton(
                onPressed: onTap,
                child: Text(
                  'Aperte aqui para tentar novamente'.toUpperCase(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/utils/app_images.dart';
import 'package:kakas_task/core/utils/styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;
  Timer? timer;

  startTime() async {
    var duration = const Duration(seconds: 3);
    timer = Timer(duration, navigationPage);
    return timer;
  }

  void navigationPage() {
    GoRouter.of(context).pushReplacement(RoutesPath.kLoginView);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
    if (timer != null) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AppImages.logo,
                  fit: BoxFit.cover,
                  width: animation!.value * 130,
                  height: animation!.value * 130,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Recepo',
                style: Styles.textStyle24,
              )
            ],
          ),
        ],
      ),
    );
  }
}

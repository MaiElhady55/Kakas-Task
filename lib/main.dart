import 'package:flutter/material.dart';
import 'package:kakas_task/core/network/local/cache_helper.dart';
import 'package:kakas_task/core/network/remote/dio_helper.dart';
import 'package:kakas_task/core/routes/app_router.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/features/product/presentation/view_models/product_providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp.router(
        title: 'Kakas Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          scaffoldBackgroundColor: AppColors.kScaffoldBGColor,
          primaryColor: AppColors.kPrimaryColor,
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/features/auth/presentation/views/login_view.dart';
import 'package:kakas_task/features/auth/presentation/views/sign_up_view.dart';
import 'package:kakas_task/features/product/data/models/product_model.dart';
import 'package:kakas_task/features/product/presentation/views/add_product_view.dart';
import 'package:kakas_task/features/product/presentation/views/edit_product_view.dart';
import 'package:kakas_task/features/product/presentation/views/products_view.dart';
import 'package:kakas_task/features/product/presentation/views/search_product_view.dart';
import 'package:kakas_task/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
          path: RoutesPath.kSplashView,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashView()),
      GoRoute(
        path: RoutesPath.kLoginView,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginView(),
      ),
      GoRoute(
        path: RoutesPath.kSignUpView,
        builder: (BuildContext context, GoRouterState state) =>
            const SignUpView(),
      ),
      GoRoute(
        path: RoutesPath.kProductsView,
        builder: (BuildContext context, GoRouterState state) =>
            const ProductsView(),
      ),
      GoRoute(
        path: RoutesPath.kAddProductView,
        builder: (BuildContext context, GoRouterState state) =>
            const AddProductView(),
      ),
      GoRoute(
          path: RoutesPath.kEditProductView,
          builder: (BuildContext context, GoRouterState state) {
            ProductModel productModel = state.extra as ProductModel;
            return EditProductView(productModel: productModel);
          }),
      GoRoute(
          path: RoutesPath.kSearchProductView,
          builder: (BuildContext context, GoRouterState state) {
            String searchText = state.extra as String;
            return SearchProductView(
              searchText: searchText,
            );
          }),
    ],
  );
}

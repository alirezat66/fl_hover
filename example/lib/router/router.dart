import 'package:example/data/showcase_data.dart';
import 'package:example/play_ground_page.dart';
import 'package:example/showcase_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The router configuration for the app.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    // The home route, which displays the main showcase page.
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ShowcasePage();
      },
      routes: <RouteBase>[
        // The details route, which displays the playground for a specific widget.
        // It uses a path parameter 'widgetName' to identify the widget.
        GoRoute(
          path: 'details/:widgetName',
          builder: (BuildContext context, GoRouterState state) {
            final showcaseItems = ShowcaseData.items;
            final widgetName = state.pathParameters['widgetName']!;
            final item =
                showcaseItems.firstWhere((item) => item.name == widgetName);

            return PlaygroundPage(
              title: item.name,
              initialTheme: item.initialTheme,
              widgetBuilder: item.widgetBuilder,
            );
          },
        ),
      ],
    ),
  ],
);

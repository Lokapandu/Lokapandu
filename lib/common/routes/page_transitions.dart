import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom page transitions for smooth navigation animations
class PageTransitions {
  /// Fade transition - smooth opacity change
  static Page<T> fadeTransition<T extends Object?>(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  /// Slide transition from right to left
  static Page<T> slideFromRightTransition<T extends Object?>(
    Widget child, {
    Duration duration = const Duration(milliseconds: 350),
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Slide transition from bottom to top
  static Page<T> slideFromBottomTransition<T extends Object?>(
    Widget child, {
    Duration duration = const Duration(milliseconds: 400),
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Scale transition with fade - elegant zoom effect
  static Page<T> scaleTransition<T extends Object?>(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutBack;
        
        return ScaleTransition(
          scale: CurveTween(curve: curve).animate(animation),
          child: FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  /// Slide and fade combination - very smooth
  static Page<T> slideAndFadeTransition<T extends Object?>(
    Widget child, {
    Duration duration = const Duration(milliseconds: 350),
    String? name,
    Object? arguments,
    String? restorationId,
    Offset beginOffset = const Offset(0.3, 0.0),
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var slideTween = Tween(begin: beginOffset, end: end).chain(
          CurveTween(curve: curve),
        );

        var fadeTween = CurveTween(curve: Curves.easeInOut);

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
    );
  }

  /// No transition - instant navigation
  static Page<T> noTransition<T extends Object?>(
    Widget child, {
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return NoTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
    );
  }
}
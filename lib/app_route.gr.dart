// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:collection/collection.dart' as _i5;
import 'package:demodoumentation/features/auth/presentation/pages/sign_in_page.dart'
    as _i1;
import 'package:demodoumentation/features/auth/presentation/pages/user_details_page.dart'
    as _i2;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.SignInPage]
class SignInRoute extends _i3.PageRouteInfo<void> {
  const SignInRoute({List<_i3.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.SignInPage();
    },
  );
}

/// generated route for
/// [_i2.UserDetailsPage]
class UserDetailsRoute extends _i3.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i4.Key? key,
    Map<String, dynamic>? userInfo,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         UserDetailsRoute.name,
         args: UserDetailsRouteArgs(key: key, userInfo: userInfo),
         initialChildren: children,
       );

  static const String name = 'UserDetailsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserDetailsRouteArgs>(
        orElse: () => const UserDetailsRouteArgs(),
      );
      return _i2.UserDetailsPage(key: args.key, userInfo: args.userInfo);
    },
  );
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({this.key, this.userInfo});

  final _i4.Key? key;

  final Map<String, dynamic>? userInfo;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, userInfo: $userInfo}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserDetailsRouteArgs) return false;
    return key == other.key &&
        const _i5.MapEquality<String, dynamic>().equals(
          userInfo,
          other.userInfo,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i5.MapEquality<String, dynamic>().hash(userInfo);
}

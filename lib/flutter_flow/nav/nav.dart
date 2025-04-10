import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : Auth2Widget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : Auth2Widget(),
        ),
        FFRoute(
          name: TrackLocationWidget.routeName,
          path: TrackLocationWidget.routePath,
          builder: (context, params) => TrackLocationWidget(),
        ),
        FFRoute(
          name: MapWidget.routeName,
          path: MapWidget.routePath,
          builder: (context, params) => MapWidget(),
        ),
        FFRoute(
          name: DriverInformationWidget.routeName,
          path: DriverInformationWidget.routePath,
          asyncParams: {
            'name': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'schoolName': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'licenseN': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'photo': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'experience': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'email': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'certifications': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'serviceArea': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'schedule': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'phone': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'emergencyNumber': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'routeNumber': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'numberBus': getDoc(['Driver'], DriverRecord.fromSnapshot),
          },
          builder: (context, params) => DriverInformationWidget(
            name: params.getParam(
              'name',
              ParamType.Document,
            ),
            schoolName: params.getParam(
              'schoolName',
              ParamType.Document,
            ),
            licenseN: params.getParam(
              'licenseN',
              ParamType.Document,
            ),
            photo: params.getParam(
              'photo',
              ParamType.Document,
            ),
            experience: params.getParam(
              'experience',
              ParamType.Document,
            ),
            email: params.getParam(
              'email',
              ParamType.Document,
            ),
            certifications: params.getParam(
              'certifications',
              ParamType.Document,
            ),
            serviceArea: params.getParam(
              'serviceArea',
              ParamType.Document,
            ),
            schedule: params.getParam(
              'schedule',
              ParamType.Document,
            ),
            phone: params.getParam(
              'phone',
              ParamType.Document,
            ),
            emergencyNumber: params.getParam(
              'emergencyNumber',
              ParamType.Document,
            ),
            routeNumber: params.getParam(
              'routeNumber',
              ParamType.Document,
            ),
            numberBus: params.getParam(
              'numberBus',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          asyncParams: {
            'name': getDoc(['users'], UsersRecord.fromSnapshot),
            'email': getDoc(['users'], UsersRecord.fromSnapshot),
            'phone': getDoc(['users'], UsersRecord.fromSnapshot),
            'city': getDoc(['users'], UsersRecord.fromSnapshot),
            'photo': getDoc(['users'], UsersRecord.fromSnapshot),
          },
          builder: (context, params) => ProfileWidget(
            name: params.getParam(
              'name',
              ParamType.Document,
            ),
            email: params.getParam(
              'email',
              ParamType.Document,
            ),
            phone: params.getParam(
              'phone',
              ParamType.Document,
            ),
            city: params.getParam(
              'city',
              ParamType.Document,
            ),
            photo: params.getParam(
              'photo',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: EditProfileWidget.routeName,
          path: EditProfileWidget.routePath,
          asyncParams: {
            'name': getDoc(['users'], UsersRecord.fromSnapshot),
            'email': getDoc(['users'], UsersRecord.fromSnapshot),
            'city': getDoc(['users'], UsersRecord.fromSnapshot),
            'phone': getDoc(['users'], UsersRecord.fromSnapshot),
            'photo': getDoc(['users'], UsersRecord.fromSnapshot),
          },
          builder: (context, params) => EditProfileWidget(
            name: params.getParam(
              'name',
              ParamType.Document,
            ),
            email: params.getParam(
              'email',
              ParamType.Document,
            ),
            city: params.getParam(
              'city',
              ParamType.Document,
            ),
            phone: params.getParam(
              'phone',
              ParamType.Document,
            ),
            photo: params.getParam(
              'photo',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: ChangePasswordWidget.routeName,
          path: ChangePasswordWidget.routePath,
          builder: (context, params) => ChangePasswordWidget(),
        ),
        FFRoute(
          name: DriversWidget.routeName,
          path: DriversWidget.routePath,
          builder: (context, params) => DriversWidget(),
        ),
        FFRoute(
          name: TripsWidget.routeName,
          path: TripsWidget.routePath,
          builder: (context, params) => TripsWidget(),
        ),
        FFRoute(
          name: SchoolWidget.routeName,
          path: SchoolWidget.routePath,
          builder: (context, params) => SchoolWidget(),
        ),
        FFRoute(
          name: LocationWidget.routeName,
          path: LocationWidget.routePath,
          builder: (context, params) => LocationWidget(),
        ),
        FFRoute(
          name: CertificationsWidget.routeName,
          path: CertificationsWidget.routePath,
          builder: (context, params) => CertificationsWidget(),
        ),
        FFRoute(
          name: IndexWidget.routeName,
          path: IndexWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'Index') : IndexWidget(),
        ),
        FFRoute(
          name: CreateDriverWidget.routeName,
          path: CreateDriverWidget.routePath,
          builder: (context, params) => CreateDriverWidget(),
        ),
        FFRoute(
          name: EditDriverWidget.routeName,
          path: EditDriverWidget.routePath,
          asyncParams: {
            'name': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'school': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'licenseNumber': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'experience': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'phione': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'email': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'emergencyPhone': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'certifications': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'routeNumber': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'serviceArea': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'schedule': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'photo': getDoc(['Driver'], DriverRecord.fromSnapshot),
            'numberBus': getDoc(['Driver'], DriverRecord.fromSnapshot),
          },
          builder: (context, params) => EditDriverWidget(
            name: params.getParam(
              'name',
              ParamType.Document,
            ),
            school: params.getParam(
              'school',
              ParamType.Document,
            ),
            licenseNumber: params.getParam(
              'licenseNumber',
              ParamType.Document,
            ),
            experience: params.getParam(
              'experience',
              ParamType.Document,
            ),
            phione: params.getParam(
              'phione',
              ParamType.Document,
            ),
            email: params.getParam(
              'email',
              ParamType.Document,
            ),
            emergencyPhone: params.getParam(
              'emergencyPhone',
              ParamType.Document,
            ),
            certifications: params.getParam(
              'certifications',
              ParamType.Document,
            ),
            routeNumber: params.getParam(
              'routeNumber',
              ParamType.Document,
            ),
            serviceArea: params.getParam(
              'serviceArea',
              ParamType.Document,
            ),
            schedule: params.getParam(
              'schedule',
              ParamType.Document,
            ),
            photo: params.getParam(
              'photo',
              ParamType.Document,
            ),
            numberBus: params.getParam(
              'numberBus',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: UsersWidget.routeName,
          path: UsersWidget.routePath,
          builder: (context, params) => UsersWidget(),
        ),
        FFRoute(
          name: RegisterSonWidget.routeName,
          path: RegisterSonWidget.routePath,
          builder: (context, params) => RegisterSonWidget(),
        ),
        FFRoute(
          name: EditRegisterforTransportationWidget.routeName,
          path: EditRegisterforTransportationWidget.routePath,
          asyncParams: {
            'schoolName': getDoc(['School'], SchoolRecord.fromSnapshot),
            'type': getDoc(['School'], SchoolRecord.fromSnapshot),
            'location': getDoc(['School'], SchoolRecord.fromSnapshot),
            'photo': getDoc(['School'], SchoolRecord.fromSnapshot),
          },
          builder: (context, params) => EditRegisterforTransportationWidget(
            schoolName: params.getParam(
              'schoolName',
              ParamType.Document,
            ),
            type: params.getParam(
              'type',
              ParamType.Document,
            ),
            location: params.getParam(
              'location',
              ParamType.Document,
            ),
            photo: params.getParam(
              'photo',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: Auth2Widget.routeName,
          path: Auth2Widget.routePath,
          builder: (context, params) => Auth2Widget(),
        ),
        FFRoute(
          name: UserEditWidget.routeName,
          path: UserEditWidget.routePath,
          builder: (context, params) => UserEditWidget(
            imageParameter: params.getParam(
              'imageParameter',
              ParamType.String,
            ),
            emailParameter: params.getParam(
              'emailParameter',
              ParamType.String,
            ),
            userName: params.getParam(
              'userName',
              ParamType.String,
            ),
            phoneParameter: params.getParam(
              'phoneParameter',
              ParamType.String,
            ),
            roleParameter: params.getParam(
              'roleParameter',
              ParamType.String,
            ),
            roleSwitchParameter: params.getParam(
              'roleSwitchParameter',
              ParamType.bool,
            ),
            userSelectionParameter: params.getParam(
              'userSelectionParameter',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['users'],
            ),
          ),
        ),
        FFRoute(
          name: Chat2DetailsWidget.routeName,
          path: Chat2DetailsWidget.routePath,
          asyncParams: {
            'chatRef': getDoc(['chats'], ChatsRecord.fromSnapshot),
          },
          builder: (context, params) => Chat2DetailsWidget(
            chatRef: params.getParam(
              'chatRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: Chat2MainWidget.routeName,
          path: Chat2MainWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'chat_2_main')
              : Chat2MainWidget(),
        ),
        FFRoute(
          name: Chat2InviteUsersWidget.routeName,
          path: Chat2InviteUsersWidget.routePath,
          asyncParams: {
            'chatRef': getDoc(['chats'], ChatsRecord.fromSnapshot),
          },
          builder: (context, params) => Chat2InviteUsersWidget(
            chatRef: params.getParam(
              'chatRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: ImageDetailsWidget.routeName,
          path: ImageDetailsWidget.routePath,
          asyncParams: {
            'chatMessage':
                getDoc(['chat_messages'], ChatMessagesRecord.fromSnapshot),
          },
          builder: (context, params) => ImageDetailsWidget(
            chatMessage: params.getParam(
              'chatMessage',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CreateUserWidget.routeName,
          path: CreateUserWidget.routePath,
          builder: (context, params) => CreateUserWidget(),
        ),
        FFRoute(
          name: UserPasswordWidget.routeName,
          path: UserPasswordWidget.routePath,
          builder: (context, params) => UserPasswordWidget(),
        ),
        FFRoute(
          name: ModifyUserDestinationsWidget.routeName,
          path: ModifyUserDestinationsWidget.routePath,
          builder: (context, params) => ModifyUserDestinationsWidget(),
        ),
        FFRoute(
          name: CreateSchoolWidget.routeName,
          path: CreateSchoolWidget.routePath,
          builder: (context, params) => CreateSchoolWidget(),
        ),
        FFRoute(
          name: CreateRoutesWidget.routeName,
          path: CreateRoutesWidget.routePath,
          builder: (context, params) => CreateRoutesWidget(),
        ),
        FFRoute(
          name: AdministratorWidget.routeName,
          path: AdministratorWidget.routePath,
          builder: (context, params) => AdministratorWidget(),
        ),
        FFRoute(
          name: DriversRoutesWidget.routeName,
          path: DriversRoutesWidget.routePath,
          builder: (context, params) => DriversRoutesWidget(),
        ),
        FFRoute(
          name: CreateStopsWidget.routeName,
          path: CreateStopsWidget.routePath,
          builder: (context, params) => CreateStopsWidget(),
        ),
        FFRoute(
          name: MapDriverWidget.routeName,
          path: MapDriverWidget.routePath,
          builder: (context, params) => MapDriverWidget(),
        ),
        FFRoute(
          name: RatingsWidget.routeName,
          path: RatingsWidget.routePath,
          builder: (context, params) => RatingsWidget(),
        ),
        FFRoute(
          name: AdminRating2Widget.routeName,
          path: AdminRating2Widget.routePath,
          builder: (context, params) => AdminRating2Widget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/auth2';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}

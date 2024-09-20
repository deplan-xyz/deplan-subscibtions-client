import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:deplan_subscriptions_client/screens/signin.dart';
import 'package:flutter/cupertino.dart';

class AppInitController extends StatefulWidget {
  const AppInitController({super.key});

  @override
  State<AppInitController> createState() => _AppInitControllerState();
}

class _AppInitControllerState extends State<AppInitController> {
  bool? hasQueryParams;
  String? orgId;
  String? redirectUrl;
  String? data;

  @override
  void initState() {
    super.initState();
    _handleQueryParameters(context);
  }

  void _handleQueryParameters(BuildContext ctx) {
    if (!ctx.mounted) {
      return;
    }
    final Uri uri = Uri.base;

    final Map<String, String> queryParams = uri.queryParameters;

    String? orgId = queryParams['orgId'];
    String? redirectUrl = queryParams['redirectUrl'];
    String? data = queryParams['data'];

    if (data != null && orgId != null && redirectUrl != null) {
      setState(() {
        hasQueryParams = true;
        this.orgId = orgId;
        this.redirectUrl = redirectUrl;
        this.data = data;
      });
    } else {
      setState(() {
        hasQueryParams = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasQueryParams == true) {
      return ConfirmSubsciption(
        orgId: orgId!,
        redirectUrl: redirectUrl!,
        data: data!,
      );
    }

    if (hasQueryParams == false) {
      return const Signin();
    }

    return const ScreenWrapper(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

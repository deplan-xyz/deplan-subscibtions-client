import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/api/base_api.dart';
import 'package:deplan_subscriptions_client/models/organization.dart';
import 'package:deplan_subscriptions_client/models/subscription.dart';
import 'package:dio/dio.dart';

class API extends BaseApi {
  API() : super();

  Future<Response> confirmSubscription(String orgId, String data) async {
    return await postRequest(
      '/events/subscription',
      body: {'orgId': orgId, 'data': data},
    );
  }

  Future<Organization> getOrganizationById(String id) async {
    final response = await getRequest('/org/$id');
    return Organization.fromJson(response.data);
  }

  Future<List<Subscription>> listSubscriptions(num date) async {
    final userId = Auth.currentUser?.uid;
    return await postRequest('/events/subscription/$userId',
        body: {'date': date});
  }

  Future<Subscription> subsciptionDetails(String orgId) async {
    final userId = Auth.currentUser?.uid;
    return await postRequest('/events/subscription/$userId',
        body: {'orgId': orgId});
  }
}

final API api = API();

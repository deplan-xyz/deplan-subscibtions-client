import 'package:deplan_subscriptions_client/api/base_api.dart';
import 'package:deplan_subscriptions_client/models/organization.dart';
import 'package:deplan_subscriptions_client/models/subscription.dart';
import 'package:deplan_subscriptions_client/models/subscription_details.dart';
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
    final response = await getRequest('/events?date=$date');
    return (response.data as List<dynamic>)
        .map((item) => Subscription.fromJson(item))
        .toList();
  }

  Future<List<SubscriptionDetailsModel>> subsciptionDetails(
      String orgId, num date) async {
    final response = await getRequest('/events/orgs/$orgId?date=$date');
    final fromJsonData = (response.data as List<dynamic>)
        .map((item) => SubscriptionDetailsModel.fromJson(item))
        .toList();
    return fromJsonData;
  }
}

final API api = API();

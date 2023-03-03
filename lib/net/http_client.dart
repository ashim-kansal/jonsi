import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/FaqModel.dart';
import 'package:kappu/models/serializable_model/Language.dart';
import 'package:kappu/models/serializable_model/NotificationModel.dart';
import 'package:kappu/models/serializable_model/RecommendedServiceProvidersResponse.dart';
import 'package:kappu/models/serializable_model/TrendingServicesResponse.dart';
import 'package:kappu/models/serializable_model/signup.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import '../models/serializable_model/AddOrderResponse.dart';
import '../models/serializable_model/HelpCenterResponse.dart';
import '../models/serializable_model/OrderListResponse.dart';
import '../models/serializable_model/PopularServiceListResponse.dart';
import '../models/serializable_model/PrivacyPolicyResponse.dart';
import '../models/serializable_model/ServiceResponse.dart';
import '../models/serializable_model/CategoryResponse.dart';
import '../models/serializable_model/allchats.dart';
import '../models/serializable_model/booking.dart';
import '../models/serializable_model/chat.dart';
import '../models/serializable_model/forget_password_response.dart';
import '../models/serializable_model/offer.dart';
import '../models/serializable_model/provider_detail_model.dart';
import '../models/serializable_model/provider_profile.dart';
import '../models/serializable_model/review.dart';
import '../models/serializable_model/thread_id.dart';
import 'base_dio.dart';
part 'http_client.g.dart';

@RestApi(baseUrl: "https://urbanmalta.com/api/")
abstract class HttpClient {
  factory HttpClient([Dio? dio, String? baseUrl]) {
    dio = BaseDio.getInstance().getDio();
    return _HttpClient(dio, baseUrl: baseUrl);
  }

  @POST('signup/')
  Future<UserSignUpModel?> signup(@Body() Map<String, dynamic> params);

  @POST('auth/poviderregister/')
  Future<HttpResponse?> providersignup(@Body() Map<String, dynamic> params, File gigpath);

  @POST('auth/customerregister')
  Future<HttpResponse?> userSignup(@Body() Map<String, dynamic> params, File file);

  @POST('user/profileimage')
  Future<HttpResponse?> UpdateUserProfilePic(File file);

  @POST('user/changepassword')
  Future<HttpResponse?> changePassword(String password);

  @POST('auth/login')
  Future<HttpResponse> signin(@Body() Map<String, dynamic> params);

  @POST('auth/login/social')
  Future<HttpResponse> signinSocial(@Body() Map<String, dynamic> params);

  @PATCH('provider/send-otp-email/{id}/')
  Future<HttpResponse> sendotpemail(@Path('id') String id);

  @PATCH('provider/send-otp-sms/{id}/')
  Future<HttpResponse> sendotpphno(@Path('id') String id);


  @PATCH('provider/verify-email/{id}/')
  Future<HttpResponse> varifyotp(
      @Path('id') String id, @Body() Map<String, dynamic> param);

  @POST('provider/forgot-password/')
  Future<ForgetPasswordResponse> varifyemail(
      @Body() Map<String, dynamic> param);

  @POST('provider/check-otp/')
  Future<HttpResponse> variftyemailOrPhoneOTP(
      @Body() Map<String, dynamic> params);

  @PATCH('provider/forgot-password/{id}/')
  Future<HttpResponse> resetpassword(
      @Path('id') String id, @Body() Map<String, dynamic> params);

  @GET('getservices')
  Future<ServiceResponse> getservicecatagory();

  @GET('allcat')
  Future<CategoryResponse> getCatagory();

  @GET('faqs')
  Future<List<FaqModel>> getFaqs();

  @GET('helpcenter')
  Future<List<HelpCenterResponse>> getHelpCenter();

  @GET('privacypolicy')
  Future<PrivacyPolicyResponse> getPrivayPolicy();

  @GET('getpopuplerservices')
  Future<List<PopularServiceListResponse>> getPopularServices();

  @GET('trending/profile')
  Future<List<TrendingServicesResponse>> getTrendingCatagory();

  @POST('services/byid')
  Future<List<RecommendedServiceProvidersResponse>> getRecommendedServiceProviders(categoryid);

  @POST('services/details')
  Future<List<ProviderDetailModel>> getServiceProviderDetail(serviceProviderId);

  @POST('services/recommended')
  Future<List<RecommendedServiceProvidersResponse>> getRelatedProviders(catId, serviceProviderId);

  @POST('user/notifications')
  Future<List<NotificationModel>> getNotifications(userId, token);

  @POST('orders/completed')
  Future<List<OrderListResponse>> getcompletedbooking(
      String provider_id, String token, String by);

  @POST('orders/cancelled')
  Future<List<OrderListResponse>> getCancelledbooking(
      String provider_id, String token, String by);

  @POST('orders/requests')
  Future<List<OrderListResponse>> getrequestedbookings(
      String provider_id, String token, String by);


  @POST('orders/accpeted')
  Future<List<OrderListResponse>> getActivebookings(
      String provider_id, String token, String by);


  @POST('order/add')
  Future<AddOrderResponse> addOrder(
      String location, String token, String total_price, String provider_id, String service_id, String user_id, String address, String currency, String service_fee);

  @POST('order/payment')
  Future<AddOrderResponse> orderPayment(String order_id);

  @POST('orders/provider/requests/accept')
  Future<AddOrderResponse> acceptOrder(String bookingId, String token);

  @POST('orders/provider/requests/cancel')
  Future<AddOrderResponse> cancelOrder(String bookingId, String token);

  @POST('orders/provider/requests/completed')
  Future<AddOrderResponse> completeOrder(String bookingId, String token);


  // @GET('category/{id}')
  // Future<Category> getservicecatagorynbyid(@Path('id') String id);

  @POST('service/')
  Future<HttpResponse> createoffer(@Body() Map<String, dynamic> params);

  @GET('service/')
  Future<List<Offers>> getoffersbycatagory(@Query('category') int catagoryid);

  @GET('list-service/')
  Future<List<Offers>> getprovideroffer(@Header("Authorization") String token);

  @GET('service/{id}')
  Future<Offers> getservicebyid(@Path('id') String id);

  @DELETE('service/{id}/')
  Future<HttpResponse> deleteservice(@Path('id') String id);

  @PATCH('service/{id}/')
  Future<HttpResponse> pauseorResumeservice(
      @Path('id') String id, @Body() Map<String, dynamic> params);

  @POST('booking/')
  Future<HttpResponse> createbookingrequest(
      @Header("Authorization") String token,
      @Body() Map<String, dynamic> params);

  @GET('booking/')
  Future<List<Booking>> getbookingrequest(
      @Header("Authorization") String token);


  @PATCH('booking-status/{id}/')
  Future<HttpResponse> acceptrejectbookingrequest(
      @Path('id') int id, @Body() Map<String, dynamic> params);

  @PATCH('booking-status/{id}/')
  Future<HttpResponse> cancelactivebooking(
      @Path('id') int id, @Body() Map<String, dynamic> params);

  @POST('get-signed-url/')
  Future<HttpResponse> updateprofilepic(@Body() Map<String, dynamic> params);

  @PATCH('profile/{id}/')
  Future<HttpResponse> updateprofile(
      @Path('id') String id, @Body() Map<String, dynamic> params);

  @GET('profile/{id}/')
  Future<HttpResponse> getuserprofilepic(@Path('id') String id);

  @POST('service-review/')
  Future<HttpResponse> addreview(@Body() Map<String, dynamic> params);

  @GET('provider-details/')
  Future<ProviderProfile> getproviderprofile(@Query('id') int id);

  @GET('service-review/')
  Future<List<Rating>> getproviderReviews(@Query('provider') int id);

  @GET('user/provider/rattings')
  Future<List<Rating>> getUserReviews();

  @GET('user/changename')
  Future<AddOrderResponse> updateName(String name);

  @POST('thread/')
  Future<Thread> gethread(@Body() Map<String, dynamic> params);

  @GET('/loadmessages/{threadid}/')
  Future<List<Chat>> getchatwithauser(@Path('threadid') String threadid);

  @GET('/conversation/{userid}/')
  Future<List<AllChats>> getallchats(@Path('userid') String userid);

  @GET('/provider/devices/{userid}/')
  Future<HttpResponse> checktoken(@Path('userid') String userid);

  @POST('/provider/devices/')
  Future<HttpResponse> addtoken(@Body() Map<String, dynamic> params);

  @PATCH('/provider/devices/{id}/')
  Future<HttpResponse> updatetoken(
      @Path('id') String id, @Body() Map<String, dynamic> params);
}

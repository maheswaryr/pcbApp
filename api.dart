import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

const baseUrl = "http://172.150.0.35:8081/pcbservice";

///demo server url
// const baseUrl = "http://61.2.45.238:8082/pcbservice";
// const baseUrl = "http://localhost:8081/pcbservice";

class API {
  //Login
  static Future getLogin(String encodedDate, Map<String, String> headers) {
    var url = baseUrl + "/login";
    return http.post(Uri.parse(url), body: encodedDate, headers: headers);
  }
  //getUserDetails
  static Future getUserDetails(String encodedDate, Map<String, String> headers) {
    var url = baseUrl + "/userDetails";
    return http.post(Uri.parse(url), body: encodedDate, headers: headers);
  }
  //SaveComplaintsDetails
  static Future saveComplaintDetailsService(String encodedDate, Map<String, String> headers) {
    var url = baseUrl + "/public/saveComplaintDetails";
    return http.post(Uri.parse(url),body: encodedDate,headers: headers);
  }
  //autoCompleteSearchQueryService
  static Future searchQueryService(Map<String, String> headers) {
    var url = baseUrl + "/public/complaintAutocomplete?searchQuery=/";
    return http.get(Uri.parse(url),headers: headers);
  }
  //trackComplaintService
  static Future trackComplaintService(String encodedData, Map<String, String> headers) {
    var url = baseUrl + "/public/trackComplaint";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }
  //submittedApplications
  static Future submittedApplications(Map<String, String> headers, var userId) {
    var url = baseUrl + "/submittedApplications/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getApplicationInfo
  static Future getApplicationInfo(Map<String, String> headers, var appId) {
    var url = baseUrl + "/getApplicationInfo/" + appId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getDraftApplicationsCount
  static Future getDraftApplicationsCount(Map<String, String> headers, var userId) {
    var url = baseUrl + "/getDraftApplicationsCount/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getSubmittedApplicationsCount
  static Future getSubmittedApplicationsCount(Map<String, String> headers, var userId) {
    var url = baseUrl + "/getSubmittedApplicationsCount/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getApprovedApplicationsCount
  static Future getApprovedApplicationsCount(Map<String, String> headers, var userId) {
    var url = baseUrl + "/getApprovedApplicationsCount/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getEstablishmentCount
  static Future getEstablishmentCount(Map<String, String> headers, var userId) {
    var url = baseUrl + "/getEstablishmentCount/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getEstablishmentList
  static Future getEstablishmentList(Map<String, String> headers, var userId) {
    var url = baseUrl + "/getEstablishmentList/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getInspectionList
  static Future getInspectionList(Map<String, String> headers, int allotId) {
    var url = baseUrl + "/inspectionList?allotId=" + allotId.toString();
    return http.get(Uri.parse(url), headers: headers);
  }
  //getInspectedApplicationCount
  static Future getInspectedApplicationCount(Map<String, String> headers, var userId) {
    var url = baseUrl + "/pcb/getSubmittedApplicationsCount/" + userId;
    return http.get(Uri.parse(url), headers: headers);
  }
  //getInspectionDetails
  static Future getInspectionDetails(Map<String, String> headers, int inspectionId) {
    var url = baseUrl + "/getInspectionDetails?inspectionId=" + inspectionId.toString();
    return http.get(Uri.parse(url), headers: headers);
  }
  //saveInspectionDetails
  static Future updateInspectionDetails(String encodedData, Map<String, String> headers) {
    var url = baseUrl + "/updateInspectionDetails";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }
  static Future uploadDocumentsAndFindings(String encodedData, String token, List<File>? files,String? findings,int? id) async {
    var url = baseUrl + "/uploadDocumentsAndFindings" + findings! +id.toString();
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    if (files != null && files.isNotEmpty) {
      for (var file in files) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        var multipartFile = http.MultipartFile(
          'file',
          stream,
          length,
          filename: file.path.split('/').last,
          contentType: MediaType.parse(lookupMimeType(file.path) ?? 'application/octet-stream'),
        );

        request.files.add(multipartFile);
      }
    }
    request.fields['findings'] = encodedData;
    var response = await request.send();
    return response;
  }
}

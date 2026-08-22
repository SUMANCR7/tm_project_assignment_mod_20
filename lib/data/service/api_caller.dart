
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tmp_assignment_mod_20/controller/auth_controller.dart';
import 'package:tmp_assignment_mod_20/data/models/api_response.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  //-----[ API Call ]------//


  //----111------[ GET ]--------//

static Future<ApiResponse> getRequest({required String URL}) async {

  try{
    Uri uri = Uri.parse(URL);

    _logger.i(URL);

    Response response = await get(uri, headers: {

      //----[ Token ]----//
      'token': AuthController.token ?? ''
    });
    
   _logger.i(response.body);

   //----[ Condition ]----//
    if(response.statusCode == 200){
      return ApiResponse(responseCode: response.statusCode,
          responseData: jsonDecode(response.body), isSuccess: true);
    }else{
      return ApiResponse(responseCode: response.statusCode,
          responseData: jsonDecode(response.body), isSuccess: false, errorMessage:jsonDecode(response.body));
    }
  }

  catch(e){
    return ApiResponse(responseCode: -1,
        responseData: null, isSuccess: false, errorMessage: e.toString());
  }
}

//--222-----[ POST ]-----//

  static Future<ApiResponse> postRequest({required String URL, Map<String, dynamic>? body}) async {

    try{
      Uri uri = Uri.parse(URL);

      _logger.i(URL);

      Response response = await post(uri, headers: {
        "Accept" : "application/json",
        "Content-type" : "application/json",

        //----[ Token ]----//
        'token': AuthController.token ?? ''
      },
      body: body != null ? jsonEncode(body) : null,
      );

      _logger.i(response.body);

      //----[ Condition ]----//
      if(response.statusCode == 200 || response.statusCode == 201){
        return ApiResponse(responseCode: response.statusCode,
            responseData: jsonDecode(response.body), isSuccess: true);
      }else{
        return ApiResponse(responseCode: response.statusCode,
            responseData: jsonDecode(response.body), isSuccess: false, errorMessage:jsonDecode(response.body));
      }
    }

    catch(e){
      return ApiResponse(responseCode: -1,
          responseData: null, isSuccess: false, errorMessage: e.toString());
    }
  }


}
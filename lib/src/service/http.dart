import 'package:dio/dio.dart';
// import 'package:myapp1/config/main.config.dart' as config;
// import 'dart:convert' show json;

//要查网络请求的日志可以使用过滤<net>
class QMHttpService {
  static const String GET = "get";
  static const String POST = "post";
  static String baseURL =
      "http://10.133.92.168/QMERP/RemoteCallManager?fromClient=QMBS&ModuleName=SYS&service=FusionCoreService";

  //get请求
  static void get(String url, Function callBack,
      {Map<String, dynamic> params, Function errorCallBack}) async {
    _request(baseURL + url, callBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  //post请求
  static void post(String url, Function callBack,
      {Map<String, dynamic> params, Function errorCallBack}) async {
    _request(baseURL + url, callBack,
        method: POST, params: params, errorCallBack: errorCallBack);
  }

  //具体的还是要看返回数据的基本结构
  //公共代码部分
  static void _request(String url, Function callBack,
      {String method,
      Map<String, dynamic> params,
      Function errorCallBack}) async {
    print("<net> url :<" + method + ">" + url);

    if (params != null && params.isNotEmpty) {
      print("<net> params :" + params.toString());
    }

    String errorMsg = "";
    int statusCode;

    try {
      Response response;
      if (method == GET) {
        //组合GET请求的参数
        if (params != null && params.isNotEmpty) {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await Dio().get(url);
      } else {
        if (params != null && params.isNotEmpty) {
          response = await Dio().post(url, data: params);
        } else {
          response = await Dio().post(url);
        }
      }

      statusCode = response.statusCode;

      //处理错误部分
      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        Map<String, dynamic> data = response.data;
        QMResponse qmResponse = new QMResponse(response);
        callBack(response.data);
        print("<net> response data:"); //+ response.data);
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("<net> errorMsg :" + errorMsg);
  }
}

class Utils {
  static jsonToObject<T>() {
    return null;
  }
}

class QMResponse {
  String exMessage;
  int resultState;
  double upTime; //":7535698598,
  double downTime; //7535698602,
  String serviceDistribute; //Y"
  QMResult result;

  final Response response;
  QMResponse(this.response) {
    Map<String, dynamic> data = response.data;
    exMessage = data['exMessage'];
    resultState = data['resultState'];
    upTime = data['upTime'];
    downTime = data['downTime'];
    serviceDistribute = data['serviceDistribute'];
    result = new QMResult(
        errorField: data['result']['errorField'],
        rowIndex: data['result']['rowIndex'],
        resultObj: data['result']['resultObj']);
  }
}

class QMResult {
  final String errorField;
  final int rowIndex;
  final dynamic resultObj;
  QMResult({this.errorField, this.rowIndex, this.resultObj}) {}
}

// {"serviceName":"FusionCoreService","methodName":"doLogin","paraValues":{"password":'1234qwer',"devMode":false,"ipAddress":'10.133.64.25',"client":"800","language":"zh_CN","userName":'ZHANGSX'} ,"client":800,"userName":"SUPER","tran":"TLogin","language":"zh_CN","sessionID":"SUPER","guid":"06e587a4-6329-4120-8849-e62394b919a7","backendVersion":""};

// {
//   "serviceName": "FusionCoreService",
//   "methodName": "doSaveUserRecent",
//   "client": "800",
//   "userName": "ZHANGSX",
//   "tran": "welcome",
//   "language": "zh_CN",
//   "sessionID": "56871f3e-4ec8-41ff-a1e6-05522f3cc10e",
//   "loginTime": 1554966204679,
//   "backendVersion": "",
//   "actionID": "d46121ed-d8e8-4e98-96cb-bc09d2e2a46d",
//   "guid": "c6950c47-645c-41ef-a931-36235479856b",
//   "paraValues": {
//     "UserId": 20730,
//     "VirtualBizTranCode": "tmw02"
//   }
// }

// {
//   "serviceName": "FusionCoreService",
//   "methodName": "getPageDefs",
//   "client": "800",
//   "userName": "ZHANGSX",
//   "tran": "tmw02",
//   "language": "zh_CN",
//   "sessionID": "56871f3e-4ec8-41ff-a1e6-05522f3cc10e",
//   "loginTime": 1554966204679,
//   "backendVersion": "",
//   "actionID": "f0182a9a-d4e3-42f2-9fc1-4b85a183d968",
//   "guid": "4d08bd75-2fac-4e71-b4a6-01097d80a55f",
//   "paraValues": {
//     "element": [],
//     "sdo": [],
//     "case": "tmw02",
//     "page": "list",
//     "metaDataType": "ERP",
//     "path": "",
//     "userId": 20730
//   }
// }

// {
//   "serviceName": "FusionTableService",
//   "methodName": "getDisplayInfo",
//   "client": "800",
//   "userName": "ZHANGSX",
//   "tran": "tmw02",
//   "language": "zh_CN",
//   "sessionID": "56871f3e-4ec8-41ff-a1e6-05522f3cc10e",
//   "loginTime": 1554966204679,
//   "backendVersion": "",
//   "actionID": "f0182a9a-d4e3-42f2-9fc1-4b85a183d968",
//   "guid": "26367be6-899f-4541-855b-7a00012b79fc",
//   "paraValues": {
//     "OwnerName": 20730,
//     "ScreenName": "list",
//     "BizTranName": "tmw02",
//     "TableId": "sub",
//     "IsCurSchema": "1",
//     "tableDrawCode": "tableCode-2"
//   }
// }

// {
//   "serviceName": "FusionCoreService",
//   "methodName": "getLookupItems",
//   "client": "800",
//   "userName": "ZHANGSX",
//   "tran": "tmw02",
//   "language": "zh_CN",
//   "sessionID": "56871f3e-4ec8-41ff-a1e6-05522f3cc10e",
//   "loginTime": 1554966204679,
//   "backendVersion": "",
//   "actionID": "f0182a9a-d4e3-42f2-9fc1-4b85a183d968",
//   "guid": "d1ad247c-c9b3-43a1-b477-6a8b707dd081",
//   "paraValues": {
//     "type": "TaskClass",
//     "metaDataType": "ERP"
//   }
// }

// {"result":{"errorField":"","rowIndex":-1,"resultObj":["@QMSpecialSerializer#List#ISDO#@",["VProjectName","VPubProgress","UpdateOn","DExpect","UpdateBy","NTargetTaskID","DBegin","NDeveloper","VHolder","VRlsPlan","VRefProject","NSourceProjectID","VSpliteFlag","VComment","NPersonLiable","VSourceProjectDep","VTargetFlag","VTestPoints","NRlsPlan","DPlanRelease","NWorkload","NProjectID","DPlanFinish","CreateOn","VProposer","VTester","CreateBy","NDomainID","PKey","NHolder","VAccessory","VSummary","VTaskSubClass","VDetailNew","NParentTaskID","VDeveloper","VSource","VReferenced","VDetail","DFinish","VStatus","NProposer","VTaskClass","VPersonLiable","VModule","VRlsLog","NTester","VRemark","VSourceProjectName","VPriority"],["移动","D","1554365030368","2019-01-24 00:00:00","ZHANGSX",0,"2019-03-11 00:00:00",20730,"张善旭",null,null,94721,"0",null,20730,"启明信息-软件研发服务中心-ERP实施部","0",null,null,null,40,221,"2019-03-11 00:00:00","2019-03-13 13:43:58","孙大臣",null,"SUNDC",0,119879,20730,"0","移动平台-熟悉小程序开发",null,"{lz}",0,"张善旭","启明信息-数据���新业务中心-数据产品平台部","0","移动平台-��悉小程序开发","2019-04-04 00:00:00","30",20661,"10","张善旭","SYS",null,null,null,"移动出行差旅审批","80"],["MES","D","1554365030368","2019-04-01 00:00:00","ZHANGSX",0,"2019-04-01 00:00:00",20730,"张善旭",null,null,381,"0","ios换证书",116360,"启明信息-软件研发服务中心-智能制造-MES团队","0",null,null,null,8,381,"2019-04-01 00:00:00","2019-03-13 13:41:58","孙大臣",null,"SUNDC",0,119878,20730,"0","ios换证书",null,"{lz}",0,"张善旭","启明信息-软件研发服务中心-智能制造-MES团队","0","ios换证书","2019-04-04 00:00:00","30",20661,"10","赵英春","BAS",null,null,null,"MES","60"],["DMS移动项目","D","1554365030368","2019-04-02 00:00:00","ZHANGSX",0,"2019-04-02 00:00:00",20730,"张善旭",null,null,703,"0",null,null,"启明信息-数据创新业务中心-数据产品业务部","0",null,null,null,2,703,"2019-04-02 00:00:00","2019-01-18 08:13:32","王继权",null,"WANGJQ",0,119314,20730,"0","BundleID是com.faw.jf.dealer的证书过期了，帮忙重新制作一个",null,"{lz}",0,"张善旭","启明信息-数据创新业务中心-数据产品业务部","0",null,"2019-04-04 00:00:00","30",21334,"10",null,"SYS",null,null,null,"DMS移动项目","80"],["MES","D","1554365030368","2019-04-02 00:00:00","ZHANGSX",0,"2019-04-02 00:00:00",20730,"张善旭",null,null,381,"0","ios换证书",116360,"启明信息-软件研发服务中心-智能制造-MES团队","0",null,null,null,4,381,"2019-04-02 00:00:00","2019-01-14 10:18:40","邸金鹏",null,"DIJP",0,119203,20730,"0","ios换证书",null,"{lz}",0,"张善旭","启明信息-软件研发服务中心-智能制造-MES团队","0","ios换证书","2019-04-04 00:00:00","30",20980,"10","赵英春","BAS",null,null,null,"MES","60"]["移动","D","1494393140154",null,"ZHANGSX",0,"2017-03-13 00:00:00",20730,"张善旭",null,null,null,"0",null,20730,null,"0",null,null,null,8,221,"2017-03-13 00:00:00","2017-03-13 10:26:37","王阳",null,"WANGY",0,221,20730,"0","qm cordova组件开发",null,"{lz}",0,"张善旭","启明信息-数据创新业务中心-数据产品平台部","0","qm cordova组件开发","2017-03-14 00:00:00","30",20724,"10","张善旭","SYS",null,null,null,null,"80"]]},"exMessage":"","resultState":0,"upTime":7535697882,"downTime":7535697990,"serviceDistribute":"Y"}
// {"result":{"errorField":"","rowIndex":-1,"resultObj":[{"description":"影响生产环境正常运行","label":"影响生产环境正常运行","text":"影响生产环境正常运行","value":"10"},{"description":"生产环境有bug但可变通处理","label":"生产环境有bug但可变通处理","text":"生产环境有bug但可变通处理","value":"20"},{"description":"影响生产环境使用效果","label":"影响生产环境使用效果","text":"影响生产环境使用效果","value":"30"},{"description":"生产环境有明确时间要求的需求","label":"生产环境有明确时间要求的需求","text":"生产环境有明确时间要求的需求","value":"40"},{"description":"生产环境未确定需求","label":"生产环境未确定需求","text":"生产环境未确定需求","value":"50"},{"description":"实施或客户经理需求","label":"实施或客户经理需求","text":"实施或客户经理需求","value":"60"},{"description":"测试环境Bug","label":"测试环境Bug","text":"测试环境Bug","value":"70"},{"description":"开发人员需求","label":"开发人员需求","text":"开发人员需求","value":"80"},{"description":"项目正常计划（内部计划）","label":"项目正常计划（内部计划）","text":"项目正常计划（内部计划）","value":"90"}]},"exMessage":"","resultState":0,"upTime":7535697917,"downTime":7535697928,"serviceDistribute":"Y"}
// {"result":{"errorField":"","rowIndex":-1,"resultObj":{"VRemarkNew":" ","VDetailNew":"移动平台-熟悉小程序开发"}},"exMessage":"","resultState":0,"upTime":7535698598,"downTime":7535698602,"serviceDistribute":"Y"}

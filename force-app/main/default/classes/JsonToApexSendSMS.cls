//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class JsonToApexSendSMS {

  public class SendSMS {
    public String mobile_number{get;set;}
    public String status{get;set;}
    public String reject_reason{get;set;}
    public String transaction_id{get;set;}
    public String code{get;set;}
    public String name{get;set;}
  }

  
  public static List<SendSMS> parse(String json) {
    return (List<SendSMS>) System.JSON.deserialize(json, List<JsonToApexSendSMS.SendSMS>.class);
  }
}
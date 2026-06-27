package wom.model.mobile
{
   public class MobileAlertDialog
   {
      
      public static const DISCONNECT_ID:int = 0;
      
      public static const IN_APP_PURCHASE_ID:int = 1;
      
      public static const STORE_REDIRECTION_ID:int = 2;
      
      public static const PROGRESS_ID:int = 3;
      
      public static const NO_CONNECTION_ID:int = 4;
      
      public static const MULTIPLE_CHOICE_DIALOG:int = 0;
      
      public static const SINGLE_CHOICE_DIALOG:int = 1;
      
      public static const PROGRESS_DIALOG:int = 2;
      
      private var _dialogType:int;
      
      private var _id:int;
      
      private var _title:String;
      
      private var _message:String;
      
      private var _cancelLabel:String;
      
      private var _labels:Array;
      
      private var _cancelable:Boolean;
      
      public function MobileAlertDialog(param1:int, param2:int, param3:String, param4:String, param5:String = null, param6:Array = null, param7:Boolean = true)
      {
         super();
         _dialogType = param1;
         _id = param2;
         _title = param3;
         _message = param4;
         _cancelLabel = param5;
         _labels = param6;
         _cancelable = param7;
      }
      
      public function get dialogType() : int
      {
         return _dialogType;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get cancelLabel() : String
      {
         return _cancelLabel;
      }
      
      public function get labels() : Array
      {
         return _labels;
      }
      
      public function get cancelable() : Boolean
      {
         return _cancelable;
      }
   }
}


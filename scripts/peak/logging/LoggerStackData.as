package peak.logging
{
   public class LoggerStackData
   {
      
      private var _packageName:String;
      
      private var _className:String;
      
      private var _methodName:String;
      
      private var _fileName:String;
      
      private var _lineNumber:int;
      
      public function LoggerStackData(param1:String)
      {
         super();
         var _loc2_:Array = param1.match(/^\tat (?:(.+)::)?(.+)\/(.+)\(\)\[(?:(.+)\:(\d+))?\]$/) || [];
         _packageName = _loc2_[1] || "";
         _className = _loc2_[2] || "";
         _methodName = _loc2_[3] || "";
         _fileName = _loc2_[4] || "";
         _lineNumber = int(_loc2_[5]) || 0;
      }
      
      public function toString() : String
      {
         return "_packageName " + _packageName + " // className " + _className + " // methodName " + _methodName + " // fileName " + _fileName + "// lineNumber " + _lineNumber;
      }
      
      public function get packageName() : String
      {
         return _packageName;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function get methodName() : String
      {
         return _methodName;
      }
      
      public function get fileName() : String
      {
         return _fileName;
      }
      
      public function get lineNumber() : int
      {
         return _lineNumber;
      }
   }
}


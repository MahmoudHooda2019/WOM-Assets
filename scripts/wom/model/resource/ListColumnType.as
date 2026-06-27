package wom.model.resource
{
   import peak.i18n.PText;
   
   public class ListColumnType
   {
      
      public static const DIRECTION_ASCENDING:int = -1;
      
      public static const DIRECTION_DESCENDING:int = 1;
      
      private var _id:int;
      
      private var _ascComperator:Function;
      
      private var _dscComperator:Function;
      
      public function ListColumnType(param1:int, param2:Function, param3:Function)
      {
         super();
         _id = param1;
         _ascComperator = param2;
         _dscComperator = param3;
      }
      
      public static function compareStrings(param1:String, param2:String, param3:int) : Number
      {
         var _temp_1:* = param1;
         var _loc5_:String = param2;
         var _loc6_:String = _temp_1;
         var _loc4_:int = int(peak.i18n.PText.INSTANCE.activeLanguage.collator.compare(_loc6_,_loc5_));
         if(_loc4_ < 0)
         {
            return param3;
         }
         if(_loc4_ > 0)
         {
            return -param3;
         }
         return 0;
      }
      
      public static function compareNumbers(param1:Number, param2:Number, param3:int) : Number
      {
         if(isNaN(param1) || isNaN(param2))
         {
            return 0;
         }
         if(param1 < param2)
         {
            return param3;
         }
         if(param1 > param2)
         {
            return -param3;
         }
         return 0;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get ascComperator() : Function
      {
         return _ascComperator;
      }
      
      public function get dscComperator() : Function
      {
         return _dscComperator;
      }
   }
}


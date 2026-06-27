package wom.view.util
{
   public class SearchTextInputUtil
   {
      
      public function SearchTextInputUtil()
      {
         super();
      }
      
      public static function populateKeywords(param1:String) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = param1.split(" ");
         _loc3_.sort();
         _loc2_ = _loc3_.length - 1;
         while(_loc2_ > 0)
         {
            if(_loc3_[_loc2_] === _loc3_[_loc2_ - 1])
            {
               _loc3_.splice(_loc2_,1);
            }
            _loc2_--;
         }
         return _loc3_.map(toLower);
      }
      
      private static function toLower(param1:*, param2:int, param3:Array) : String
      {
         return String(param1).toLowerCase();
      }
   }
}


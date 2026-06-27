package wom.controller.command.util
{
   import flash.utils.Dictionary;
   
   public class DictionaryUtil
   {
      
      public function DictionaryUtil()
      {
         super();
      }
      
      public static function isEmpty(param1:Dictionary) : Boolean
      {
         var _loc2_:Boolean = true;
         var _loc5_:int = 0;
         var _loc4_:Dictionary = param1;
         for(var _loc3_ in _loc4_)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public static function lengthOf(param1:Dictionary) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function clear(param1:Dictionary) : void
      {
         for(var _loc2_ in param1)
         {
            delete param1[_loc2_];
         }
      }
   }
}


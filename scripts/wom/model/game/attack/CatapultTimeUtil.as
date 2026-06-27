package wom.model.game.attack
{
   import flash.utils.Dictionary;
   
   public class CatapultTimeUtil
   {
      
      public function CatapultTimeUtil()
      {
         super();
      }
      
      public static function deserializeCatapultTimes(param1:Object) : Dictionary
      {
         var _loc5_:int = 0;
         var _loc3_:Dictionary = new Dictionary();
         var _loc2_:Boolean = false;
         _loc5_ = 1;
         while(_loc5_ <= 3)
         {
            _loc2_ = false;
            for each(var _loc4_ in param1)
            {
               if(_loc5_ == _loc4_.resourceTypeId)
               {
                  _loc3_[_loc5_] = new CatapultTimeDTO(_loc4_.resourceTypeId,_loc4_.remainingDuration);
                  _loc2_ = true;
               }
            }
            if(!_loc2_)
            {
               _loc3_[_loc5_] = new CatapultTimeDTO(_loc5_,0);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function calculateCatapultRemainingTimes(param1:Dictionary, param2:Dictionary) : Dictionary
      {
         for each(var _loc3_ in param2)
         {
            param1[_loc3_.id] = new CatapultTimeDTO(_loc3_.id,_loc3_.catapultTime);
         }
         return param1;
      }
   }
}


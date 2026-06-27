package wom.model.message.util
{
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.game.alliance.coa.VanityUtil;
   
   public class CoatOfArmsDeserializeUtil
   {
      
      public function CoatOfArmsDeserializeUtil()
      {
         super();
      }
      
      public static function createCoatOfArmsInfo(param1:Object) : CoatOfArmsInfo
      {
         var _loc3_:String = null;
         var _loc5_:Number = NaN;
         var _loc2_:int = 0;
         var _loc6_:VanityColorType = null;
         var _loc4_:VanityColorType = null;
         if(param1 && (param1 as String).length == 3)
         {
            _loc3_ = param1 as String;
            _loc5_ = "A".charCodeAt();
            _loc2_ = VanityUtil.determinePatternId(_loc3_.charCodeAt(0) - _loc5_);
            _loc6_ = VanityColorType.determineColorType(_loc3_.charCodeAt(1) - _loc5_);
            _loc4_ = VanityColorType.determineColorType(_loc3_.charCodeAt(2) - _loc5_);
            return new CoatOfArmsInfo(_loc2_,_loc6_,_loc4_);
         }
         return null;
      }
      
      public static function serializeCoatOfArmsInfo(param1:CoatOfArmsInfo) : String
      {
         var _loc2_:Number = "A".charCodeAt();
         return String.fromCharCode(_loc2_ + param1.patternId,_loc2_ + param1.patternColorA.id,_loc2_ + param1.patternColorB.id);
      }
   }
}


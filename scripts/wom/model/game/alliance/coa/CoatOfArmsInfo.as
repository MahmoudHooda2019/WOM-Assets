package wom.model.game.alliance.coa
{
   public class CoatOfArmsInfo
   {
      
      private var _patternId:int;
      
      private var _patternColorA:VanityColorType;
      
      private var _patternColorB:VanityColorType;
      
      public function CoatOfArmsInfo(param1:int, param2:VanityColorType, param3:VanityColorType)
      {
         super();
         _patternId = param1;
         _patternColorA = param2;
         _patternColorB = param3;
      }
      
      public function get patternId() : int
      {
         return _patternId;
      }
      
      public function get patternColorA() : VanityColorType
      {
         return _patternColorA;
      }
      
      public function get patternColorB() : VanityColorType
      {
         return _patternColorB;
      }
   }
}


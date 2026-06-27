package wom.model.domain.domaininfoobject
{
   public class LeagueLevelDIO
   {
      
      public static const LEVEL_ZERO_ID:Number = 0;
      
      public static const LEVEL_MAX_ID:Number = 16;
      
      private var _id:Number;
      
      private var _league:int;
      
      private var _division:int;
      
      private var _minBPToJoin:Number;
      
      private var _maxBPToJoin:Number;
      
      private var _minBPToStay:Number;
      
      private var _ironProductionBonusPercentage:int;
      
      private var _rewards:Vector.<int>;
      
      public function LeagueLevelDIO(param1:Number, param2:int, param3:int, param4:Number, param5:Number, param6:Number, param7:int, param8:int, param9:int, param10:int)
      {
         super();
         _id = param1;
         _league = param2;
         _division = param3;
         _minBPToJoin = param4;
         _maxBPToJoin = param5;
         _minBPToStay = param6;
         _ironProductionBonusPercentage = param7;
         _rewards = new Vector.<int>();
         _rewards.push(param8);
         _rewards.push(param9);
         _rewards.push(param10);
      }
      
      public function get id() : Number
      {
         return _id;
      }
      
      public function get league() : int
      {
         return _league;
      }
      
      public function get division() : int
      {
         return _division;
      }
      
      public function get minBPToJoin() : Number
      {
         return _minBPToJoin;
      }
      
      public function get maxBPToJoin() : Number
      {
         return _maxBPToJoin;
      }
      
      public function get minBPToStay() : Number
      {
         return _minBPToStay;
      }
      
      public function get ironProductionBonusPercentage() : int
      {
         return _ironProductionBonusPercentage;
      }
      
      public function get rewards() : Vector.<int>
      {
         return _rewards;
      }
      
      public function get assetIdMobileBig() : String
      {
         return "League" + _league + "IconBig";
      }
      
      public function get assetIdMobileSmall() : String
      {
         return "League" + _league + "Icon";
      }
      
      public function get assetIdMedium() : String
      {
         return "League" + _league + "Medium";
      }
      
      public function get assetIdSmall() : String
      {
         return "League" + _league + "Small";
      }
      
      public function get assetIdMini() : String
      {
         return "League" + _league + "Mini";
      }
   }
}


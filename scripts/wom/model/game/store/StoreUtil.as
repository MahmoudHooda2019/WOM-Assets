package wom.model.game.store
{
   import wom.model.dto.ResourceAmountDTO;
   
   public class StoreUtil
   {
      
      private static const MERCENARY_HIRE_CONSTANT:Number = 0.0228;
      
      private static const WALL_UPGRADE_PRICES:Array = new Array(0,3,6,16,34);
      
      public function StoreUtil()
      {
         super();
      }
      
      public static function mercenaryHiringPrice(param1:Number) : Number
      {
         return 0.0228 * param1;
      }
      
      public static function mercenaryTrainAndRecruitPrice(param1:Number, param2:Number) : int
      {
         var _loc3_:Number = Math.pow(Math.sqrt(param1 / 2),0.75);
         var _loc6_:Number = Math.ceil(param2 * 20 / 60 / 60);
         var _loc5_:Number = Math.sqrt(param2 * 0.8);
         var _loc4_:Number = Math.min(_loc6_,_loc5_);
         return _loc3_ + _loc4_ << 0;
      }
      
      public static function buildingPrice(param1:Number, param2:Number) : int
      {
         var _loc3_:Number = Number(StoreUtil.resourcePrice(param1));
         var _loc6_:Number = 0;
         var _loc5_:Number = int(Math.sqrt(param2 * 0.8));
         if(param2 < 300)
         {
            _loc6_ = 0;
         }
         else if(param2 < 1800)
         {
            _loc6_ = Math.ceil((param2 - 300) * 15 / 50 / 30);
         }
         else if(param2 < 3600)
         {
            _loc6_ = 15 + Math.ceil((param2 - 1800) * 5 / 60 / 30);
         }
         else
         {
            _loc6_ = Math.ceil(param2 * 20 / 60 / 60);
         }
         var _loc4_:Number = Math.min(_loc5_,_loc6_);
         return Math.ceil((_loc3_ + _loc4_) * 0.95);
      }
      
      public static function beastPrice() : int
      {
         return 0;
      }
      
      public static function buildingPriceWithRequirementsVector(param1:Vector.<ResourceAmountDTO>, param2:Number) : int
      {
         var _loc5_:int = 0;
         var _loc4_:ResourceAmountDTO = null;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            _loc3_ += _loc4_.resourceAmount;
            _loc5_++;
         }
         return buildingPrice(_loc3_,param2);
      }
      
      public static function getBareResourceCapacity(param1:int, param2:int) : int
      {
         return int(param1 / (1 + 0.1 * param2));
      }
      
      public static function calculateNextBoostedResourceCapacity(param1:*, param2:int) : int
      {
         return int(getBareResourceCapacity(param1,param2) * (1.1 + 0.1 * param2));
      }
      
      public static function resourcePrice(param1:Number) : int
      {
         return Math.pow(Math.sqrt(param1 / 2),0.75);
      }
      
      public static function beastCannonPrice(param1:Number) : int
      {
         return param1 * 5;
      }
      
      public static function itemEffectModifier(param1:ItemEffectType, param2:Vector.<ItemEffectInfo>) : Number
      {
         var _loc3_:Number = 1;
         for each(var _loc4_ in param2)
         {
            if(_loc4_.type.id == param1.id)
            {
               if(param1.cumulative)
               {
                  _loc3_ += _loc4_.bonusPercent / 100;
               }
               else if(param1.percentage)
               {
                  if(_loc4_.type == ItemEffectType.MERCENARY_ARMOR_BOOST && _loc3_ > _loc4_.bonusModifier)
                  {
                     _loc3_ = _loc4_.bonusModifier;
                  }
                  else if(_loc4_.type != ItemEffectType.MERCENARY_ARMOR_BOOST && _loc3_ < _loc4_.bonusModifier)
                  {
                     _loc3_ = _loc4_.bonusModifier;
                  }
               }
               else if(_loc3_ < _loc4_.bonusPercent)
               {
                  _loc3_ = _loc4_.bonusPercent;
               }
            }
         }
         return _loc3_;
      }
      
      public static function calculateWallUpgradePrice(param1:int, param2:Array) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc4_ += (WALL_UPGRADE_PRICES[param1] - WALL_UPGRADE_PRICES[_loc3_]) * param2[_loc3_];
            _loc3_++;
         }
         return _loc4_;
      }
   }
}


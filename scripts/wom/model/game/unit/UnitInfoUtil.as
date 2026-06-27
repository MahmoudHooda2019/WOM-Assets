package wom.model.game.unit
{
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   
   public class UnitInfoUtil
   {
      
      public function UnitInfoUtil()
      {
         super();
      }
      
      public static function getAmountOfUnits(param1:Vector.<UnitInfo>, param2:int) : int
      {
         var _loc4_:int = 0;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.typeId == param2)
            {
               _loc4_++;
            }
         }
         return _loc4_;
      }
      
      public static function addUnitInfoToCity(param1:UserInfo, param2:CityStatusInfo, param3:DomainInfo, param4:Vector.<UnitTypeAmountDTO>, param5:int, param6:UnitStatusType, param7:CoreManager = null, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false) : void
      {
         var _loc16_:* = 0;
         var _loc15_:int = 0;
         var _loc19_:int = 0;
         var _loc12_:UnitTypeInfo = null;
         var _loc11_:UnitTypeDIO = null;
         var _loc22_:int = 0;
         var _loc21_:Number = NaN;
         var _loc17_:UnitInfo = null;
         var _loc18_:Number = param1.unitArmorModifier;
         var _loc20_:Number = param1.unitSpeedModifier;
         var _loc14_:Number = param1.unitDamageModifier;
         for each(var _loc13_ in param4)
         {
            _loc16_ = uint(_loc13_.amount);
            _loc15_ = 0;
            while(_loc15_ < _loc16_)
            {
               _loc19_ = _loc13_.id;
               _loc12_ = param2.unitTypes[_loc19_];
               _loc11_ = param3.getUnit(_loc19_);
               _loc22_ = _loc12_.currentLevel == 0 ? 0 : _loc12_.currentLevel - 1;
               _loc21_ = _loc11_.healthPointsPerLevel[_loc22_];
               _loc17_ = new UnitInfo(DefaultUnitFactory.generateUnitId(),param6,param5,_loc19_,_loc21_,_loc18_,_loc20_,_loc14_);
               param2.units.push(_loc17_);
               if(param7 != null)
               {
                  if(param8)
                  {
                     param7.deployUnitToWatchPostFromBarracks(_loc17_.instanceId,param5);
                  }
                  else if(param9)
                  {
                     param7.deployUnitToWatchPostFromStore(_loc17_,param5);
                  }
                  else if(param10)
                  {
                     param7.hireUnitFromHiringQuartersToBarracks(_loc17_,param5);
                  }
               }
               _loc15_++;
            }
         }
      }
   }
}


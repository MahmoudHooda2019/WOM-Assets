package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.unit.CalculateUnitStatsEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class CalculateUnitStatsCommand extends PCommand
   {
      
      [Inject]
      public var event:CalculateUnitStatsEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function CalculateUnitStatsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:UnitTypeDIO = null;
         var _loc4_:UnitTypeInfo = null;
         var _loc3_:Number = userInfo.unitArmorModifier;
         var _loc5_:Number = userInfo.unitSpeedModifier;
         var _loc6_:Number = userInfo.unitDamageModifier;
         for each(var _loc2_ in cityInfo.units)
         {
            _loc1_ = domainInfo.getUnit(_loc2_.typeId);
            _loc4_ = cityInfo.unitTypes[_loc2_.typeId];
            _loc2_.armorModifier = _loc3_;
            _loc2_.speedModifier = _loc5_;
            _loc2_.damageModifier = _loc6_;
            _loc2_.healthPoints = _loc1_.healthPointsPerLevel[_loc4_.currentLevel - 1];
         }
         coreManager.recalculateAllUnitStats();
      }
   }
}


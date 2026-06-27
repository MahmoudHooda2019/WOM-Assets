package wom.model.domain.domaininfoobject
{
   import wom.model.dto.ResourceAmountDTO;
   
   public class FortificationInfoDIO
   {
      
      public var maxLevels:int;
      
      public var resourceCosts:Vector.<Vector.<ResourceAmountDTO>>;
      
      public var fortifyDurationsPerLevelInSecs:Vector.<Number>;
      
      public var buildingPrerequisitesPerLevel:Vector.<Vector.<PrerequisiteDIO>>;
      
      public var protectionBonusesPerLevelAsPercent:Vector.<int>;
      
      public function FortificationInfoDIO(param1:int, param2:Vector.<Vector.<ResourceAmountDTO>>, param3:Vector.<Number>, param4:Vector.<Vector.<PrerequisiteDIO>>, param5:Vector.<int>)
      {
         super();
         this.maxLevels = param1;
         this.resourceCosts = param2;
         this.fortifyDurationsPerLevelInSecs = param3;
         this.buildingPrerequisitesPerLevel = param4;
         this.protectionBonusesPerLevelAsPercent = param5;
      }
   }
}


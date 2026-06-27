package wom.model.component.attribute.data
{
   import peak.cuckoo.core.Attribute;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.structure.FloatingTextStack;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.dto.combat.DefenderBuildingInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   
   public class BuildingData extends Attribute
   {
      
      public static const TYPE_ID:String = "BuildingData";
      
      private var ownerViewManager:BuildingViewManager;
      
      public var buildingInfo:BuildingInfo;
      
      public var buildingTypeInfo:BuildingTypeInfo;
      
      public var buildingTypeDIO:BuildingTypeDIO;
      
      public var pathWeightGrid:Array;
      
      public var pathOutMargin:int;
      
      public var battleDestroyedStatus:Boolean;
      
      public var helpable:Boolean;
      
      public var protectionModifier:Number = 1;
      
      public var lootTextStacker:FloatingTextStack;
      
      public var damageTextStacker:FloatingTextStack;
      
      public var damaged:Boolean;
      
      public function BuildingData(param1:BuildingInfo, param2:BuildingTypeInfo, param3:BuildingTypeDIO)
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         super();
         this.buildingInfo = param1;
         this.buildingTypeInfo = param2;
         this.buildingTypeDIO = param3;
         lootTextStacker = new FloatingTextStack();
         damageTextStacker = new FloatingTextStack();
         var _loc4_:int = param3.pathMargin;
         this.pathOutMargin = _loc4_ >= 0 ? 0 : _loc4_;
         this.pathWeightGrid = [];
         var _loc5_:int = param3.baseSize - pathOutMargin * 2;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            pathWeightGrid[_loc7_] = [];
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               pathWeightGrid[_loc7_][_loc6_] = 5;
               _loc6_++;
            }
            _loc7_++;
         }
         _loc5_ = int(_loc4_ <= 0 ? _loc5_ : param3.baseSize - _loc4_);
         pathOutMargin = _loc4_ <= 0 ? 0 : _loc4_;
         _loc7_ = pathOutMargin;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = pathOutMargin;
            while(_loc6_ < _loc5_)
            {
               var _loc8_:int = _loc6_;
               var _loc9_:Number = pathWeightGrid[_loc7_][_loc8_] + (40 - 5);
               pathWeightGrid[_loc7_][_loc8_] = _loc9_;
               _loc6_++;
            }
            _loc7_++;
         }
         pathOutMargin = _loc4_ >= 0 ? 0 : _loc4_;
         calculateStats();
         battleDestroyedStatus = param1.healthPoint <= 0;
         helpable = false;
         damaged = false;
         calculateStats();
      }
      
      override public function get typeId() : String
      {
         return "BuildingData";
      }
      
      override public function init() : void
      {
         super.init();
         ownerViewManager = (owner as Building).viewManager;
      }
      
      public function notifyHealthPointChange() : void
      {
         ownerViewManager.manageMainVisuals();
         ownerViewManager.manageHealthProgressBar();
      }
      
      public function calculateStats() : void
      {
         var _loc2_:FortificationInfoDIO = null;
         var _loc1_:Number = NaN;
         if(buildingInfo.fortificationLevel == 0)
         {
            protectionModifier = 1;
         }
         else
         {
            _loc2_ = buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO;
            _loc1_ = _loc2_.protectionBonusesPerLevelAsPercent[buildingInfo.fortificationLevel - 1];
            protectionModifier = 1 - _loc1_ / 100;
         }
      }
      
      public function createLog() : DefenderBuildingInfo
      {
         return new DefenderBuildingInfo(buildingInfo.instanceId,damaged);
      }
   }
}


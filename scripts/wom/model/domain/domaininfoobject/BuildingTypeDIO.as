package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import wom.model.component.enum.ActionType;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.building.BuildMenuCategory;
   
   public class BuildingTypeDIO extends ConstructableTypeDIO
   {
      
      public var maxLevels:int;
      
      public var resourceCosts:Vector.<Vector.<ResourceAmountDTO>>;
      
      public var upgradeDurationsPerLevel:Vector.<Number>;
      
      public var healthPointsPerLevel:Vector.<Number>;
      
      public var repairDurationsPerLevel:Vector.<Number>;
      
      public var maxInstances:int;
      
      public var buildingPrerequisitesPerInstance:Vector.<Vector.<PrerequisiteDIO>>;
      
      public var buildingPrerequisitesPerLevel:Vector.<Vector.<PrerequisiteDIO>>;
      
      public var multipleInstancePrerequisites:Vector.<MultipleInstancePrerequisitesDIO>;
      
      public var visualMap:Array;
      
      public var silhouetteVisuals:Array;
      
      public var buildMenuVisual:String;
      
      public var defaultActionType:ActionType;
      
      public var recyclable:Boolean;
      
      public var fortificationSize:String;
      
      public var indestructable:Boolean;
      
      public var combineBuilding:Boolean;
      
      public var edgeSpace:int;
      
      public var gardenSpace:int;
      
      public var buildingSpace:int;
      
      public var gateCoord:Point;
      
      public var haveSoil:Boolean;
      
      public var animationNotLoop:Boolean;
      
      public var pathMargin:int;
      
      public var multibuild:Boolean;
      
      public var buildMenuIndex:int;
      
      public function BuildingTypeDIO(param1:int, param2:ConstructableKindTypeDIO, param3:int, param4:int, param5:Vector.<Vector.<ResourceAmountDTO>>, param6:Vector.<Number>, param7:Vector.<Number>, param8:Vector.<Number>, param9:int, param10:Vector.<Vector.<PrerequisiteDIO>>, param11:Vector.<Vector.<PrerequisiteDIO>>, param12:Vector.<MultipleInstancePrerequisitesDIO>, param13:Dictionary, param14:Array, param15:Array, param16:String, param17:BuildMenuCategory, param18:ActionType, param19:Boolean, param20:String, param21:Boolean, param22:Boolean, param23:int, param24:int, param25:int, param26:Point, param27:Boolean, param28:Boolean, param29:int, param30:String, param31:Boolean, param32:int, param33:Point)
      {
         super(param1,param2,param3,param17,param30,param13,param33);
         this.maxLevels = param4;
         this.resourceCosts = param5;
         this.upgradeDurationsPerLevel = param6;
         this.healthPointsPerLevel = param7;
         this.repairDurationsPerLevel = param8;
         this.maxInstances = param9;
         this.buildingPrerequisitesPerInstance = param10;
         this.buildingPrerequisitesPerLevel = param11;
         this.multipleInstancePrerequisites = param12;
         this.visualMap = param14;
         this.silhouetteVisuals = param15;
         this.buildMenuVisual = param16;
         this.defaultActionType = param18;
         this.recyclable = param19;
         this.fortificationSize = param20;
         this.indestructable = param21;
         this.combineBuilding = param22;
         this.edgeSpace = param23;
         this.gardenSpace = param24;
         this.buildingSpace = param25;
         this.gateCoord = param26;
         this.haveSoil = param27;
         this.animationNotLoop = param28;
         this.pathMargin = param29;
         this.multibuild = param31;
         this.buildMenuIndex = param32;
      }
      
      public function isHealthy(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = param1 - 1;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         return indestructable || healthPointsPerLevel[_loc3_] == param2;
      }
      
      public function calculateRecycleGainForLevel(param1:int) : Vector.<ResourceAmountDTO>
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = new Dictionary();
         var _loc4_:Vector.<ResourceAmountDTO> = new Vector.<ResourceAmountDTO>();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            for each(var _loc6_ in resourceCosts[_loc3_])
            {
               if(!(_loc6_.resourceType in _loc2_))
               {
                  _loc2_[_loc6_.resourceType] = 0;
               }
               var _loc7_:int = _loc6_.resourceType;
               var _loc8_:Number = _loc2_[_loc7_] + _loc6_.resourceAmount / 2;
               _loc2_[_loc7_] = _loc8_;
            }
            _loc3_++;
         }
         for(var _loc5_ in _loc2_)
         {
            _loc4_.push(new ResourceAmountDTO(int(_loc5_),_loc2_[_loc5_] >> 0));
         }
         return _loc4_;
      }
   }
}


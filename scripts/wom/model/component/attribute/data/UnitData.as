package wom.model.component.attribute.data
{
   import peak.cuckoo.core.Attribute;
   import peak.thread.WorkerThread;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.entity.attackcluster.AttackCluster;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   import wom.model.domain.domaininfoobject.UnitSpecificInfoType;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class UnitData extends Attribute
   {
      
      public static const TYPE_ID:String = "UnitData";
      
      public var info:UnitInfo;
      
      public var typeInfo:UnitTypeInfo;
      
      public var typeDIO:GenericUnitTypeDIO;
      
      public var cluster:AttackCluster;
      
      public var isBeast:Boolean;
      
      public var healAvailable:Boolean = true;
      
      public var buffAvailable:Boolean = true;
      
      public var beastBuff:int = 0;
      
      public var catapultBuff:int = 0;
      
      public var damage:WorkerThread = new WorkerThread();
      
      public var speed:WorkerThread = new WorkerThread();
      
      public var armor:WorkerThread = new WorkerThread();
      
      public var maxHealthPoint:WorkerThread = new WorkerThread();
      
      public var range:int;
      
      public var damageBuffModifier:Number = 1;
      
      public var speedBuffModifier:Number = 1;
      
      public var armorBuffModifier:Number = 1;
      
      public var unitLog:UnitLogData;
      
      private var ownerUnit:Unit;
      
      public function UnitData(param1:UnitInfo, param2:UnitTypeInfo, param3:GenericUnitTypeDIO, param4:Boolean = false)
      {
         super();
         this.info = param1;
         this.typeInfo = param2;
         this.typeDIO = param3;
         this.isBeast = param4;
         unitLog = new UnitLogData();
         calculateRange();
      }
      
      override public function get typeId() : String
      {
         return "UnitData";
      }
      
      override public function init() : void
      {
         super.init();
         unitLog.reset();
         ownerUnit = owner as Unit;
         var _temp_3:* = maxHealthPoint;
         var _loc2_:* = isBeast && (info as BeastInfo).bonusStage > 0 ? (typeDIO as BeastTypeDIO).healthPointsPerStage[(info as BeastInfo).bonusStage - 1] : typeDIO.healthPointsPerLevel[isBeast ? (info as BeastInfo).level - 1 : typeInfo.currentLevel - 1];
         var _loc1_:WorkerThread = _temp_3;
         _loc1_._value = _loc2_;
         calculateStats();
      }
      
      public function get levelIndex() : int
      {
         var _loc1_:int = isBeast ? (info as BeastInfo).level : typeInfo.currentLevel;
         return _loc1_ == 0 ? 0 : _loc1_ - 1;
      }
      
      public function calculateStats() : void
      {
         var _loc1_:int = isBeast ? (info as BeastInfo).level : typeInfo.currentLevel;
         _loc1_ = _loc1_ == 0 ? 0 : _loc1_ - 1;
         if(isBeast && (info as BeastInfo).bonusStage > 0)
         {
            var _temp_2:* = damage;
            var _loc8_:Number = (typeDIO as BeastTypeDIO).stageDamage((info as BeastInfo).bonusStage);
            var _loc2_:WorkerThread = _temp_2;
            _loc2_._value = _loc8_;
            var _temp_5:* = speed;
            var _loc9_:Number = (typeDIO as BeastTypeDIO).stageSpeedInYardUnit((info as BeastInfo).bonusStage) * (owner && "Wander" in owner.componentManager ? 0.5 : 1) / 12;
            var _loc3_:WorkerThread = _temp_5;
            _loc3_._value = _loc9_;
            var _temp_7:* = armor;
            var _loc10_:Number = armorBuffModifier;
            var _loc4_:WorkerThread = _temp_7;
            _loc4_._value = _loc10_;
         }
         else
         {
            var _temp_9:* = damage;
            var _loc11_:Number = typeDIO.damage(_loc1_,info.damageModifier * damageBuffModifier);
            var _loc5_:WorkerThread = _temp_9;
            _loc5_._value = _loc11_;
            var _temp_12:* = speed;
            var _loc12_:Number = typeDIO.speedInYardUnit(_loc1_,info.speedModifier * speedBuffModifier) * (owner && "Wander" in owner.componentManager ? 0.5 : 1);
            var _loc6_:WorkerThread = _temp_12;
            _loc6_._value = _loc12_;
            var _temp_14:* = armor;
            var _loc13_:Number = armorBuffModifier * info.armorModifier;
            var _loc7_:WorkerThread = _temp_14;
            _loc7_._value = _loc13_;
         }
         if(beastBuff > 0 || catapultBuff > 0)
         {
            ownerUnit.filterManager.addFilter(WomFilters.LIGHT_BLUE_FILTER);
            if(ownerUnit.animation)
            {
               ownerUnit.animation.modifier = 1 / speedBuffModifier;
            }
         }
         else
         {
            ownerUnit.filterManager.removeFilter(WomFilters.LIGHT_BLUE_FILTER);
            if(ownerUnit.animation)
            {
               ownerUnit.animation.modifier = 1;
            }
         }
         calculateRange();
      }
      
      protected function calculateRange() : void
      {
         if(isBeast && (info as BeastInfo).bonusStage > 0)
         {
            range = (typeDIO as BeastTypeDIO).rangesPerStage[(info as BeastInfo).bonusStage - 1];
         }
         else if(!isBeast && UnitSpecificInfoType.RANGES_PER_MASTERY.id in typeDIO.specificInfo && typeInfo.masteryLevel > 0)
         {
            range = typeDIO.specificInfo[UnitSpecificInfoType.RANGES_PER_MASTERY.id][typeInfo.masteryLevel - 1];
         }
         else
         {
            range = typeDIO.range(levelIndex);
         }
      }
      
      public function get favouriteTargets() : Vector.<int>
      {
         return isBeast && (info as BeastInfo).level == 6 ? (typeDIO as BeastTypeDIO).favouriteTargetsForMaxLevel : typeDIO.favouriteTargets;
      }
   }
}


package wom.model.component.behavior.battle.hit
{
   import peak.cuckoo.core.Attribute;
   import peak.signal.Signal1;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class BaseHit extends Attribute
   {
      
      public static const TYPE_ID:String = "BaseHit";
      
      public static const LOOTER_COEFFICIENT:Number = 10;
      
      public static const NONLOOTER_COEFFICIENT:Number = 0.42;
      
      protected var ownerUnit:Unit;
      
      protected var insurance:int;
      
      public var lootAmount:int;
      
      public var hitFinished:Signal1;
      
      protected var attacker:Boolean;
      
      public function BaseHit()
      {
         super();
         hitFinished = new Signal1();
      }
      
      override public function get typeId() : String
      {
         return "BaseHit";
      }
      
      override public function init() : void
      {
         ownerUnit = owner as Unit;
         attacker = !("DefensiveUnit" in owner.componentManager);
      }
      
      public function calculateLootAmount(param1:Building) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Boolean = ownerUnit.data.typeDIO.id == 12 || ownerUnit.data.typeDIO.id == 18 || ownerUnit.data.typeDIO.id == 28 || ownerUnit.data.isBeast && ownerUnit.data.typeDIO.id == 27 && ownerUnit.data.levelIndex == 5;
         if(param1.data.buildingTypeDIO.kind.id == 11 || param1.data.buildingTypeDIO.kind.id == 10 || param1.data.buildingTypeDIO.kind.id == 12)
         {
            var _loc3_:WorkerThread = ownerUnit.data.damage;
            lootAmount = _loc3_._value * (_loc2_ ? 10 : 0.42);
         }
         else
         {
            lootAmount = 0;
         }
         if(param1.data.buildingInfo.level == 0)
         {
            lootAmount = 0;
         }
      }
      
      public function hitUnit(param1:Unit) : void
      {
      }
      
      public function hitBuilding(param1:Building) : void
      {
      }
      
      public function hit(param1:Number, param2:Number, param3:Boolean = false) : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
         hitFinished.removeAll();
      }
   }
}


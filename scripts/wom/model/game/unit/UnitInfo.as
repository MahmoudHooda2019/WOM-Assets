package wom.model.game.unit
{
   import peak.thread.WorkerThread;
   
   public class UnitInfo
   {
      
      private var _instanceId:int;
      
      private var _status:UnitStatusType;
      
      private var _buildingId:int;
      
      private var _typeId:int;
      
      private var _healthPoints:WorkerThread = new WorkerThread();
      
      private var _armorModifier:Number;
      
      private var _speedModifier:Number;
      
      private var _damageModifier:Number;
      
      public function UnitInfo(param1:int, param2:UnitStatusType, param3:int, param4:int, param5:Number, param6:Number, param7:Number, param8:Number)
      {
         super();
         _instanceId = param1;
         _status = param2;
         _buildingId = param3;
         _typeId = param4;
         var _temp_6:* = _healthPoints;
         var _loc10_:Number = param5;
         var _loc9_:WorkerThread = _temp_6;
         _loc9_._value = _loc10_;
         _armorModifier = param6;
         _speedModifier = param7;
         _damageModifier = param8;
      }
      
      public function get status() : UnitStatusType
      {
         return _status;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function set instanceId(param1:int) : void
      {
         _instanceId = param1;
      }
      
      public function get buildingId() : int
      {
         return _buildingId;
      }
      
      public function set buildingId(param1:int) : void
      {
         _buildingId = param1;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function set typeId(param1:int) : void
      {
         _typeId = param1;
      }
      
      public function set status(param1:UnitStatusType) : void
      {
         _status = param1;
      }
      
      public function get healthPoints() : Number
      {
         var _loc1_:WorkerThread = _healthPoints;
         return _loc1_._value;
      }
      
      public function set healthPoints(param1:Number) : void
      {
         var _temp_1:* = _healthPoints;
         var _loc3_:Number = param1;
         var _loc2_:WorkerThread = _temp_1;
         _loc2_._value = _loc3_;
      }
      
      public function get armorModifier() : Number
      {
         return _armorModifier;
      }
      
      public function set armorModifier(param1:Number) : void
      {
         _armorModifier = param1;
      }
      
      public function get speedModifier() : Number
      {
         return _speedModifier;
      }
      
      public function set speedModifier(param1:Number) : void
      {
         _speedModifier = param1;
      }
      
      public function get damageModifier() : Number
      {
         return _damageModifier;
      }
      
      public function set damageModifier(param1:Number) : void
      {
         _damageModifier = param1;
      }
      
      public function clone() : UnitInfo
      {
         return new UnitInfo(_instanceId,_status,_buildingId,_typeId,_healthPoints._value,_armorModifier,_speedModifier,_damageModifier);
      }
   }
}


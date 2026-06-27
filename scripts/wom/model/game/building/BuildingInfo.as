package wom.model.game.building
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.thread.WorkerThread;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.Profile;
   import wom.model.game.staff.StaffInfo;
   import wom.model.game.store.EventInventoryItemInfo;
   
   public class BuildingInfo
   {
      
      private var _level:int;
      
      private var _instanceId:int;
      
      private var _buildingTypeId:int;
      
      private var _fortificationLevel:int;
      
      private var _healthPoint:WorkerThread = new WorkerThread();
      
      private var _position:Point;
      
      private var _incomplete:Boolean = false;
      
      private var _staffs:Vector.<StaffInfo>;
      
      private var _buildingSpecificInfo:Dictionary;
      
      public var isTrap:Boolean;
      
      public function BuildingInfo(param1:int, param2:int, param3:int, param4:Number, param5:Point, param6:int = 0, param7:Boolean = false)
      {
         super();
         this._level = param1;
         this._instanceId = param2;
         this._buildingTypeId = param3;
         this._fortificationLevel = param6;
         var _temp_2:* = this._healthPoint;
         var _loc9_:Number = param4;
         var _loc8_:WorkerThread = _temp_2;
         _loc8_._value = _loc9_;
         this._position = param5;
         this._incomplete = param7;
         _buildingSpecificInfo = new Dictionary();
         isTrap = _buildingTypeId == 39 || _buildingTypeId == 40;
      }
      
      public static function deserialize(param1:Object) : BuildingInfo
      {
         var _loc8_:* = undefined;
         var _loc3_:Object = null;
         var _loc6_:int = 0;
         var _loc2_:* = undefined;
         var _loc7_:BuildingInfo = new BuildingInfo(param1.l,param1.i,param1.y,param1.h,new Point(param1.p.x,param1.p.y),"f" in param1 ? param1.f : 0,"c" in param1 ? param1.c : false);
         if(param1.s)
         {
            _loc8_ = new Vector.<StaffInfo>();
            for(var _loc4_ in param1.s)
            {
               _loc3_ = param1.s[_loc4_];
               _loc8_.push(new StaffInfo(int(_loc4_),new Profile(_loc3_.gid,_loc3_.pid,_loc3_.a)));
            }
            _loc7_.staffs = _loc8_;
         }
         if(param1.q)
         {
            _loc6_ = 0;
            _loc2_ = new Vector.<EventInventoryItemInfo>();
            for each(var _loc5_ in param1.q)
            {
               _loc2_.push(new EventInventoryItemInfo(_loc5_.itemId,_loc5_.duration,_loc6_));
               _loc6_ += _loc5_.duration;
            }
            _loc7_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id] = _loc2_;
         }
         return _loc7_;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get buildingTypeId() : int
      {
         return _buildingTypeId;
      }
      
      public function get fortificationLevel() : int
      {
         return _fortificationLevel;
      }
      
      public function get healthPoint() : Number
      {
         var _loc1_:WorkerThread = _healthPoint;
         return _loc1_._value;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function set fortificationLevel(param1:int) : void
      {
         _fortificationLevel = param1;
      }
      
      public function set healthPoint(param1:Number) : void
      {
         var _temp_1:* = _healthPoint;
         var _loc3_:Number = param1;
         var _loc2_:WorkerThread = _temp_1;
         _loc2_._value = _loc3_;
      }
      
      public function get incomplete() : Boolean
      {
         return _incomplete;
      }
      
      public function set incomplete(param1:Boolean) : void
      {
         _incomplete = param1;
      }
      
      public function get staffs() : Vector.<StaffInfo>
      {
         return _staffs;
      }
      
      public function set staffs(param1:Vector.<StaffInfo>) : void
      {
         _staffs = param1;
      }
      
      public function get buildingSpecificInfo() : Dictionary
      {
         return _buildingSpecificInfo;
      }
   }
}


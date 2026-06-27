package wom.model.component.behavior
{
   import flash.utils.ByteArray;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.util.VarIntUtil;
   import wom.model.component.CuckooNotifier;
   import wom.model.component.WomGameRoot;
   
   public class FpsSyncCollector extends Behavior
   {
      
      public static const TYPE_ID:String = "FpsSyncCollector";
      
      private var sync:FpsSync;
      
      public var deltaTimePool:ByteArray;
      
      private var notifier:CuckooNotifier;
      
      private var index:int;
      
      public function FpsSyncCollector()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "FpsSyncCollector";
      }
      
      override public function init() : void
      {
         super.init();
         sync = owner.root.sync;
         notifier = (owner.root as WomGameRoot).notifier;
         deltaTimePool = new ByteArray();
         index = 0;
      }
      
      override public function update() : void
      {
         var _temp_2:* = VarIntUtil;
         var _temp_1:* = deltaTimePool;
         var _loc4_:int = sync.deltaTime;
         var _loc3_:ByteArray = _temp_1;
         var _loc1_:VarIntUtil = _temp_2;
         while(true)
         {
            var _loc2_:uint = uint(_loc4_ & 0xFF);
            if((_loc4_ & -128) == 0)
            {
               break;
            }
            _loc3_.writeByte(_loc2_ & 0x7F | 0x80);
            _loc4_ >>>= 7;
         }
         _loc3_.writeByte(_loc2_);
         undefined;
         if(deltaTimePool.length > 1024)
         {
            deflateAndFlushCollectedData();
         }
      }
      
      public function deflateAndFlushCollectedData() : void
      {
         deltaTimePool.deflate();
         notifier.flushCollectedData(index++,deltaTimePool);
         deltaTimePool = new ByteArray();
      }
   }
}


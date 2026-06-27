package peak.cuckoo.core
{
   import peak.cuckoo.game.Root;
   
   public class Entity
   {
      
      private static var ID_COUNTER:int = 0;
      
      public var id:int;
      
      public var invalidated:Boolean;
      
      public var root:Root;
      
      public var parent:Entity;
      
      public var children:Vector.<Entity>;
      
      public var componentManager:ComponentManager;
      
      public function Entity()
      {
         super();
         id = ++ID_COUNTER;
         children = new Vector.<Entity>();
         componentManager = new ComponentManager(this);
      }
      
      public function init() : void
      {
         componentManager.initAll();
         componentManager.firstEnableAll();
      }
      
      public function addChild(param1:Entity) : void
      {
         children.push(param1);
         param1.parent = this;
         param1.root = this.root;
      }
      
      public function removeChild(param1:Entity) : void
      {
         var _loc2_:Number = children.indexOf(param1);
         if(_loc2_ != -1)
         {
            param1.componentManager.disableAll();
            children.splice(_loc2_,1);
            param1.parent = null;
            param1.root = null;
         }
      }
      
      public function destroyChild(param1:Entity) : void
      {
         var _loc2_:Number = NaN;
         if(param1)
         {
            _loc2_ = children.indexOf(param1);
            if(_loc2_ != -1)
            {
               param1.destroy();
               children.splice(_loc2_,1);
               param1 = null;
            }
         }
      }
      
      public function destroyAll() : void
      {
         var _loc1_:Entity = null;
         while(children.length > 0)
         {
            _loc1_ = children.pop();
            _loc1_.destroyAll();
            destroyChild(_loc1_);
         }
         componentManager.destroyAll();
      }
      
      public function destroy() : void
      {
         componentManager.destroyAll();
         parent = null;
         root = null;
      }
   }
}


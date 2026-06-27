package peak.cuckoo.core
{
   import flash.events.EventDispatcher;
   
   public class Component extends EventDispatcher
   {
      
      public static const TYPE_ID:String = "Component";
      
      private static var ID_COUNTER:int = 0;
      
      public var nextComponent:Component;
      
      public var prevComponent:Component;
      
      public var id:int;
      
      public var initialized:Boolean = false;
      
      private var _enabled:Boolean = false;
      
      public var startEnabled:Boolean = true;
      
      public var owner:Entity;
      
      public function Component()
      {
         super();
         id = ID_COUNTER++;
      }
      
      public function get typeId() : String
      {
         return "Component";
      }
      
      public function init() : void
      {
         initialized = true;
      }
      
      public function destroy() : void
      {
         if(owner)
         {
            owner.componentManager.remove(this);
         }
      }
      
      public function enable() : void
      {
         if(!_enabled)
         {
            _enabled = true;
            start();
         }
      }
      
      public function disable() : void
      {
         if(_enabled)
         {
            _enabled = false;
            stop();
         }
      }
      
      protected function start() : void
      {
      }
      
      protected function stop() : void
      {
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
   }
}


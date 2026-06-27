package peak.cuckoo.core
{
   public dynamic class ComponentManager
   {
      
      private var owner:Entity;
      
      private var head:Component;
      
      private var tail:Component;
      
      public function ComponentManager(param1:Entity)
      {
         super();
         this.owner = param1;
      }
      
      public function add(param1:Component) : void
      {
         if(param1.typeId in this)
         {
            remove(this[param1.typeId] as Component);
         }
         this[param1.typeId] = param1;
         if(head)
         {
            tail.nextComponent = param1;
            param1.prevComponent = tail;
            tail = param1;
         }
         else
         {
            head = tail = param1;
            param1.prevComponent = null;
         }
         param1.nextComponent = null;
         param1.owner = owner;
      }
      
      public function remove(param1:Component) : void
      {
         if(!param1.typeId in this)
         {
            return;
         }
         if(head == param1)
         {
            head = head.nextComponent;
         }
         if(tail == param1)
         {
            tail = tail.prevComponent;
         }
         if(param1.prevComponent)
         {
            param1.prevComponent.nextComponent = param1.nextComponent;
         }
         if(param1.nextComponent)
         {
            param1.nextComponent.prevComponent = param1.prevComponent;
         }
         param1.disable();
         delete this[param1.typeId];
      }
      
      public function destroyAll() : void
      {
         var _loc1_:Component = null;
         var _loc2_:Component = head;
         while(_loc2_)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc2_.nextComponent;
            _loc1_.destroy();
            delete this[_loc1_.typeId];
         }
         head = tail = null;
      }
      
      public function initAll() : void
      {
         var _loc1_:Component = head;
         while(_loc1_)
         {
            _loc1_.init();
            _loc1_ = _loc1_.nextComponent;
         }
      }
      
      public function firstEnableAll() : void
      {
         var _loc1_:Component = head;
         while(_loc1_)
         {
            if(_loc1_.startEnabled)
            {
               _loc1_.enable();
            }
            _loc1_ = _loc1_.nextComponent;
         }
      }
      
      public function enableAll() : void
      {
         var _loc1_:Component = head;
         while(_loc1_)
         {
            _loc1_.enable();
            _loc1_ = _loc1_.nextComponent;
         }
      }
      
      public function disableAll() : void
      {
         var _loc1_:Component = head;
         while(_loc1_)
         {
            _loc1_.disable();
            _loc1_ = _loc1_.nextComponent;
         }
      }
   }
}


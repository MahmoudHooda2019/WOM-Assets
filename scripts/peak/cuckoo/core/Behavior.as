package peak.cuckoo.core
{
   public class Behavior extends Component
   {
      
      public var priority:int;
      
      internal var nextBehavior:Behavior;
      
      internal var prevBehavior:Behavior;
      
      internal var behaviorList:BehaviorList;
      
      public function Behavior()
      {
         super();
      }
      
      public function update() : void
      {
      }
      
      override protected function start() : void
      {
         owner.root.behaviorUpdater.register(this);
      }
      
      override protected function stop() : void
      {
         owner.root.behaviorUpdater.deregister(this);
      }
      
      public function terminate() : void
      {
         destroy();
      }
   }
}


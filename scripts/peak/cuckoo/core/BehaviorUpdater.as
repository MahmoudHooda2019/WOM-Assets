package peak.cuckoo.core
{
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   
   public class BehaviorUpdater
   {
      
      public static const PRIORITY_POSTRENDER:int = 0;
      
      public static const PRIORITY_PRERENDER:int = 1;
      
      public static const PRIORITY_RENDER:int = 2;
      
      public static const USER:int = 3;
      
      public static const PRIORITY_COUNT:int = 4;
      
      public const SPARSE_LOOP_INTERVAL:int = 10800;
      
      public var root:Root;
      
      private var behaviors:Vector.<BehaviorList>;
      
      private var postRenderSparse:Vector.<SparseBehavior>;
      
      internal var currentFrame:int;
      
      private var tempSparseBehavior:Behavior;
      
      private var sync:FpsSync;
      
      private var current:Behavior;
      
      private var nextBehavior:Behavior;
      
      private var activeBehaviorList:BehaviorList;
      
      public function BehaviorUpdater(param1:Root)
      {
         super();
         this.root = param1;
         this.sync = root.sync;
         behaviors = new Vector.<BehaviorList>(4,true);
         behaviors[0] = new BehaviorList();
         behaviors[1] = new BehaviorList();
         behaviors[2] = new BehaviorList();
         behaviors[3] = new BehaviorList();
         postRenderSparse = new Vector.<SparseBehavior>(10800,true);
         currentFrame = 0;
      }
      
      public function updateAll() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Behavior = null;
         var _loc1_:SparseBehavior = null;
         root.sync.update();
         _loc3_ = 0;
         while(_loc3_ < behaviors.length)
         {
            activeBehaviorList = behaviors[_loc3_];
            nextBehavior = activeBehaviorList.head;
            if(nextBehavior)
            {
               do
               {
                  _loc2_ = nextBehavior;
                  nextBehavior = _loc2_.nextBehavior;
                  try
                  {
                     _loc2_.update();
                  }
                  catch(e:Error)
                  {
                     root.onError(e);
                  }
               }
               while(nextBehavior);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < sync.elapsedDiscrete)
         {
            currentFrame = (currentFrame + 1) % 10800;
            _loc1_ = postRenderSparse[currentFrame];
            while(_loc1_)
            {
               tempSparseBehavior = _loc1_.nextBehavior;
               _loc1_.update();
               if(_loc1_.enabled)
               {
                  _loc1_.bookedFrame = (_loc1_.interval + currentFrame) % 10800;
                  _loc1_.nextBehavior = postRenderSparse[_loc1_.bookedFrame];
                  postRenderSparse[_loc1_.bookedFrame] = _loc1_;
               }
               _loc1_ = tempSparseBehavior as SparseBehavior;
            }
            _loc3_++;
         }
      }
      
      internal function register(param1:Behavior) : void
      {
         if(param1.behaviorList)
         {
            trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!FATAL ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
         }
         param1.behaviorList = behaviors[param1.priority];
         if(!nextBehavior && activeBehaviorList == param1.behaviorList)
         {
            nextBehavior = param1;
         }
         if(param1.behaviorList.tail)
         {
            param1.prevBehavior = param1.behaviorList.tail;
            param1.behaviorList.tail.nextBehavior = param1;
            param1.behaviorList.tail = param1;
         }
         else
         {
            param1.prevBehavior = null;
            param1.behaviorList.tail = param1.behaviorList.head = param1;
         }
         param1.nextBehavior = null;
      }
      
      internal function deregister(param1:Behavior) : void
      {
         if(param1 == nextBehavior)
         {
            nextBehavior = nextBehavior.nextBehavior;
         }
         if(param1.behaviorList.head == param1)
         {
            param1.behaviorList.head = param1.nextBehavior;
         }
         else
         {
            param1.prevBehavior.nextBehavior = param1.nextBehavior;
         }
         if(param1.behaviorList.tail == param1)
         {
            param1.behaviorList.tail = param1.prevBehavior;
         }
         else
         {
            param1.nextBehavior.prevBehavior = param1.prevBehavior;
         }
         param1.behaviorList = null;
      }
      
      public function terminateAll() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Behavior = null;
         var _loc1_:SparseBehavior = null;
         _loc3_ = 0;
         while(_loc3_ < behaviors.length)
         {
            _loc2_ = behaviors[_loc3_].head;
            while(_loc2_)
            {
               _loc2_.terminate();
               _loc2_ = _loc2_.nextBehavior;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < postRenderSparse.length)
         {
            _loc1_ = postRenderSparse[_loc3_];
            while(_loc1_)
            {
               tempSparseBehavior = _loc1_.nextBehavior;
               _loc1_.terminate();
               _loc1_ = tempSparseBehavior as SparseBehavior;
            }
            _loc3_++;
         }
         trace("terminate end");
      }
      
      public function registerSparse(param1:SparseBehavior) : void
      {
         param1.bookedFrame = (param1.startFrameNum + currentFrame) % 10800;
         param1.nextBehavior = postRenderSparse[param1.bookedFrame];
         postRenderSparse[param1.bookedFrame] = param1;
      }
      
      public function deregisterSparse(param1:SparseBehavior) : void
      {
         var _loc2_:Behavior = postRenderSparse[param1.bookedFrame];
         if(_loc2_ && _loc2_ == param1)
         {
            postRenderSparse[param1.bookedFrame] = _loc2_.nextBehavior as SparseBehavior;
         }
         else
         {
            while(_loc2_.nextBehavior)
            {
               if(_loc2_.nextBehavior == param1)
               {
                  _loc2_.nextBehavior = _loc2_.nextBehavior.nextBehavior;
                  return;
               }
               _loc2_ = _loc2_.nextBehavior;
            }
         }
      }
   }
}


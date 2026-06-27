package feathers.core
{
   import feathers.utils.display.getDisplayObjectDepthFromStage;
   import flash.utils.Dictionary;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public final class ValidationQueue implements IAnimatable
   {
      
      private var _starling:Starling;
      
      private var _isValidating:Boolean = false;
      
      private var _delayedQueue:Vector.<IFeathersControl> = new Vector.<IFeathersControl>(0);
      
      private var _queue:Vector.<IFeathersControl> = new Vector.<IFeathersControl>(0);
      
      private var _depthDictionary:Dictionary = new Dictionary(true);
      
      public function ValidationQueue()
      {
         super();
      }
      
      public function get isValidating() : Boolean
      {
         return this._isValidating;
      }
      
      public function addControl(param1:IFeathersControl, param2:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:IFeathersControl = null;
         var _loc3_:int = 0;
         var _loc6_:Starling = Starling.current;
         if(_loc6_ && this._starling != _loc6_)
         {
            if(this._starling)
            {
               this._starling.juggler.remove(this);
            }
            this._starling = _loc6_;
         }
         if(!this._starling.juggler.contains(this))
         {
            this._starling.juggler.add(this);
         }
         var _loc5_:Vector.<IFeathersControl> = this._isValidating && param2 ? this._delayedQueue : this._queue;
         if(_loc5_.indexOf(param1) >= 0)
         {
            return;
         }
         var _loc4_:int = int(_loc5_.length);
         if(this._isValidating && _loc5_ == this._queue)
         {
            _loc8_ = getDisplayObjectDepthFromStage(DisplayObject(param1));
            this._depthDictionary[param1] = _loc8_;
            _loc9_ = _loc4_ - 1;
            while(_loc9_ >= 0)
            {
               _loc7_ = IFeathersControl(_loc5_[_loc9_]);
               _loc3_ = this._depthDictionary[_loc7_] as int;
               if(_loc8_ >= _loc3_)
               {
                  break;
               }
               _loc9_--;
            }
            if(++_loc9_ == _loc4_)
            {
               _loc5_[_loc4_] = param1;
            }
            else
            {
               _loc5_.splice(_loc9_,0,param1);
            }
         }
         else
         {
            _loc5_[_loc4_] = param1;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc6_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc2_:IFeathersControl = null;
         if(this._isValidating)
         {
            return;
         }
         var _loc3_:int = int(this._queue.length);
         if(_loc3_ == 0)
         {
            return;
         }
         this._isValidating = true;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = DisplayObject(this._queue[_loc6_]);
            this._depthDictionary[_loc5_] = getDisplayObjectDepthFromStage(_loc5_);
            _loc6_++;
         }
         this._queue = this._queue.sort(queueSortFunction);
         while(this._queue.length > 0)
         {
            _loc2_ = this._queue.shift();
            _loc2_.validate();
            delete this._depthDictionary[_loc2_];
         }
         var _loc4_:Vector.<IFeathersControl> = this._queue;
         this._queue = this._delayedQueue;
         this._delayedQueue = _loc4_;
         this._isValidating = false;
      }
      
      protected function queueSortFunction(param1:IFeathersControl, param2:IFeathersControl) : int
      {
         var _loc4_:int = this._depthDictionary[param1] as int;
         var _loc3_:int = this._depthDictionary[param2] as int;
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         return 0;
      }
   }
}


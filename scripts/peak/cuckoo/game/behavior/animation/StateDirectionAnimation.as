package peak.cuckoo.game.behavior.animation
{
   public class StateDirectionAnimation extends Animation
   {
      
      protected var _direction:uint = 0;
      
      protected var _state:uint = 0;
      
      public var stateTotal:int;
      
      public var stateFramesTotal:int;
      
      public var directionTotal:int;
      
      protected var _modifier:Number;
      
      protected var stateMap:Array;
      
      public function StateDirectionAnimation(param1:Array, param2:int = 0, param3:int = 0)
      {
         super();
         this.stateMap = param1;
         _modifier = 1;
      }
      
      public function set direction(param1:uint) : void
      {
         _direction = param1;
      }
      
      public function set state(param1:uint) : void
      {
         _state = param1;
      }
      
      public function get state() : uint
      {
         return _state;
      }
      
      public function get modifier() : Number
      {
         return _modifier;
      }
      
      public function set modifier(param1:Number) : void
      {
         _modifier = param1;
      }
   }
}


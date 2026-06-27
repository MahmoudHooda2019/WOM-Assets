package wom.model.game.beast
{
   public class FrozenBeastInfo
   {
      
      private var _instanceId:int;
      
      private var _level:int;
      
      private var _bonusStage:int;
      
      public function FrozenBeastInfo(param1:int, param2:int, param3:int)
      {
         super();
         _instanceId = param1;
         _level = param2;
         _bonusStage = param3;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function set instanceId(param1:int) : void
      {
         _instanceId = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get bonusStage() : int
      {
         return _bonusStage;
      }
      
      public function set bonusStage(param1:int) : void
      {
         _bonusStage = param1;
      }
   }
}


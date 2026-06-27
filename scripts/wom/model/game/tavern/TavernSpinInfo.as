package wom.model.game.tavern
{
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   
   public class TavernSpinInfo
   {
      
      public static const MIN_TURN:int = 1;
      
      public static const SLICE_ANGLE:Number = 22.5;
      
      public static const STATUS_INACTIVE:int = 0;
      
      public static const STATUS_SPINNING:int = 1;
      
      private var _status:int;
      
      private var _turn:int;
      
      private var _lastSpinVisualOrder:int;
      
      private var _resultTavernItemDIO:TavernItemDIO;
      
      private var _spinCancelled:Boolean;
      
      public function TavernSpinInfo()
      {
         super();
         _status = 0;
         _turn = 0;
         _lastSpinVisualOrder = 0;
         _resultTavernItemDIO = null;
         _spinCancelled = false;
      }
      
      public function turn() : void
      {
         _turn = _turn + 1;
      }
      
      public function get resultTavernItemDIO() : TavernItemDIO
      {
         return _resultTavernItemDIO;
      }
      
      public function set resultTavernItemDIO(param1:TavernItemDIO) : void
      {
         _resultTavernItemDIO = param1;
      }
      
      private function reset() : void
      {
         _turn = 0;
         _resultTavernItemDIO = null;
      }
      
      public function spin() : void
      {
         reset();
         _status = 1;
      }
      
      public function stop() : void
      {
         if(_resultTavernItemDIO != null)
         {
            _lastSpinVisualOrder = _resultTavernItemDIO.visualOrder;
         }
         reset();
         _status = 0;
      }
      
      public function isMinTurnSatisfied() : Boolean
      {
         return _turn >= 1;
      }
      
      public function get lastSpinVisualOrder() : int
      {
         return _lastSpinVisualOrder;
      }
      
      public function get spinCancelled() : Boolean
      {
         return _spinCancelled;
      }
      
      public function set spinCancelled(param1:Boolean) : void
      {
         _spinCancelled = param1;
      }
   }
}


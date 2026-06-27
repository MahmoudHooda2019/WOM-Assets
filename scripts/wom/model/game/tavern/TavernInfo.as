package wom.model.game.tavern
{
   public class TavernInfo
   {
      
      public static const UNLOCKED_CARDS_LENGTH:int = 6;
      
      public static const UNLOCKED_CARD_INDEX_COMMON:int = 1;
      
      public static const UNLOCKED_CARD_INDEX_UNCOMMON:int = 2;
      
      public static const UNLOCKED_CARD_INDEX_RARE:int = 3;
      
      public static const BEAST_ID:int = 33;
      
      private var _spinInfo:TavernSpinInfo;
      
      private var _unlockedCards:Vector.<Boolean>;
      
      private var _tillNextSpin:Number;
      
      private var _freeSpinCount:int;
      
      private var _paidSpinCount:int;
      
      public function TavernInfo()
      {
         super();
         _spinInfo = new TavernSpinInfo();
         _unlockedCards = new Vector.<Boolean>(6,true);
         _tillNextSpin = 0;
      }
      
      public function get spinInfo() : TavernSpinInfo
      {
         return _spinInfo;
      }
      
      public function get unlockedCards() : Vector.<Boolean>
      {
         return _unlockedCards;
      }
      
      public function get tillNextSpin() : Number
      {
         return _tillNextSpin;
      }
      
      public function set tillNextSpin(param1:Number) : void
      {
         _tillNextSpin = param1;
      }
      
      public function get freeSpinCount() : int
      {
         return _freeSpinCount;
      }
      
      public function set freeSpinCount(param1:int) : void
      {
         _freeSpinCount = param1;
      }
      
      public function get paidSpinCount() : int
      {
         return _paidSpinCount;
      }
      
      public function set paidSpinCount(param1:int) : void
      {
         _paidSpinCount = param1;
      }
   }
}


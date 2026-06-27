package wom.model.game.gold
{
   import wom.model.game.Profile;
   
   public class GoldGift
   {
      
      private var _sender:Profile;
      
      private var _amountOfGold:Number;
      
      public function GoldGift(param1:Profile, param2:Number)
      {
         super();
         _sender = param1;
         _amountOfGold = param2;
      }
      
      public static function createGoldGift(param1:Object) : GoldGift
      {
         return new GoldGift(new Profile(param1.sender.gid,param1.sender.pid,param1.sender.a),Number(param1.amount));
      }
      
      public function get sender() : Profile
      {
         return _sender;
      }
      
      public function get amountOfGold() : Number
      {
         return _amountOfGold;
      }
      
      public function set amountOfGold(param1:Number) : void
      {
         _amountOfGold = param1;
      }
   }
}


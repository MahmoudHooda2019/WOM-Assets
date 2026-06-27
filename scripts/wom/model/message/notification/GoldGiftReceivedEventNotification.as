package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.gold.GoldGift;
   
   public class GoldGiftReceivedEventNotification extends AbstractIncomingMessage
   {
      
      private var _goldGift:GoldGift;
      
      public function GoldGiftReceivedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _goldGift = GoldGift.createGoldGift(param1.gift);
      }
      
      public function get goldGift() : GoldGift
      {
         return _goldGift;
      }
   }
}


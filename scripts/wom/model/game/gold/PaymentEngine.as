package wom.model.game.gold
{
   public class PaymentEngine
   {
      
      public static const OLD:PaymentEngine = new PaymentEngine("old");
      
      public static const NEW:PaymentEngine = new PaymentEngine("new");
      
      private var _id:String;
      
      public function PaymentEngine(param1:String)
      {
         super();
         _id = param1;
      }
      
      public static function determinePaymentEngine(param1:String) : PaymentEngine
      {
         if(param1 == OLD.id)
         {
            return OLD;
         }
         return NEW;
      }
      
      public function get id() : String
      {
         return _id;
      }
   }
}


package wom.model.game.currency
{
   public class CurrencyType
   {
      
      public static const UNKNOWN:CurrencyType = new CurrencyType(0,"Unknown");
      
      public static const GOLD:CurrencyType = new CurrencyType(1,"Gold");
      
      public static const RECON_POINTS:CurrencyType = new CurrencyType(2,"Recon Points");
      
      private var _id:int;
      
      private var _name:String;
      
      public function CurrencyType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}


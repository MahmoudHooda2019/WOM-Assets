package wom.model.game.store
{
   public class StoreItemCurrencyType
   {
      
      public static const UNKNOWN:StoreItemCurrencyType = new StoreItemCurrencyType(0,"Unknown");
      
      public static const GOLD:StoreItemCurrencyType = new StoreItemCurrencyType(1,"Gold");
      
      public static const RECON_POINTS:StoreItemCurrencyType = new StoreItemCurrencyType(2,"Recon Points");
      
      public static const PARTS:StoreItemCurrencyType = new StoreItemCurrencyType(3,"Parts");
      
      public static const FREE:StoreItemCurrencyType = new StoreItemCurrencyType(4,"Free");
      
      public static const EVENT_POINTS:StoreItemCurrencyType = new StoreItemCurrencyType(4,"Event Points");
      
      private var _id:int;
      
      private var _name:String;
      
      public function StoreItemCurrencyType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public static function determineStoreItemCurrencyType(param1:int) : StoreItemCurrencyType
      {
         var _loc2_:StoreItemCurrencyType = StoreItemCurrencyType.UNKNOWN;
         switch(param1)
         {
            case GOLD.id:
               _loc2_ = StoreItemCurrencyType.GOLD;
               break;
            case RECON_POINTS.id:
               _loc2_ = StoreItemCurrencyType.RECON_POINTS;
               break;
            case PARTS.id:
               _loc2_ = StoreItemCurrencyType.PARTS;
               break;
            default:
               _loc2_ = StoreItemCurrencyType.UNKNOWN;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get iconAssetName() : String
      {
         return _name + "45";
      }
   }
}


package wom.model.game.inventory
{
   public class ResourceQuantityType
   {
      
      public static const DEFAULT:ResourceQuantityType = new ResourceQuantityType(0,"domain.parts.resourcequantity.default");
      
      public static const SMALL:ResourceQuantityType = new ResourceQuantityType(1,"domain.parts.resourcequantity.small");
      
      public static const BIG:ResourceQuantityType = new ResourceQuantityType(3,"domain.parts.resourcequantity.big");
      
      public static const FOUR_PERCENT:ResourceQuantityType = new ResourceQuantityType(4,"domain.parts.resourcequantity.huge",4);
      
      public static const ONE_PERCENT:ResourceQuantityType = new ResourceQuantityType(5,"domain.parts.resourcequantity.onepercent",1);
      
      private var _id:int;
      
      private var _i18nKey:String;
      
      private var _percent:int;
      
      public function ResourceQuantityType(param1:int, param2:String, param3:int = 0)
      {
         super();
         _id = param1;
         _i18nKey = param2;
         _percent = param3;
      }
      
      public static function determineResourceQuantityType(param1:int) : ResourceQuantityType
      {
         var _loc2_:ResourceQuantityType = DEFAULT;
         switch(param1)
         {
            case SMALL._id:
               _loc2_ = SMALL;
               break;
            case BIG._id:
               _loc2_ = BIG;
               break;
            case FOUR_PERCENT._id:
               _loc2_ = FOUR_PERCENT;
               break;
            case ONE_PERCENT._id:
               _loc2_ = ONE_PERCENT;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get i18nKey() : String
      {
         return _i18nKey;
      }
      
      public function get percent() : int
      {
         return _percent;
      }
   }
}


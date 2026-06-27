package wom.model.game.event
{
   public class EventItemType
   {
      
      public static const UNKNOWN:EventItemType = new EventItemType(0,"Unknown");
      
      public static const MERCENARY:EventItemType = new EventItemType(1,"Mercenary");
      
      public static const BEAST:EventItemType = new EventItemType(2,"Beast");
      
      public static const BUILDING:EventItemType = new EventItemType(3,"Building");
      
      public static const BOOST:EventItemType = new EventItemType(4,"Boost");
      
      public static const CATAPULT:EventItemType = new EventItemType(5,"Catapult");
      
      private var _id:int;
      
      private var _name:String;
      
      public function EventItemType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public static function determineEventItemType(param1:int) : EventItemType
      {
         var _loc2_:EventItemType = EventItemType.UNKNOWN;
         switch(param1)
         {
            case MERCENARY.id:
               _loc2_ = EventItemType.MERCENARY;
               break;
            case BEAST.id:
               _loc2_ = EventItemType.BEAST;
               break;
            case BUILDING.id:
               _loc2_ = EventItemType.BUILDING;
               break;
            case BOOST.id:
               _loc2_ = EventItemType.BOOST;
               break;
            case CATAPULT.id:
               _loc2_ = EventItemType.CATAPULT;
               break;
            default:
               _loc2_ = EventItemType.UNKNOWN;
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
   }
}


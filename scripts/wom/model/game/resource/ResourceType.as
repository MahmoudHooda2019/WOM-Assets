package wom.model.game.resource
{
   public class ResourceType
   {
      
      public static const UNKNOWN:ResourceType = new ResourceType(0,"Unknown");
      
      public static const LUMBER:ResourceType = new ResourceType(1,"Lumber");
      
      public static const STONE:ResourceType = new ResourceType(2,"Stone");
      
      public static const MIGHT:ResourceType = new ResourceType(3,"Might");
      
      public static const IRON:ResourceType = new ResourceType(4,"Iron");
      
      public static const resourceTypes:Array = [LUMBER,STONE,MIGHT,IRON];
      
      private var _id:int;
      
      private var _name:String;
      
      public function ResourceType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public static function determineResourceType(param1:int) : ResourceType
      {
         var _loc2_:ResourceType = ResourceType.UNKNOWN;
         switch(param1)
         {
            case LUMBER.id:
               _loc2_ = ResourceType.LUMBER;
               break;
            case STONE.id:
               _loc2_ = ResourceType.STONE;
               break;
            case MIGHT.id:
               _loc2_ = ResourceType.MIGHT;
               break;
            case IRON.id:
               _loc2_ = ResourceType.IRON;
               break;
            default:
               _loc2_ = ResourceType.UNKNOWN;
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
         return "Icon" + _name + "MBordered";
      }
   }
}


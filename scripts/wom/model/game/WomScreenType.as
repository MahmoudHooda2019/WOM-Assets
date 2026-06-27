package wom.model.game
{
   public class WomScreenType
   {
      
      public static const UNKNOWN:WomScreenType = new WomScreenType(0,"Unknown");
      
      public static const LOADING:WomScreenType = new WomScreenType(1,"Loading");
      
      public static const CITY:WomScreenType = new WomScreenType(2,"City");
      
      public static const MAP:WomScreenType = new WomScreenType(3,"Map");
      
      public static const MANUEL_AUTHENTICATION:WomScreenType = new WomScreenType(4,"ManuelAuthentication");
      
      public static const MOBILE_CITY_PLANNER:WomScreenType = new WomScreenType(6,"MobilePlanner");
      
      private var _id:int;
      
      private var _name:String;
      
      public function WomScreenType(param1:int, param2:String)
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


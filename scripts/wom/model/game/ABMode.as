package wom.model.game
{
   public class ABMode
   {
      
      public static const MODE_A:ABMode = new ABMode("A");
      
      public static const MODE_B:ABMode = new ABMode("B");
      
      private var _id:String;
      
      public function ABMode(param1:String)
      {
         super();
         _id = param1;
      }
      
      public function get id() : String
      {
         return _id;
      }
   }
}


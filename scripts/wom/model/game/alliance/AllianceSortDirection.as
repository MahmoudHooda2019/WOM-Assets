package wom.model.game.alliance
{
   public class AllianceSortDirection
   {
      
      public static const ASC:AllianceSortDirection = new AllianceSortDirection(true);
      
      public static const DESC:AllianceSortDirection = new AllianceSortDirection(false);
      
      private var _value:Boolean;
      
      public function AllianceSortDirection(param1:Boolean)
      {
         super();
         _value = param1;
      }
      
      public static function determineDirection(param1:Boolean) : AllianceSortDirection
      {
         var _loc2_:Boolean = param1;
         if(ASC.value !== _loc2_)
         {
            return DESC;
         }
         return ASC;
      }
      
      public function get value() : Boolean
      {
         return _value;
      }
   }
}


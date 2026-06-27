package peak.display
{
   import flash.ui.Mouse;
   
   public class CustomCursorManager
   {
      
      public static const AUTO:String = "auto";
      
      public static const ARROW:String = "arrow";
      
      public static const HAND:String = "button";
      
      public static const DRAG:String = "hand";
      
      protected var defaultCursor:String;
      
      protected var savedCursor:String;
      
      public function CustomCursorManager(param1:String)
      {
         super();
         this.defaultCursor = param1;
      }
      
      final public function useDefault() : void
      {
         Mouse.cursor = defaultCursor;
      }
      
      final public function useHand() : void
      {
         savedCursor = Mouse.cursor;
         Mouse.cursor = "button";
      }
      
      final public function restoreFromHand() : void
      {
         if(savedCursor && Mouse.cursor == "button")
         {
            Mouse.cursor = savedCursor;
         }
      }
      
      final public function useDrag() : void
      {
         savedCursor = Mouse.cursor;
         Mouse.cursor = "hand";
      }
      
      final public function restoreFromDrag() : void
      {
         if(savedCursor && Mouse.cursor == "hand")
         {
            Mouse.cursor = savedCursor;
         }
      }
   }
}


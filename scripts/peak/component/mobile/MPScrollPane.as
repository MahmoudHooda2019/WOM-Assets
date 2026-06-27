package peak.component.mobile
{
   import feathers.controls.ScrollContainer;
   
   public class MPScrollPane extends ScrollContainer
   {
      
      private static const LINE_SCROLL_SIZE:int = 20;
      
      public function MPScrollPane()
      {
         super();
         this.snapScrollPositionsToPixels = true;
      }
   }
}


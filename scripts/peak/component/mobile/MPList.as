package peak.component.mobile
{
   import feathers.controls.List;
   
   public class MPList extends List
   {
      
      public function MPList()
      {
         super();
         this.isFocusEnabled = false;
         this.snapScrollPositionsToPixels = true;
      }
   }
}


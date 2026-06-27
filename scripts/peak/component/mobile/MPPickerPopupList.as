package peak.component.mobile
{
   import feathers.controls.List;
   
   public class MPPickerPopupList extends List
   {
      
      public function MPPickerPopupList()
      {
         super();
         this.isFocusEnabled = false;
         this.snapScrollPositionsToPixels = true;
      }
   }
}


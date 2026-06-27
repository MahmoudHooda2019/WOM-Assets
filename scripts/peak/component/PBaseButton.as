package peak.component
{
   import fl.controls.BaseButton;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PBaseButton extends BaseButton
   {
      
      public function PBaseButton()
      {
         super();
         this.focusEnabled = false;
         this.tabEnabled = false;
      }
      
      override protected function getDisplayObjectInstance(param1:Object) : DisplayObject
      {
         if(param1 is Bitmap)
         {
            return new Bitmap((param1 as Bitmap).bitmapData);
         }
         if(param1 is AssetDisplayObject)
         {
            return (param1 as AssetDisplayObject).clone();
         }
         return super.getDisplayObjectInstance(param1);
      }
   }
}


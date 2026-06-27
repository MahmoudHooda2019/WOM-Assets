package peak.component
{
   import fl.controls.List;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PList extends List
   {
      
      public function PList()
      {
         super();
         this.focusEnabled = false;
         this.tabEnabled = false;
      }
      
      override protected function getDisplayObjectInstance(param1:Object) : DisplayObject
      {
         if(param1 is AssetDisplayObject)
         {
            return (param1 as AssetDisplayObject).clone();
         }
         if(param1 is Bitmap)
         {
            return new Bitmap((param1 as Bitmap).bitmapData);
         }
         return super.getDisplayObjectInstance(param1);
      }
   }
}


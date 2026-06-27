package peak.component
{
   import fl.controls.UIScrollBar;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PScrollBar extends UIScrollBar
   {
      
      public function PScrollBar()
      {
         super();
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
         if(param1 is BitmapData)
         {
            return new Bitmap(param1 as BitmapData);
         }
         return super.getDisplayObjectInstance(param1);
      }
   }
}


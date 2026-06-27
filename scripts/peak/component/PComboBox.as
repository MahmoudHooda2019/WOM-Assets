package peak.component
{
   import fl.controls.ComboBox;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PComboBox extends ComboBox
   {
      
      public function PComboBox()
      {
         super();
         this.height = 25;
         this.textField.textField.antiAliasType = "advanced";
         this.focusEnabled = false;
         this.tabEnabled = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         removeChild(background);
         background = new bgClass();
         copyStylesToChild(background,BACKGROUND_STYLES);
         background.addEventListener("mouseDown",onToggleListVisibility,false,0,true);
         addChildAt(background,0);
         list = new PList();
         copyStylesToChild(list,LIST_STYLES);
         list.addEventListener("change",onListChange,false,0,true);
         list.addEventListener("click",onStageClick,false,0,true);
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
      
      protected function get bgClass() : Class
      {
         return PBaseButton;
      }
   }
}


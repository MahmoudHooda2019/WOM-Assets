package wom.view.screen.windows.pigeonpost
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import wom.view.component.MobileWomCheckBox;
   
   public class MobilePigeonPostCheckBoxItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _checkBox:MobileWomCheckBox;
      
      private var _dataObject:Object;
      
      public function MobilePigeonPostCheckBoxItemRenderer()
      {
         super();
         _checkBox = new MobileWomCheckBox();
         addChild(_checkBox);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _dataObject = param1;
            _checkBox.label = param1.label;
            _checkBox.isEnabled = param1.enabled;
            drawLayout();
         }
      }
      
      override public function get data() : Object
      {
         return _dataObject;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         super.isSelected = param1;
         _checkBox.isSelected = param1;
      }
   }
}


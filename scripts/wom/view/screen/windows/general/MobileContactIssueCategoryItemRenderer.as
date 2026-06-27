package wom.view.screen.windows.general
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.skins.SmartDisplayObjectStateValueSelector;
   import peak.component.mobile.*;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileContactIssueCategoryItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _dataObject:Object;
      
      private var _itemTF:MPTextField;
      
      private var _categoryIndex:int;
      
      public function MobileContactIssueCategoryItemRenderer()
      {
         super();
         var _loc1_:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
         stateToSkinFunction = _loc1_.updateValue;
         paddingTop = 8;
         gap = Infinity;
         _itemTF = new MobileCaptionTextField();
         _itemTF.textRendererProperties.textFormat = getCaptionTextFormat(25,"center");
         _itemTF.width = 300;
         addChild(_itemTF);
         _itemTF.text = "";
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         _itemTF.validate();
         _itemTF.y = 10;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _dataObject = param1;
            _itemTF.text = param1.text;
            _categoryIndex = param1.index;
            drawLayout();
         }
      }
      
      override public function get data() : Object
      {
         return _dataObject;
      }
      
      public function get categoryIndex() : int
      {
         return _categoryIndex;
      }
   }
}


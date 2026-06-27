package wom.view.screen.windows.settings
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.i18n.lang.Language;
   import peak.i18n.lang.Languages;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileSelectLanguageListItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _button:MobileWomButton;
      
      private var _dataObject:Object;
      
      public function MobileSelectLanguageListItemRenderer(param1:MobileWomAssetRepository)
      {
         super();
         _assetRepository = param1;
         _button = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _button.width = 187;
         addChild(_button);
      }
      
      override public function get data() : Object
      {
         return _dataObject;
      }
      
      public function drawLayout() : void
      {
         _button.x = width - _button.width >> 1;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Language = null;
         if(param1)
         {
            _dataObject = param1;
            _loc2_ = Language(param1.lang);
            _button.rightLabel = _loc2_.fullName;
            _button.defaultIcon = _assetRepository.getDisplayObject("Icon" + _loc2_.toUpperCase(_loc2_.id));
            if(_loc2_.id == Languages.activeLanguageId)
            {
               _button.isEnabled = false;
            }
            button.data = {
               "webApiId":_loc2_.webApiId,
               "id":_loc2_.id
            };
            _button.validate();
         }
         drawLayout();
      }
      
      public function get button() : MobileWomButton
      {
         return _button;
      }
   }
}


package wom.view.screen.windows.settings
{
   import feathers.data.ListCollection;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import peak.i18n.lang.Language;
   import peak.i18n.lang.Languages;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileSelectLanguageView extends Sprite
   {
      
      private static const WIDTH:int = 492;
      
      private static const HEIGHT:int = 416;
      
      private var _isGooglePlusAvailable:Boolean;
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _languageButtonList:MPList;
      
      private var _background:DisplayObject;
      
      private var _backButton:MobileWomButton;
      
      public function MobileSelectLanguageView(param1:Boolean, param2:MobileWomAssetRepository)
      {
         super();
         _isGooglePlusAvailable = param1;
         _assetRepository = param2;
         _background = param2.getDisplayObject("MobileBeigeBackground");
         _background.width = 492;
         _background.height = 416 + (_isGooglePlusAvailable ? 156 : 0);
         addChild(_background);
         _languageButtonList = new MPList();
         _languageButtonList.itemRendererFactory = factory;
         _languageButtonList.width = 400;
         _languageButtonList.height = 381 + (_isGooglePlusAvailable ? 156 : 0);
         _languageButtonList.horizontalScrollPolicy = "off";
         _languageButtonList.verticalScrollPolicy = "on";
         addChild(_languageButtonList);
         _backButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Small");
         _backButton.width = 98;
         var _temp_6:* = _backButton;
         var _loc3_:String = "m.ui.windows.settings.back";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_backButton);
         updateList();
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_languageButtonList,_background);
         MobileAlignmentUtil.alignAccordingToPositionOf(_backButton,_background,13,15);
      }
      
      private function factory() : MobileSelectLanguageListItemRenderer
      {
         var _loc1_:MobileSelectLanguageListItemRenderer = new MobileSelectLanguageListItemRenderer(_assetRepository);
         _loc1_.width = 400;
         _loc1_.height = 72;
         return _loc1_;
      }
      
      public function updateList() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in Languages.supportedLanguages)
         {
            _loc1_.push({"lang":_loc2_});
         }
         _languageButtonList.dataProvider = new ListCollection(_loc1_);
         _languageButtonList.validate();
      }
      
      public function get backButton() : MobileWomButton
      {
         return _backButton;
      }
      
      public function get languageButtonList() : MPList
      {
         return _languageButtonList;
      }
   }
}


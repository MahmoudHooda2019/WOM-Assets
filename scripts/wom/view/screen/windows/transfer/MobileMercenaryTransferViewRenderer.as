package wom.view.screen.windows.transfer
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileMercenaryImageView;
   
   public class MobileMercenaryTransferViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      public static const WIDTH:int = 321;
      
      public static const HEIGHT:int = 132;
      
      public static const FROM_HOUSING:int = 0;
      
      public static const FROM_STORE:int = 1;
      
      public static const IN_BUNKER:int = 2;
      
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _minusButton:MobileWomButton;
      
      private var _plusButton:MobileWomButton;
      
      private var _executeButton:MobileWomButton;
      
      private var mercenaryNameTextField:MPTextField;
      
      private var mercenaryView:MobileMercenaryImageView;
      
      private var _mode:int;
      
      private var _type:int;
      
      private var _amount:int;
      
      private var _selectedAmount:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _transferData:Object;
      
      public function MobileMercenaryTransferViewRenderer(param1:MobileWomAssetRepository, param2:int, param3:int)
      {
         super();
         this.assetRepository = param1;
         _type = param2;
         _mode = param3;
         background = param1.getDisplayObject("MobileBeigeBackground");
         background.width = 321;
         background.height = 132;
         addChild(background);
         mercenaryNameTextField = new MobileCaptionTextField();
         mercenaryNameTextField.width = background.width;
         mercenaryNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         mercenaryNameTextField.textRendererProperties.multiline = true;
         mercenaryNameTextField.textRendererProperties.wordWrap = true;
         addChild(mercenaryNameTextField);
         _minusButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _minusButton.width = 75;
         _minusButton.visible = _mode == 0 || _mode == 1;
         _minusButton.defaultIcon = param1.getDisplayObject("SymbolMinusBig");
         addChild(_minusButton);
         _plusButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _plusButton.width = 75;
         _plusButton.visible = _mode == 0 || _mode == 1;
         _plusButton.defaultIcon = param1.getDisplayObject("SymbolPlusBig");
         addChild(_plusButton);
         _executeButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _executeButton.width = 140;
         var _temp_10:* = _executeButton;
         var _loc4_:String = "ui.windows.watchpost.executeone";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _executeButton.visible = _mode == 2 && _type == 1;
         addChild(_executeButton);
      }
      
      public function drawLayout() : void
      {
         background.x = 0;
         background.y = 8;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(mercenaryView,background,18);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_plusButton,background,133);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minusButton,background,222);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_executeButton,background,143);
      }
      
      override public function get data() : Object
      {
         return _transferData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _transferData = param1;
            _amount = _transferData.amount;
            _selectedAmount = _transferData.selectedAmount;
            _unitTypeDIO = _transferData.unitTypeDIO;
            var _temp_5:* = mercenaryNameTextField;
            var _loc2_:String = "domain.units." + _unitTypeDIO.id + ".name";
            _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            mercenaryView = new MobileMercenaryImageView(assetRepository,_unitTypeDIO,91,91);
            addChild(mercenaryView);
            updateSelectedAmountTF();
         }
         drawLayout();
      }
      
      public function get minusButton() : MobileWomButton
      {
         return _minusButton;
      }
      
      public function get plusButton() : MobileWomButton
      {
         return _plusButton;
      }
      
      public function get executeButton() : MobileWomButton
      {
         return _executeButton;
      }
      
      public function get selectedAmount() : int
      {
         return _selectedAmount;
      }
      
      public function set selectedAmount(param1:int) : void
      {
         _selectedAmount = param1;
         updateSelectedAmountTF();
      }
      
      public function get transferData() : Object
      {
         return _transferData;
      }
      
      public function get mode() : int
      {
         return _mode;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function decrement() : void
      {
         this.selectedAmount--;
      }
      
      public function increment() : void
      {
         this.selectedAmount++;
      }
      
      private function updateSelectedAmountTF() : void
      {
         var _temp_2:*;
         var _temp_1:*;
         var _temp_3:*;
         var _loc1_:int;
         var _loc2_:int;
         var _loc3_:String;
         var _loc4_:int;
         var _loc5_:String;
         mercenaryView.selectionStatusText = _mode == 0 ? (_temp_2 = "ui.windows.watchpost.housed",_temp_1 = _selectedAmount,_loc1_ = _amount,_loc2_ = _temp_1,_loc3_ = _temp_2,peak.i18n.PText.INSTANCE.getText2(_loc3_,_loc2_,_loc1_)) : (_mode == 1 ? (_temp_3 = "ui.windows.watchpost.selected",_loc4_ = _selectedAmount,_loc5_ = _temp_3,peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_)) : (_mode == 2 ? String(_amount) : ""));
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
   }
}


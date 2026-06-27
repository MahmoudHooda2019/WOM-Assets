package wom.view.screen.windows.transfer
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.component.button.rigid.MinusButton;
   import wom.view.component.button.rigid.PlusButton;
   
   public class MercenaryTransferWindowMercenaryView extends Sprite implements View
   {
      
      public static const FROM_HOUSING:int = 0;
      
      public static const FROM_STORE:int = 1;
      
      public static const IN_BUNKER:int = 2;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _unitTypeId:int;
      
      private var _mode:int;
      
      private var _amount:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var background:DisplayObject;
      
      private var mercenaryPortrait:DisplayObject;
      
      private var mercenaryNameTextField:TextField;
      
      private var statusBackground:DisplayObject;
      
      private var _minusButton:MinusButton;
      
      private var _plusButton:PlusButton;
      
      private var _executeButton:WomGreenSmallButton;
      
      private var _selectedAmount:int;
      
      private var _selectedAmountTextField:TextField;
      
      private var _type:int;
      
      public function MercenaryTransferWindowMercenaryView(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0)
      {
         super();
         _unitTypeId = param1;
         _mode = param2;
         _type = param3;
         _amount = param4;
         _selectedAmount = param5;
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("BackgroundDark");
         background.width = 263;
         background.height = 63;
         addChild(background);
         statusBackground = assetRepository.getDisplayObject("ProgressBar19TrackSkin");
         statusBackground.width = _mode == 2 ? 82 : 66;
         addChild(statusBackground);
         mercenaryPortrait = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Small");
         addChild(mercenaryPortrait);
         mercenaryNameTextField = new CaptionTextField();
         mercenaryNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         mercenaryNameTextField.autoSize = "left";
         mercenaryNameTextField.multiline = true;
         mercenaryNameTextField.wordWrap = true;
         mercenaryNameTextField.width = 80;
         var _temp_5:* = mercenaryNameTextField;
         var _loc1_:String = "domain.units." + _unitTypeDIO.id + ".name";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(mercenaryNameTextField);
         _minusButton = new MinusButton();
         _minusButton.visible = _mode == 0 || _mode == 1;
         addChild(_minusButton);
         _plusButton = new PlusButton();
         _plusButton.visible = _mode == 0 || _mode == 1;
         addChild(_plusButton);
         _executeButton = new WomGreenSmallButton();
         var _temp_11:* = _executeButton;
         var _loc2_:String = "ui.windows.watchpost.executeone";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _executeButton.width = 80;
         _executeButton.visible = _mode == 2 && _type == 1;
         addChild(_executeButton);
         _selectedAmountTextField = new WomTextField();
         _selectedAmountTextField.autoSize = "left";
         updateSelectedAmountTF();
         addChild(_selectedAmountTextField);
      }
      
      public function drawLayout() : void
      {
         mercenaryPortrait.x = mercenaryPortrait.y = 6;
         mercenaryNameTextField.x = 63;
         mercenaryNameTextField.y = background.height - mercenaryNameTextField.textHeight - 4 >> 1;
         _minusButton.x = 192;
         _minusButton.y = 28;
         AlignmentUtil.alignRightOf(_plusButton,_minusButton,6);
         statusBackground.x = background.width - statusBackground.width - 6;
         statusBackground.y = 6;
         AlignmentUtil.alignMiddleOf(_selectedAmountTextField,statusBackground);
         _executeButton.x = 176;
         _executeButton.y = 27;
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function set unitTypeDIO(param1:UnitTypeDIO) : void
      {
         _unitTypeDIO = param1;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get mode() : int
      {
         return _mode;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get minusButton() : MinusButton
      {
         return _minusButton;
      }
      
      public function set minusButton(param1:MinusButton) : void
      {
         _minusButton = param1;
      }
      
      public function get plusButton() : PlusButton
      {
         return _plusButton;
      }
      
      public function get executeButton() : WomGreenSmallButton
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
      
      private function updateSelectedAmountTF() : void
      {
         var _temp_2:*;
         var _temp_1:*;
         var _temp_3:*;
         var _temp_4:*;
         var _loc1_:int;
         var _loc2_:int;
         var _loc3_:String;
         var _loc4_:int;
         var _loc5_:String;
         var _loc6_:int;
         var _loc7_:String;
         _selectedAmountTextField.text = _mode == 0 ? (_temp_2 = "ui.windows.watchpost.housed",_temp_1 = _selectedAmount,_loc1_ = _amount,_loc2_ = _temp_1,_loc3_ = _temp_2,peak.i18n.PText.INSTANCE.getText2(_loc3_,_loc2_,_loc1_)) : (_mode == 1 ? (_temp_3 = "ui.windows.watchpost.selected",_loc4_ = _selectedAmount,_loc5_ = _temp_3,peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_)) : (_mode == 2 ? (_temp_4 = "ui.windows.watchpost.bunkered",_loc6_ = _amount,_loc7_ = _temp_4,peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_)) : ""));
      }
      
      public function decrement() : void
      {
         this.selectedAmount--;
      }
      
      public function increment() : void
      {
         this.selectedAmount++;
      }
   }
}


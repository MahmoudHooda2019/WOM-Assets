package wom.view.ui.mainframe.combat.catapult
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import peak.component.PTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.store.StoreUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.AvatarButton;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenMediumButton;
   import wom.view.ui.mainframe.city.tooltip.AttachableTooltipView;
   import wom.view.ui.mainframe.combat.eventitems.CombatEventItemView;
   
   public class CatapultMenuView extends Sprite implements View
   {
      
      public static const SELECT:int = 0;
      
      public static const CANCEL:int = 1;
      
      public static const USED:int = 2;
      
      public static const NA:int = 3;
      
      public static const COUNT_DOWN:int = 4;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var domainInfo:WomAssetRepository;
      
      public var type:int;
      
      private var _resourceType:ResourceType;
      
      public var assetName:String;
      
      private var _plusIconAsset:DisplayObject;
      
      private var _rechargeButton:WomButton;
      
      private var rechargeButtonCostTF:TextField;
      
      private var rechargeCostIsSet:Boolean;
      
      private var _rechargeCost:int;
      
      private var _tooltipText:String;
      
      private var _typeTextField:CaptionTextField;
      
      private var _resourceImage:DisplayObject;
      
      private var _button:Button;
      
      private var _typeText:String;
      
      private var tooltip:AttachableTooltipView;
      
      private var _tooltipSprite:Sprite;
      
      private var _tooltipTF:PTextField;
      
      private var tooltipBg:DisplayObject;
      
      private var bottomPin:DisplayObject;
      
      public var buttonState:int;
      
      public var catapultMenuTab:CatapultMenuTab;
      
      private var _catapultMenuOptions:CatapultMenuOptionsView;
      
      public function CatapultMenuView(param1:CatapultMenuTab, param2:int)
      {
         super();
         buttonState = 0;
         this.catapultMenuTab = param1;
         this.type = param2;
         switch(param2 - 1)
         {
            case 0:
               assetName = "CatapultLumber45";
               _resourceType = ResourceType.LUMBER;
               var _loc3_:String = "ui.mainframe.combat.catapult.lumber";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               var _loc4_:String = "ui.mainframe.combat.catapult.lumbertooltip";
               _tooltipText = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 1:
               assetName = "CatapultStone45";
               _resourceType = ResourceType.STONE;
               var _loc5_:String = "ui.mainframe.combat.catapult.stone";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               var _loc6_:String = "ui.mainframe.combat.catapult.stonetooltip";
               _tooltipText = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               break;
            case 2:
               assetName = "CatapultMight45";
               _resourceType = ResourceType.MIGHT;
               var _loc7_:String = "ui.mainframe.combat.catapult.might";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc7_);
               var _loc8_:String = "ui.mainframe.combat.catapult.mighttooltip";
               _tooltipText = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         }
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function switchButtonState(param1:int) : void
      {
         buttonState = param1;
         refreshButtonAppearance();
      }
      
      public function initLayout() : void
      {
         _button = new AvatarButton();
         _button.toggle = true;
         _button.width = 64;
         _button.height = 64;
         addChild(_button);
         _resourceImage = assetRepository.getDisplayObject(assetName);
         _button.addChild(_resourceImage);
         _typeTextField = new CaptionTextField();
         _typeTextField.width = _button.width;
         _typeTextField.height = 16;
         _typeTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _typeTextField.text = _typeText;
         _button.addChild(_typeTextField);
         _plusIconAsset = assetRepository.getDisplayObject("IconGreenPlus");
         _plusIconAsset.visible = false;
         addChild(_plusIconAsset);
         switchButtonState(0);
         _catapultMenuOptions = new CatapultMenuOptionsView(this,this.type);
         _catapultMenuOptions.visible = false;
         addChild(_catapultMenuOptions);
         createTooltip();
         drawLayout();
      }
      
      private function createTooltip() : void
      {
         createRechargeButton();
         _tooltipSprite = new Sprite();
         _tooltipTF = new WomTextField();
         _tooltipTF.extraCharWidth = 1.5;
         fillTooltipSprite(_tooltipSprite,_tooltipTF);
      }
      
      private function createRechargeButton() : void
      {
         _rechargeButton = new WomGreenMediumButton();
         _rechargeButton.width = 110;
         var _loc1_:TextField = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _loc1_.width = 110;
         _loc1_.defaultTextFormat = WomTextFormats.CENTER_18;
         var _temp_2:* = _loc1_;
         var _loc3_:String = "ui.mainframe.combat.catapult.rechargenow";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _loc1_.y = 1;
         _loc1_.height = 18;
         _rechargeButton.addChild(_loc1_);
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("Gold27");
         _loc2_.x = 40;
         _loc2_.y = 18;
         _loc2_.scaleX = _loc2_.scaleY = 0.7;
         _rechargeButton.addChild(_loc2_);
         rechargeButtonCostTF = new CaptionTextField();
         rechargeButtonCostTF.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         rechargeButtonCostTF.width = 25;
         rechargeButtonCostTF.height = 18;
         rechargeButtonCostTF.x = 54;
         rechargeButtonCostTF.y = 18;
         _rechargeButton.addChild(rechargeButtonCostTF);
         rechargeCostIsSet = false;
      }
      
      public function determineRechargeCost(param1:int) : void
      {
         if(!rechargeCostIsSet)
         {
            rechargeCostIsSet = true;
            _rechargeCost = Math.ceil(StoreUtil.resourcePrice(param1 / 10));
            rechargeButtonCostTF.text = _rechargeCost.toString();
         }
      }
      
      public function refreshButtonAppearance(param1:Boolean = true) : void
      {
         _plusIconAsset.visible = false;
         switch(buttonState)
         {
            case 0:
               _button.enabled = param1;
               _button.alpha = param1 ? 1 : 0.5;
               break;
            case 1:
               _button.enabled = param1;
               _button.alpha = param1 ? 1 : 0.5;
               break;
            case 2:
               _button.enabled = false;
               _button.alpha = 0.5;
               break;
            case 3:
               _button.alpha = 0.5;
               _button.enabled = false;
               break;
            case 4:
               _button.alpha = 0.5;
               _button.enabled = false;
               _plusIconAsset.visible = true;
         }
      }
      
      public function drawLayout() : void
      {
         _button.x = 0;
         _button.y = 0;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_resourceImage,_button,57 - _resourceImage.height);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_typeTextField,_button,37);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_catapultMenuOptions,_button,-_catapultMenuOptions.background.height);
         AlignmentUtil.alignMiddleOf(_plusIconAsset,_button);
         var _loc1_:Point = localToGlobal(new Point(_catapultMenuOptions.x,_catapultMenuOptions.y));
         if(_loc1_.x <= 0)
         {
            _catapultMenuOptions.x = 0;
         }
      }
      
      public function fillTooltipSprite(param1:Sprite, param2:TextField) : void
      {
         var _loc3_:Boolean = buttonState == 4;
         tooltipBg = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         tooltipBg.width = 124;
         tooltipBg.height = _loc3_ ? 112 : 67;
         param1.addChild(tooltipBg);
         bottomPin = assetRepository.getDisplayObject("TooltipsBottomPin");
         param1.addChild(bottomPin);
         param2.autoSize = "left";
         param2.defaultTextFormat = WomTextFormats.CENTER_16;
         param2.multiline = true;
         param2.wordWrap = true;
         param2.width = tooltipBg.width - 5;
         param2.text = "";
         param1.addChild(param2);
         if(_loc3_)
         {
            if(!param1.contains(_rechargeButton))
            {
               AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rechargeButton,tooltipBg,62);
               param1.addChild(_rechargeButton);
            }
         }
         else if(param1.contains(_rechargeButton))
         {
            param1.removeChild(_rechargeButton);
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(bottomPin,tooltipBg,tooltipBg.height - bottomPin.height + 5);
         AlignmentUtil.alignAccordingToPositionOf(param2,tooltipBg,2,5);
      }
      
      public function setTooltipParameters(param1:AttachableTooltipView, param2:Sprite, param3:PTextField) : void
      {
         tooltip = param1;
         _tooltipSprite = param2;
         _tooltipTF = param3;
         _tooltipTF.text = _tooltipText;
      }
      
      public function get tooltipText() : String
      {
         return _tooltipText;
      }
      
      public function get visibleWidth() : int
      {
         return _button.width;
      }
      
      public function get catapultMenuOptions() : CatapultMenuOptionsView
      {
         return _catapultMenuOptions;
      }
      
      public function updateButtonStateAndTooltip(param1:Boolean, param2:Number) : void
      {
         var _loc4_:String = _tooltipText;
         if(param1)
         {
            switch(type - 1)
            {
               case 0:
                  var _loc5_:String = "ui.mainframe.combat.catapult.lumbertooltip";
                  _tooltipText = peak.i18n.PText.INSTANCE.getText0(_loc5_);
                  break;
               case 1:
                  var _loc6_:String = "ui.mainframe.combat.catapult.stonetooltip";
                  _tooltipText = peak.i18n.PText.INSTANCE.getText0(_loc6_);
                  break;
               case 2:
                  var _loc7_:String = "ui.mainframe.combat.catapult.mighttooltip";
                  _tooltipText = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
         }
         else
         {
            var _temp_4:* = "ui.mainframe.combat.catapult.availablein";
            var _loc8_:String = DateTimeUtil.getFormattedTime(param2);
            var _loc9_:String = _temp_4;
            _tooltipText = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_);
         }
         _tooltipTF.text = _tooltipText;
         var _loc3_:Boolean = buttonState == 4;
         if(_loc3_)
         {
            if(!_tooltipSprite.contains(_rechargeButton))
            {
               AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rechargeButton,_tooltipSprite,62);
               _tooltipSprite.addChild(_rechargeButton);
               tooltipBg.height = 112;
               AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(bottomPin,tooltipBg,tooltipBg.height - bottomPin.height + 5);
               tooltip.updateTooltipAlignmentAccordingToObject((visibleWidth - _tooltipSprite.width) / 2,-_tooltipSprite.height + 12);
            }
         }
         else if(_tooltipSprite.contains(_rechargeButton))
         {
            _tooltipSprite.removeChild(_rechargeButton);
            tooltipBg.height = 67;
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(bottomPin,tooltipBg,tooltipBg.height - bottomPin.height + 5);
            tooltip.updateTooltipAlignmentAccordingToObject((visibleWidth - _tooltipSprite.width) / 2,-_tooltipSprite.height + 12);
         }
         _button.alpha = _button.enabled ? 1 : 0.5;
      }
      
      public function updateFilters() : void
      {
         _button.filters = _button.selected ? CombatEventItemView.SELECTED_FILTERS : [];
      }
      
      public function updateCatapultMenuOptionsVisibility(param1:Boolean) : void
      {
         _catapultMenuOptions.visible = param1;
         updateTooltipEnabling(!param1);
      }
      
      public function updateTooltipEnabling(param1:Boolean) : void
      {
         if(tooltip)
         {
            tooltip.updateEnablingOfTooltip(param1);
         }
      }
      
      public function get resourceType() : ResourceType
      {
         return _resourceType;
      }
      
      public function get button() : Button
      {
         return _button;
      }
      
      public function get rechargeButton() : WomButton
      {
         return _rechargeButton;
      }
      
      public function get rechargeCost() : int
      {
         return _rechargeCost;
      }
   }
}


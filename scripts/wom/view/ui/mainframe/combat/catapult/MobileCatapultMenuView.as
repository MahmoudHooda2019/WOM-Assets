package wom.view.ui.mainframe.combat.catapult
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.resource.ResourceType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileCatapultMenuView extends Sprite implements View
   {
      
      public static const SELECT:int = 0;
      
      public static const CANCEL:int = 1;
      
      public static const USED:int = 2;
      
      public static const NA:int = 3;
      
      public static const COUNT_DOWN:int = 4;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      public var type:int;
      
      private var _resourceType:ResourceType;
      
      public var assetName:String;
      
      private var _plusIconAsset:DisplayObject;
      
      private var _button:MobileWomButton;
      
      private var _typeText:String;
      
      private var _rechargeRemainingTimeTF:MPTextField;
      
      public var buttonState:int;
      
      public var catapultMenuTab:MobileCatapultMenuTab;
      
      private var _catapultMenuOptions:MobileCatapultMenuOptionsView;
      
      public function MobileCatapultMenuView(param1:MobileCatapultMenuTab, param2:int)
      {
         super();
         buttonState = 0;
         this.catapultMenuTab = param1;
         this.type = param2;
         switch(param2 - 1)
         {
            case 0:
               assetName = "CatapultButtonLumber";
               _resourceType = ResourceType.LUMBER;
               var _loc3_:String = "ui.mainframe.combat.catapult.lumber";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case 1:
               assetName = "CatapultButtonStone";
               _resourceType = ResourceType.STONE;
               var _loc4_:String = "ui.mainframe.combat.catapult.stone";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 2:
               assetName = "CatapultButtonMight";
               _resourceType = ResourceType.MIGHT;
               var _loc5_:String = "ui.mainframe.combat.catapult.might";
               _typeText = peak.i18n.PText.INSTANCE.getText0(_loc5_);
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
         _button = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
         _button.iconPosition = "top";
         _button.yMargin = 23;
         _button.defaultIcon = assetRepository.getDisplayObject(assetName);
         _button.disabledIcon = assetRepository.getDisplayObject(assetName);
         _button.disabledIcon.alpha = 0.5;
         _button.buttonTextFormat = getCaptionTextFormat(23);
         _button.isToggle = true;
         _button.width = 91;
         _button.label = _typeText;
         addChild(_button);
         _plusIconAsset = assetRepository.getDisplayObject("IconGreenAdd");
         _plusIconAsset.touchable = false;
         _plusIconAsset.visible = false;
         addChild(_plusIconAsset);
         _catapultMenuOptions = new MobileCatapultMenuOptionsView(this,this.type);
         _catapultMenuOptions.visible = false;
         addChild(_catapultMenuOptions);
         _rechargeRemainingTimeTF = new MobileWomTextField();
         _rechargeRemainingTimeTF.textRendererProperties.textFormat = getWomTextFormat(19);
         _rechargeRemainingTimeTF.touchable = false;
         addChild(_rechargeRemainingTimeTF);
         _rechargeRemainingTimeTF.text = "";
         switchButtonState(0);
         drawLayout();
      }
      
      public function refreshButtonAppearance(param1:Boolean = true) : void
      {
         switch(buttonState)
         {
            case 0:
               _button.isEnabled = param1;
               _button.label = _typeText;
               _rechargeRemainingTimeTF.visible = _plusIconAsset.visible = !param1;
               break;
            case 1:
               _button.isEnabled = param1;
               break;
            case 2:
               _button.isEnabled = false;
               break;
            case 3:
               _button.isEnabled = false;
               break;
            case 4:
               _button.isEnabled = true;
               var _temp_2:* = _button;
               var _loc3_:String = "ui.windows.catapult.recharge";
               _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               _rechargeRemainingTimeTF.visible = _plusIconAsset.visible = true;
         }
      }
      
      public function drawLayout() : void
      {
         _button.x = 0;
         _button.y = 0;
         _rechargeRemainingTimeTF.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_rechargeRemainingTimeTF,_button,27,3);
         MobileAlignmentUtil.alignMiddleOf(_plusIconAsset,_button);
      }
      
      public function get visibleWidth() : int
      {
         return _button.width;
      }
      
      public function get catapultMenuOptions() : MobileCatapultMenuOptionsView
      {
         return _catapultMenuOptions;
      }
      
      public function updateCatapultMenuOptionsVisibility(param1:Boolean) : void
      {
         _catapultMenuOptions.visible = param1;
      }
      
      public function get resourceType() : ResourceType
      {
         return _resourceType;
      }
      
      public function get button() : MobileWomButton
      {
         return _button;
      }
      
      public function get rechargeRemainingTimeTF() : MPTextField
      {
         return _rechargeRemainingTimeTF;
      }
   }
}


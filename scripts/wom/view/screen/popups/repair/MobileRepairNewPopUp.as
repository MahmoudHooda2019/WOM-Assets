package wom.view.screen.popups.repair
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   
   public class MobileRepairNewPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 570;
      
      private static const WINDOW_HEIGHT:int = 334;
      
      public static const TYPE_REPAIR_CONTINUING:int = 1;
      
      public static const TYPE_REPAIR_FINISHED:int = 2;
      
      private var _attackedBackground:DisplayObject;
      
      private var descriptionTextField:MPTextField;
      
      private var _type:int;
      
      private var _repairNowCost:int;
      
      public function MobileRepairNewPopUp(param1:int, param2:int = 0, param3:Vector.<WindowEnumeration> = null)
      {
         super(570,334,param3);
         _type = param1;
         _repairNowCost = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _imageAsset = assetRepository.getDisplayObject("MPose2Left");
         addChild(_imageAsset);
         descriptionTextField = new MobileWomTextField();
         descriptionTextField.textRendererProperties.textFormat = getWomTextFormat(27,"center",16777215);
         descriptionTextField.textRendererProperties.wordWrap = true;
         descriptionTextField.width = 300;
         addChild(descriptionTextField);
         var _loc1_:String;
         var _loc2_:String;
         descriptionTextField.text = _type == 1 ? (_loc1_ = "ui.popups.repair.message",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "ui.popups.repair.message2",peak.i18n.PText.INSTANCE.getText0(_loc2_));
         if(_type == 1)
         {
            var _loc3_:String = "ui.popups.repair.header";
            setHeader(peak.i18n.PText.INSTANCE.getText0(_loc3_));
            _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
            _actionButton.width = 390;
            var _temp_5:* = _actionButton;
            var _loc4_:String = "ui.popups.repairsite.repairall";
            _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            _actionButton.rightLabel = String(_repairNowCost);
            _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
            _actionButton.iconOffsetY = 3;
            _actionButton.iconOffsetX = 18;
            _actionButton.invalidate("styles");
         }
         else
         {
            var _loc5_:String = "ui.popups.repair.header1";
            setHeader(peak.i18n.PText.INSTANCE.getText0(_loc5_));
            _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
            _actionButton.width = 272;
            var _temp_8:* = _actionButton;
            var _loc6_:String = "ui.popups.repair.attacklogs";
            _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         addChild(_actionButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         _attackedBackground = assetRepository.getDisplayObject("AttackedBackground");
         _staticLayer.addChildAt(_attackedBackground,1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_attackedBackground,_background,14,14);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,10,_windowHeight - 19 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(descriptionTextField,_background,192,125);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,268);
      }
      
      public function get repairNowCost() : int
      {
         return _repairNowCost;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}


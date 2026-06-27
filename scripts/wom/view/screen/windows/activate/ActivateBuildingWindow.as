package wom.view.screen.windows.activate
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.ui.common.OrView;
   import wom.view.util.GenericWindow;
   
   public class ActivateBuildingWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 541;
      
      private static const WINDOW_HEIGHT:int = 541;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _requirements:Vector.<PartInfoDTO>;
      
      private var _promotionText:TextField;
      
      private var requiredItemView:Vector.<RequiredItemView>;
      
      private var _finishBuildingButton:WomBlueLargeButton;
      
      private var _buyAllForButton:WomGreenLargeButton;
      
      private var _buyAllForRequiredGold:int = 0;
      
      private var orIcon:DisplayObject;
      
      public function ActivateBuildingWindow(param1:BuildingInfo, param2:Vector.<PartInfoDTO>, param3:int = 541, param4:int = 541)
      {
         super(param3,param4);
         this._buildingInfo = param1;
         this._requirements = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "ui.windows.activate.header";
         var _loc1_:String = "domain.building." + buildingInfo.buildingTypeId + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         requiredItemView = new Vector.<RequiredItemView>();
         _promotionText = new WomTextField();
         _promotionText.defaultTextFormat = WomTextFormats.CENTER;
         var _temp_5:* = _promotionText;
         var _loc4_:String = "ui.windows.store.buyworkerwithparts.save";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _promotionText.width = _windowWidth;
         addChild(_promotionText);
         _finishBuildingButton = new WomBlueLargeButton();
         _finishBuildingButton.width = 206;
         _finishBuildingButton.enabled = false;
         var _temp_7:* = _finishBuildingButton;
         var _loc5_:String = "ui.windows.activate.finish";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_finishBuildingButton);
         _buyAllForButton = new WomGreenLargeButton();
         _buyAllForButton.width = 255;
         _buyAllForButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         var _temp_9:* = _buyAllForButton;
         var _loc6_:String = "ui.windows.activate.buyfor";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_buyAllForButton);
         orIcon = new OrView();
         addChild(orIcon);
         drawLayout();
      }
      
      public function addRequiredItemViews() : void
      {
         for each(var _loc2_ in requiredItemView)
         {
            removeChild(_loc2_);
         }
         requiredItemView.length = 0;
         var _loc3_:int = 0;
         for each(var _loc1_ in _requirements)
         {
            _loc3_++;
            _loc2_ = new RequiredItemView(_loc1_,_buildingTypeDIO,_loc3_ == 4);
            requiredItemView.push(_loc2_);
            addChild(_loc2_);
         }
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < requiredItemView.length)
         {
            requiredItemView[_loc1_].x = _loc1_ % 2 == 0 ? 64 : 284;
            requiredItemView[_loc1_].y = (_loc1_ / 2 << 0) * 218 + 40;
            _loc1_++;
         }
         _promotionText.y = 478;
         orIcon.visible = _buyAllForButton.visible;
         _finishBuildingButton.x = _buyAllForButton.visible ? 33 : 155;
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_finishBuildingButton,11,-11);
         _buyAllForButton.x = 255;
         _finishBuildingButton.y = _buyAllForButton.y = 541 - int(_finishBuildingButton.height / 2);
      }
      
      public function get finishBuildingButton() : WomBlueLargeButton
      {
         return _finishBuildingButton;
      }
      
      public function get buyAllForButton() : WomGreenLargeButton
      {
         return _buyAllForButton;
      }
      
      public function get requirements() : Vector.<PartInfoDTO>
      {
         return _requirements;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get promotionText() : TextField
      {
         return _promotionText;
      }
      
      public function get buyAllForRequiredGold() : int
      {
         return _buyAllForRequiredGold;
      }
      
      public function set buyAllForRequiredGold(param1:int) : void
      {
         _buyAllForRequiredGold = param1;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function set buildingTypeDIO(param1:BuildingTypeDIO) : void
      {
         _buildingTypeDIO = param1;
      }
   }
}


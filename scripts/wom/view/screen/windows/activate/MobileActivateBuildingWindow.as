package wom.view.screen.windows.activate
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileActivateBuildingWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 654;
      
      private static const WINDOW_HEIGHT:int = 685;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _requirements:Vector.<PartInfoDTO>;
      
      private var _promotionText:MPTextField;
      
      private var requiredItemView:Vector.<MobileRequiredItemView>;
      
      private var _finishBuildingButton:MobileWomButton;
      
      private var _buyAllForButton:MobileWomButton;
      
      private var _buyAllForRequiredGold:int = 0;
      
      public function MobileActivateBuildingWindow(param1:BuildingInfo, param2:Vector.<PartInfoDTO>, param3:int = 654, param4:int = 685)
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
         requiredItemView = new Vector.<MobileRequiredItemView>();
         _promotionText = new MobileWomTextField();
         _promotionText.textRendererProperties.textFormat = getWomTextFormat(23,"center",15923090);
         _promotionText.width = _windowWidth;
         addChild(_promotionText);
         var _temp_5:* = _promotionText;
         var _loc4_:String = "ui.windows.store.buyworkerwithparts.save";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _finishBuildingButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _finishBuildingButton.width = 167;
         _finishBuildingButton.isEnabled = false;
         var _temp_7:* = _finishBuildingButton;
         var _loc5_:String = "ui.windows.activate.mfinish";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_finishBuildingButton);
         _buyAllForButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _buyAllForButton.width = 330;
         _buyAllForButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         var _temp_9:* = _buyAllForButton;
         var _loc6_:String = "ui.windows.activate.buyfor";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_buyAllForButton);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < requiredItemView.length)
         {
            requiredItemView[_loc1_].x = _loc1_ % 2 == 0 ? 38 : 335;
            requiredItemView[_loc1_].y = (_loc1_ / 2 << 0) * 276 + 37;
            _loc1_++;
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_promotionText,_background,590);
         MobileAlignmentUtil.alignAccordingToPositionOf(_finishBuildingButton,_background,86,614);
         MobileAlignmentUtil.alignRightOf(_buyAllForButton,_finishBuildingButton,6);
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
            _loc2_ = new MobileRequiredItemView(_loc1_,_buildingTypeDIO,_loc3_ == 4);
            requiredItemView.push(_loc2_);
            addChild(_loc2_);
         }
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get requirements() : Vector.<PartInfoDTO>
      {
         return _requirements;
      }
      
      public function get promotionText() : MPTextField
      {
         return _promotionText;
      }
      
      public function get finishBuildingButton() : MobileWomButton
      {
         return _finishBuildingButton;
      }
      
      public function get buyAllForButton() : MobileWomButton
      {
         return _buyAllForButton;
      }
      
      public function get buyAllForRequiredGold() : int
      {
         return _buyAllForRequiredGold;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function set buyAllForRequiredGold(param1:int) : void
      {
         _buyAllForRequiredGold = param1;
      }
      
      public function set buildingTypeDIO(param1:BuildingTypeDIO) : void
      {
         _buildingTypeDIO = param1;
      }
   }
}


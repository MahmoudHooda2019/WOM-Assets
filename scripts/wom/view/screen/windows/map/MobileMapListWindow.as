package wom.view.screen.windows.map
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.MobileWomCheckBox;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileFullScreenWindow;
   
   public class MobileMapListWindow extends MobileFullScreenWindow
   {
      
      private var _headerListBg:DisplayObject;
      
      private var mapListPanel:MobileMapListPanel;
      
      private var _showAllCheckBox:MobileWomCheckBox;
      
      private var bottomBg:DisplayObject;
      
      private var _returnButton:MobileWomButton;
      
      private var _smartAttackButton:MobileWomButton;
      
      private var _tournamentAttackButton:MobileWomButton;
      
      private var _tournamentAttackWithGoldButton:MobileWomButton;
      
      private var _campaignButton:MobileWomButton;
      
      public function MobileMapListWindow()
      {
         super(true,null,null,false);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.windows.maplist.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _headerListBg = assetRepository.getDisplayObject("ListHeaderPassiveBackground");
         _headerListBg.width = _windowWidth + 4;
         addChildAt(_headerListBg,1);
         mapListPanel = new MobileMapListPanel();
         addChildAt(mapListPanel,2);
         _showAllCheckBox = new MobileWomCheckBox();
         _showAllCheckBox.setPaddings(10,40,10,10);
         addChild(_showAllCheckBox);
         _showAllCheckBox.defaultLabelProperties.textFormat = getWomTextFormat(23);
         var _temp_5:* = _showAllCheckBox;
         var _loc2_:String = "ui.windows.map.showall";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         bottomBg = assetRepository.getDisplayObject("MapListBackground");
         bottomBg.width = _windowWidth;
         addChild(bottomBg);
         _returnButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _returnButton.width = 178;
         _returnButton.defaultIcon = assetRepository.getDisplayObject("IconReturnMBordered");
         var _temp_8:* = _returnButton;
         var _loc3_:String = "ui.mainframe.city.mappanel.home";
         _temp_8.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_returnButton);
         _smartAttackButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _smartAttackButton.width = 304;
         _smartAttackButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         var _temp_10:* = _smartAttackButton;
         var _loc4_:String = "m.ui.windows.maplist.smartattack";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _smartAttackButton.rightLabel = (15).toString();
         addChild(_smartAttackButton);
         _tournamentAttackButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         var _temp_12:* = _tournamentAttackButton;
         var _loc5_:String = "ui.windows.alliance.tournament.attack";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _tournamentAttackButton.width = 304;
         addChild(_tournamentAttackButton);
         _tournamentAttackWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _tournamentAttackWithGoldButton.width = 304;
         _tournamentAttackWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         var _temp_14:* = _tournamentAttackWithGoldButton;
         var _loc6_:String = "ui.windows.alliance.tournament.attacknow";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_tournamentAttackWithGoldButton);
         _campaignButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _campaignButton.width = 162;
         var _temp_16:* = _campaignButton;
         var _loc7_:String = "ui.mainframe.city.mappanel.campaign";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_campaignButton);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         _headerListBg.x = -2;
         _headerListBg.y = 72;
         _showAllCheckBox.x = 12;
         _showAllCheckBox.y = 8;
         mapListPanel.x = _windowWidth - 999 >> 1;
         mapListPanel.y = 72;
         bottomBg.y = _windowHeight - bottomBg.height;
         MobileAlignmentUtil.alignAccordingToPositionOf(_returnButton,bottomBg,7,10);
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(_campaignButton,bottomBg,bottomBg.width - _campaignButton.width - 7,10);
         if(_tournamentAttackButton.visible)
         {
            _loc1_ = (_campaignButton.x - _returnButton.x - _returnButton.width - _tournamentAttackButton.width - _smartAttackButton.width - 20) / 2;
            MobileAlignmentUtil.alignRightOf(_tournamentAttackButton,_returnButton,_loc1_);
            MobileAlignmentUtil.alignRightOf(_smartAttackButton,_tournamentAttackButton,20);
         }
         else if(_tournamentAttackWithGoldButton.visible)
         {
            _loc1_ = (_campaignButton.x - _returnButton.x - _returnButton.width - _tournamentAttackWithGoldButton.width - _smartAttackButton.width - 20) / 2;
            MobileAlignmentUtil.alignRightOf(_tournamentAttackWithGoldButton,_returnButton,_loc1_);
            MobileAlignmentUtil.alignRightOf(_smartAttackButton,_tournamentAttackWithGoldButton,20);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_campaignButton,bottomBg,bottomBg.width - _campaignButton.width - 7,10);
      }
      
      public function get returnButton() : MobileWomButton
      {
         return _returnButton;
      }
      
      public function get smartAttackButton() : MobileWomButton
      {
         return _smartAttackButton;
      }
      
      public function get campaignButton() : MobileWomButton
      {
         return _campaignButton;
      }
      
      public function get showAllCheckBox() : MobileWomCheckBox
      {
         return _showAllCheckBox;
      }
      
      public function get tournamentAttackButton() : MobileWomButton
      {
         return _tournamentAttackButton;
      }
      
      public function get tournamentAttackWithGoldButton() : MobileWomButton
      {
         return _tournamentAttackWithGoldButton;
      }
      
      public function updateDurationRelatedFields(param1:Number, param2:Number) : void
      {
         var _loc4_:Boolean = param1 <= 0;
         var _loc3_:Boolean = param2 >= 0;
         _tournamentAttackButton.visible = _loc4_ && _loc3_;
         _tournamentAttackWithGoldButton.visible = !_loc4_ && _loc3_;
         if(!_loc4_)
         {
            _tournamentAttackWithGoldButton.rightLabel = StoreUtil.buildingPrice(0,param1 / 1000) + "";
         }
         drawLayout();
      }
   }
}


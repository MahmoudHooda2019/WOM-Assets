package wom.view.screen.windows.constructionsite
{
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.staff.StaffInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.screen.windows.staff.RequiredStaffsPanel;
   import wom.view.ui.common.OrView;
   
   public class CityCenterConstructionSiteWindow extends ConstructionSiteWindow
   {
      
      private static const WINDOW_WIDTH:int = 627;
      
      private static const WINDOW_HEIGHT:int = 380;
      
      private var infoTextField1:WomTextField;
      
      private var infoTextField2:WomTextField;
      
      private var orIcon:OrView;
      
      private var _askFriendsButton:WomButton;
      
      private var staffingPanel:RequiredStaffsPanel;
      
      public function CityCenterConstructionSiteWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingUpgradeJob, param4:Vector.<WindowEnumeration> = null)
      {
         super(param1,param2,param3,param4,627,380);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.constructionsite.upgradestarted";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         orIcon = new OrView();
         addChild(orIcon);
         _workerAsset.visible = false;
         speechBubble.visible = false;
         progressBackground.visible = false;
         staffingPanel = new RequiredStaffsPanel();
         staffingPanel.x = 22;
         staffingPanel.y = 90;
         addChild(staffingPanel);
         var _temp_4:* = WomTextFormats.FONT_SIZE_18;
         var _loc2_:String = "ui.windows.constructionsite.citycenterinformationtext";
         infoTextField1 = createInfoTextField(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),33);
         var _temp_7:* = WomTextFormats.FONT_SIZE_24;
         var _loc3_:String = "ui.windows.constructionsite.citycenterinformationtext2";
         infoTextField2 = createInfoTextField(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc3_),52);
         _askFriendsButton = new WomBlueLargeButton();
         _askFriendsButton.width = 188;
         var _temp_11:* = _askFriendsButton;
         var _loc4_:String = "ui.windows.constructionsite.askfriends";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_askFriendsButton);
         setChildIndex(_remainingDurationProgressBar,numChildren - 1);
         setChildIndex(clockIcon,numChildren - 1);
         setChildIndex(_abandonButton,numChildren - 1);
         setChildIndex(_shortenWithRPButton,numChildren - 1);
         setChildIndex(_finishNowButton,numChildren - 1);
         setChildIndex(orIcon,numChildren - 1);
         drawLayout();
      }
      
      private function createInfoTextField(param1:TextFormat, param2:String, param3:int) : WomTextField
      {
         var _loc4_:WomTextField = new WomTextField();
         _loc4_.width = _windowWidth - 60;
         _loc4_.height = 50;
         _loc4_.defaultTextFormat = param1;
         _loc4_.text = param2;
         _loc4_.x = 44;
         _loc4_.y = param3;
         addChild(_loc4_);
         return _loc4_;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         clockIcon.x = (_windowWidth - _remainingDurationProgressBar.width - _abandonButton.width - _shortenWithRPButton.width - 38) / 2;
         clockIcon.y = _windowHeight - 100;
         AlignmentUtil.alignAccordingToPositionOf(_remainingDurationProgressBar,clockIcon,29,7);
         drawButtonsAlignment();
      }
      
      override protected function createProgressBar() : ProgressBar30
      {
         var _loc1_:ProgressBar30 = new ProgressBar30();
         _loc1_.width = 292;
         _loc1_.textMarginX = 20;
         addChild(_loc1_);
         return _loc1_;
      }
      
      override protected function createAbondonButton() : WomButton
      {
         var _loc1_:WomButton = new WomBrownSmallButton();
         _loc1_.width = 90;
         var _temp_1:* = _loc1_;
         var _loc2_:String = "ui.windows.constructionsite.cancelbutton";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_loc1_);
         return _loc1_;
      }
      
      override protected function drawButtonsAlignment() : void
      {
         if(_askFriendsButton)
         {
            _askFriendsButton.x = _windowWidth - (_askFriendsButton.width + _finishNowButton.width + 18) >> 1;
            _askFriendsButton.y = _windowHeight - _askFriendsButton.height / 2 << 0;
            AlignmentUtil.alignRightOf(_finishNowButton,_askFriendsButton,18);
            AlignmentUtil.alignRightWithYMarginOf(orIcon,_askFriendsButton,11,-11);
            AlignmentUtil.alignAccordingToPositionOf(_abandonButton,_remainingDurationProgressBar,_remainingDurationProgressBar.width + 5,0);
            AlignmentUtil.alignRightOf(_shortenWithRPButton,_abandonButton,2);
         }
      }
      
      public function updateWithStaffList(param1:BuildingInfo, param2:Vector.<StaffDIO>, param3:Vector.<StaffInfo>, param4:Vector.<Vector.<int>>) : void
      {
         staffingPanel.updateWithStaffList(param1,param2,param3,param4);
         _askFriendsButton.enabled = !param3 || param2.length > param3.length;
      }
      
      public function get askFriendsButton() : WomButton
      {
         return _askFriendsButton;
      }
   }
}


package wom.view.screen.windows.store
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.staff.MobileRequiredStaffView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileHireWorkerWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 800;
      
      private static const WINDOW_HEIGHT:int = 350;
      
      private var infoTextField:MPTextField;
      
      private var _askForHelpButton:MobileWomButton;
      
      private var _hireInstantButton:MobileWomButton;
      
      private var _hireInstantRequiredGold:int = 0;
      
      private var _staffViewList:Vector.<MobileRequiredStaffView>;
      
      public function MobileHireWorkerWindow(param1:int = 800, param2:int = 350)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MobileRequiredStaffView = null;
         super.initLayout();
         var _loc3_:String = "ui.windows.store.buyworkerwithparts.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         infoTextField = new MobileWomTextField();
         infoTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
         var _temp_3:* = infoTextField;
         var _loc4_:String = "ui.windows.store.buyworkerwithparts.info";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         infoTextField.width = _windowWidth - 60;
         addChild(infoTextField);
         _staffViewList = new Vector.<MobileRequiredStaffView>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new MobileRequiredStaffView(_loc2_,null,null,0,true);
            _staffViewList.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
         _askForHelpButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _askForHelpButton.width = 281;
         var _temp_6:* = _askForHelpButton;
         var _loc5_:String = "ui.windows.store.buyworkerwithparts.askforhelp";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_askForHelpButton);
         _hireInstantButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _hireInstantButton.width = 432;
         _hireInstantButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         var _temp_8:* = _hireInstantButton;
         var _loc6_:String = "ui.windows.store.buyworkerwithparts.hireinstant";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_hireInstantButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc4_:int = 0;
         var _loc2_:MobileRequiredStaffView = null;
         MobileAlignmentUtil.alignAccordingToPositionOf(infoTextField,_background,42,38);
         var _loc3_:DisplayObject = null;
         _loc4_ = 0;
         while(_loc4_ < _staffViewList.length)
         {
            _loc2_ = _staffViewList[_loc4_];
            if(_loc4_ == 0)
            {
               _staffViewList[_loc4_].x = 42;
               _staffViewList[_loc4_].y = 100;
            }
            else
            {
               MobileAlignmentUtil.alignRightOf(_loc2_,_loc3_,12);
            }
            _loc3_ = _loc2_;
            _loc4_++;
         }
         var _loc1_:int = 18;
         _askForHelpButton.x = _windowWidth - (_askForHelpButton.width + (_hireInstantButton.visible ? _hireInstantButton.width + _loc1_ : 0)) >> 1;
         _askForHelpButton.y = _hireInstantButton.y = 350 - int(_askForHelpButton.height / 2);
         MobileAlignmentUtil.alignRightOf(_hireInstantButton,_askForHelpButton,_loc1_);
      }
      
      public function get askForHelpButton() : MPButton
      {
         return _askForHelpButton;
      }
      
      public function get hireInstantButton() : MPButton
      {
         return _hireInstantButton;
      }
      
      public function get hireInstantRequiredGold() : int
      {
         return _hireInstantRequiredGold;
      }
      
      public function set hireInstantRequiredGold(param1:int) : void
      {
         _hireInstantRequiredGold = param1;
         _hireInstantButton.rightLabel = _hireInstantRequiredGold + "";
      }
   }
}


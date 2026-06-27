package wom.view.screen.popups.tournament
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileTournamentEndedPopUp extends MobileGenericWindow
   {
      
      protected static const WINDOW_WIDTH:int = 611;
      
      protected static const WINDOW_HEIGHT:int = 430;
      
      private var _standing:int;
      
      private var _seasonEndTime:Number;
      
      private var _tournamentReward:Number;
      
      private var _decorationGiftId:int;
      
      private var _imageBackground:DisplayObject;
      
      private var _workerAsset:DisplayObject;
      
      private var _goldAsset:DisplayObject;
      
      private var _awardAsset:DisplayObject;
      
      private var titleTextField:MPTextField;
      
      protected var descTextField:MPTextField;
      
      private var _okButton:MPButton;
      
      private var tournamentRewardView:MobileTournamentRewardView;
      
      public function MobileTournamentEndedPopUp(param1:int, param2:Number, param3:Number = 0, param4:int = -1)
      {
         super(611,430);
         _standing = param1;
         _seasonEndTime = param2;
         _tournamentReward = param3;
         _decorationGiftId = param4;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc4_:String = "ui.windows.tournament.ended.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         _imageBackground = assetRepository.getDisplayObject("LeagueBackground");
         addChildAt(_imageBackground,1);
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc1_:String = DateTimeUtil.getFormattedDateFromMilliseconds(_seasonEndTime,".",4);
         if(_standing > 50)
         {
            _workerAsset = assetRepository.getDisplayObject("PoseWorker5");
            _workerAsset.scaleX = _workerAsset.scaleY = 0.9;
            addChild(_workerAsset);
            var _temp_4:* = "ui.windows.tournament.ended.desc.3";
            var _loc5_:String = _loc1_;
            var _loc6_:String = _temp_4;
            _loc2_ = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
            var _loc7_:String = "ui.windows.tournament.ended.button.gotit";
            _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         else
         {
            _goldAsset = assetRepository.getDisplayObject("FBGoldStack");
            addChild(_goldAsset);
            _goldAsset.scaleX = _goldAsset.scaleY = 0.8;
            tournamentRewardView = new MobileTournamentRewardView(_standing);
            addChild(tournamentRewardView);
            var _temp_8:* = "ui.windows.tournament.ended.desc.2";
            var _temp_7:* = _loc1_;
            var _loc8_:Number = _tournamentReward;
            var _loc9_:String = _temp_7;
            var _loc10_:String = _temp_8;
            _loc2_ = peak.i18n.PText.INSTANCE.getText2(_loc10_,_loc9_,_loc8_);
            var _loc11_:String = "ui.windows.tournament.ended.button.awesome";
            _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            if(_standing < 4)
            {
               _goldAsset.scaleX = _goldAsset.scaleY = 0.65;
               _awardAsset = assetRepository.getDisplayObject(getTournamentAssetId(_standing));
               _awardAsset.scaleX = _awardAsset.scaleY = 1.5;
               addChild(_awardAsset);
               var _temp_11:* = "ui.windows.tournament.ended.desc.1";
               var _temp_10:* = _loc1_;
               var _loc12_:Number = _tournamentReward;
               var _loc13_:String = _temp_10;
               var _loc14_:String = _temp_11;
               _loc2_ = peak.i18n.PText.INSTANCE.getText2(_loc14_,_loc13_,_loc12_);
            }
         }
         titleTextField = new MobileCaptionTextField();
         titleTextField.textRendererProperties.textFormat = getCaptionTextFormat(28,"left");
         addChild(titleTextField);
         var _temp_15:* = titleTextField;
         var _temp_14:* = "ui.windows.tournament.ended.title";
         var _temp_13:*;
         var _loc15_:String;
         var _loc16_:int;
         var _loc17_:String;
         var _loc18_:* = _standing <= 3 ? (_loc15_ = "ui.common.position." + _standing,peak.i18n.PText.INSTANCE.getText0(_loc15_)) : (_temp_13 = "ui.common.position.other",_loc16_ = _standing,_loc17_ = _temp_13,peak.i18n.PText.INSTANCE.getText1(_loc17_,_loc16_));
         var _loc19_:String = _temp_14;
         _temp_15.text = peak.i18n.PText.INSTANCE.getText1(_loc19_,_loc18_);
         descTextField = new MobileWomTextField();
         descTextField.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         descTextField.textRendererProperties.wordWrap = true;
         descTextField.width = 500;
         addChild(descTextField);
         descTextField.text = _loc2_;
         _okButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _okButton.width = 244;
         addChild(_okButton);
         _okButton.label = _loc3_;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageBackground,_background,14,14);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(titleTextField,_background,50);
         if(_standing < 4)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_goldAsset,_background,115);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_awardAsset,_background,78);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,_background,250);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(tournamentRewardView,_background,310);
            _awardAsset.x += 20;
         }
         else if(_standing < 51)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_goldAsset,_background,75);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,_background,235);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(tournamentRewardView,_background,315);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_workerAsset,_background,60);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,_background,280);
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,430 - 55);
      }
      
      public function get imageBackground() : DisplayObject
      {
         return _imageBackground;
      }
      
      public function get workerAsset() : DisplayObject
      {
         return _workerAsset;
      }
      
      public function get goldAsset() : DisplayObject
      {
         return _goldAsset;
      }
      
      public function get awardAsset() : DisplayObject
      {
         return _awardAsset;
      }
      
      public function get okButton() : MPButton
      {
         return _okButton;
      }
      
      public function getTournamentAssetId(param1:int) : String
      {
         if(_standing == 1)
         {
            return "TournamentGold";
         }
         if(_standing == 2)
         {
            return "TournamentSilver";
         }
         if(_standing == 3)
         {
            return "TournamentBronze";
         }
         return "";
      }
   }
}


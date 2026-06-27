package wom.view.screen.windows.staff
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileIconLabelView;
   
   public class MobileRequiredStaffView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _staff:StaffInfo;
      
      private var _staffDIO:StaffDIO;
      
      private var _background:DisplayObject;
      
      private var _headerTextField:MPTextField;
      
      private var _avatarBG:DisplayObject;
      
      private var _avatar:DisplayObject;
      
      private var _questionMarkTextField:MPTextField;
      
      private var _staffNameTextField:MPTextField;
      
      private var _customInfoTextField:MPTextField;
      
      private var _checkAsset:DisplayObject;
      
      private var _hourglassAsset:DisplayObject;
      
      private var _goldView:MobileIconLabelView;
      
      private var _instanceId:int;
      
      private var _customInfo:int;
      
      private var _worker:Boolean;
      
      private var initialized:Boolean;
      
      public function MobileRequiredStaffView(param1:int, param2:StaffDIO, param3:StaffInfo, param4:int, param5:Boolean = false)
      {
         super();
         _staffDIO = param2;
         _staff = param3;
         _instanceId = param1;
         _customInfo = param4;
         _worker = param5;
         initialized = false;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         this.useHandCursor = true;
         _background = assetRepository.getDisplayObject("MobileBeigeBackground");
         _background.width = 170;
         _background.height = 188;
         addChild(_background);
         _headerTextField = new MobileCaptionTextField();
         _headerTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         _headerTextField.width = _background.width;
         var _loc1_:String;
         var _loc2_:String;
         _headerTextField.text = _worker ? (_loc1_ = "worker.staff." + _instanceId + ".name",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "domain.staffs." + _staffDIO.id + ".name",peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(_headerTextField);
         _avatarBG = assetRepository.getDisplayObject("BeigeLargeBackground");
         _avatarBG.width = _avatarBG.height = 91;
         addChild(_avatarBG);
         _questionMarkTextField = new MobileCaptionTextField();
         _questionMarkTextField.textRendererProperties.textFormat = getCaptionTextFormat(62,"center");
         addChild(_questionMarkTextField);
         _questionMarkTextField.text = "?";
         addRemoveAvatar();
         _staffNameTextField = new MobileCaptionTextField();
         _staffNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         _staffNameTextField.width = 122;
         _staffNameTextField.height = 28;
         _staffNameTextField.text = "";
         addChild(_staffNameTextField);
         _customInfoTextField = new MobileWomTextField();
         _customInfoTextField.textRendererProperties.textFormat = getWomTextFormat(21,_worker ? "left" : "center");
         _customInfoTextField.width = _worker ? 40 : _background.width;
         var _loc3_:String;
         _customInfoTextField.text = _worker ? (_loc3_ = "ui.windows.store.buyworkerwithparts.savetext",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : getTimeReductionText();
         addChild(_customInfoTextField);
         _checkAsset = assetRepository.getDisplayObject("SymbolTickSelected");
         addChild(_checkAsset);
         _hourglassAsset = assetRepository.getDisplayObject("IconHourglass");
         _hourglassAsset.scaleX = _hourglassAsset.scaleY = 0.5;
         _hourglassAsset.visible = !_worker;
         addChild(_hourglassAsset);
         _goldView = new MobileIconLabelView("IconGoldS",_customInfo + "",-1,null,null,null,true,1,"left");
         _goldView.visible = _worker;
         _goldView.textMargin = -5;
         addChild(_goldView);
         initialized = true;
         drawLayout();
      }
      
      private function addRemoveAvatar() : void
      {
         if(_staff)
         {
            if(_staff.profile.platformId == null)
            {
               _avatar = assetRepository.getDisplayObject("MobileBeigeBackground");
               _avatar.width = _avatar.height = 90;
            }
            else
            {
               _avatar = assetRepository.getDisplayObject("MobileBeigeBackground");
               _avatar.width = _avatar.height = 90;
            }
            _avatar.visible = false;
            addChildAt(_avatar,getChildIndex(_avatarBG) + 1);
         }
      }
      
      private function getTimeReductionText() : String
      {
         var _loc1_:Number = _customInfo / 60;
         var _loc4_:Number = _customInfo / (60 * 60);
         var _loc3_:Boolean = _loc4_ - int(_loc4_) == 0;
         var _loc2_:String = _loc3_ ? _loc4_.toString() : _loc4_.toFixed(1);
         var _temp_2:*;
         var _temp_3:*;
         var _loc5_:String;
         var _loc6_:String;
         return _loc4_ > 1 ? (_temp_2 = _loc2_ + " ",_loc5_ = "ui.windows.activatebuildingbystaffs.hours",_temp_2 + peak.i18n.PText.INSTANCE.getText0(_loc5_)) : (_temp_3 = _loc1_.toString() + " ",_loc6_ = "ui.windows.activatebuildingbystaffs.minutes",_temp_3 + peak.i18n.PText.INSTANCE.getText0(_loc6_));
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_headerTextField,_background,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_avatarBG,_background,26);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_questionMarkTextField,_avatarBG,24);
         if(_avatar)
         {
            MobileAlignmentUtil.alignMiddleOf(_avatar,_avatarBG);
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_staffNameTextField,_background,79);
         MobileAlignmentUtil.alignAccordingToPositionOf(_customInfoTextField,_background,_worker ? 45 : 0,136);
         MobileAlignmentUtil.alignRightWithYMarginOf(_goldView,_customInfoTextField,-7,5);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_checkAsset,_background,_worker ? 167 : 167);
         var _loc1_:int = (_background.width - _hourglassAsset.width) / 2;
         MobileAlignmentUtil.alignAccordingToPositionOf(_hourglassAsset,_background,_loc1_,167);
         _checkAsset.visible = _staff != null;
         _questionMarkTextField.visible = _staff == null;
         _customInfoTextField.visible = _worker && !_staff != null || !_worker;
         _hourglassAsset.visible = !_worker && _staff == null;
         _goldView.visible = _worker && _staff == null;
         _customInfoTextField.visible = !_worker || _staff == null;
      }
      
      public function updateFriend(param1:FriendInfo, param2:String) : void
      {
         removeChild(_avatar);
         _avatar = assetRepository.getAvatarByProfile(param1.profile);
         addChild(_avatar);
         _staffNameTextField.text = param2;
         setChildIndex(_staffNameTextField,numChildren - 1);
         drawLayout();
      }
      
      public function get staff() : StaffInfo
      {
         return _staff;
      }
      
      public function get staffDIO() : StaffDIO
      {
         return _staffDIO;
      }
      
      public function get avatar() : DisplayObject
      {
         return _avatar;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get customInfo() : int
      {
         return _customInfo;
      }
      
      public function set customInfo(param1:int) : void
      {
         _customInfo = param1;
      }
      
      public function get worker() : Boolean
      {
         return _worker;
      }
      
      public function set staffInfo(param1:StaffInfo) : void
      {
         _staff = param1;
         if(initialized)
         {
            addRemoveAvatar();
            drawLayout();
         }
      }
   }
}


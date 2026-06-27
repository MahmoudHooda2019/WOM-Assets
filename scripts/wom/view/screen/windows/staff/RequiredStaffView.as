package wom.view.screen.windows.staff
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.ButtonCursorManager;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.ui.common.IconLabelView;
   
   public class RequiredStaffView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _staff:StaffInfo;
      
      private var _staffDIO:StaffDIO;
      
      private var _background:AssetDisplayObject;
      
      private var _headerTextField:TextField;
      
      private var _avatarBG:DisplayObject;
      
      private var _avatar:AssetDisplayObject;
      
      private var _staffNameTextField:TextField;
      
      private var _customInfoTextField:TextField;
      
      private var _checkAsset:AssetDisplayObject;
      
      private var _hourglassAsset:AssetDisplayObject;
      
      private var _goldView:IconLabelView;
      
      private var _instanceId:int;
      
      private var _customInfo:int;
      
      private var _worker:Boolean;
      
      private var cursorManager:ButtonCursorManager;
      
      private var initialized:Boolean;
      
      public function RequiredStaffView(param1:int, param2:StaffDIO, param3:StaffInfo, param4:int, param5:Boolean = false)
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
         this.buttonMode = true;
         this.useHandCursor = true;
         cursorManager = new ButtonCursorManager(this);
         _background = assetRepository.getDisplayObject("ShinyBackgroundLarge");
         addChild(_background);
         _headerTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _headerTextField.multiline = true;
         _headerTextField.wordWrap = true;
         _headerTextField.autoSize = "center";
         _headerTextField.width = 122;
         var _loc1_:String;
         var _loc2_:String;
         _headerTextField.text = _worker ? (_loc1_ = "worker.staff." + _instanceId + ".name",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "domain.staffs." + _staffDIO.id + ".name",peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(_headerTextField);
         _avatarBG = assetRepository.getDisplayObject("StaffCityCenterEmpty");
         addChild(_avatarBG);
         addRemoveAvatar();
         _staffNameTextField = new CaptionTextField();
         _staffNameTextField.defaultTextFormat = WomTextFormats.CENTER_14;
         _staffNameTextField.width = 122;
         _staffNameTextField.height = 28;
         _staffNameTextField.text = "";
         addChild(_staffNameTextField);
         _customInfoTextField = new WomTextField();
         _customInfoTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _customInfoTextField.width = 122;
         _customInfoTextField.height = 28;
         var _loc3_:String;
         _customInfoTextField.text = _worker ? (_loc3_ = "ui.windows.store.buyworkerwithparts.savetext",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : getTimeReductionText();
         addChild(_customInfoTextField);
         _checkAsset = assetRepository.getDisplayObject("Check");
         addChild(_checkAsset);
         _hourglassAsset = assetRepository.getDisplayObject("UpgradeBtnIcon");
         _hourglassAsset.visible = !_worker;
         addChild(_hourglassAsset);
         var _temp_11:* = §§findproperty(IconLabelView);
         var _temp_10:* = "Gold27";
         var _temp_9:* = "ui.windows.gold.gold";
         var _loc4_:int = _customInfo;
         var _loc5_:String = _temp_9;
         _goldView = new IconLabelView(_temp_10,peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_),-1);
         _goldView.align = "left";
         _goldView.visible = _worker;
         addChild(_goldView);
         initialized = true;
         drawLayout();
      }
      
      private function addRemoveAvatar() : void
      {
         if(_staff)
         {
            if(_staff.profile.platformId == null && _staff.profile.avatar == null)
            {
               _avatar = assetRepository.getDisplayObject("StaffCityCenterWithGold");
            }
            else
            {
               _avatar = assetRepository.getAvatarByProfile(_staff.profile);
            }
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
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_headerTextField,_background,-10);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_avatarBG,_background,26);
         if(_avatar)
         {
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_avatar,_background,34);
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_staffNameTextField,_background,75);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_customInfoTextField,_background,_worker ? 98 : 92);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_goldView,_background,117);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_checkAsset,_background,_worker ? 98 : 108);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_hourglassAsset,_background,111);
         _checkAsset.visible = _staff != null;
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
      
      public function get avatar() : AssetDisplayObject
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


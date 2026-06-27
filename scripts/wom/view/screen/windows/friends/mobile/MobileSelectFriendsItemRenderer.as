package wom.view.screen.windows.friends.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPCheckBox;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.friend.FriendInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomCheckBox;
   import wom.view.getCaptionTextFormat;
   
   public class MobileSelectFriendsItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      public static const WIDTH:int = 394;
      
      public static const HEIGHT:int = 96;
      
      private var _friendInfo:FriendInfo;
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _avatar:DisplayObject;
      
      private var _nameTextField:MPTextField;
      
      private var _checkbox:MPCheckBox;
      
      public function MobileSelectFriendsItemRenderer(param1:MobileWomAssetRepository)
      {
         super();
         _assetRepository = param1;
         _background = param1.getDisplayObject("MobileBeigeBackground");
         _background.width = 394;
         _background.height = 96;
         addChild(_background);
         _nameTextField = new MobileCaptionTextField();
         _nameTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _nameTextField.width = 230;
         addChild(_nameTextField);
         _checkbox = new MobileWomCheckBox();
         addChild(_checkbox);
         drawLayout();
      }
      
      override public function get data() : Object
      {
         return _friendInfo;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _friendInfo = param1 as FriendInfo;
            clear();
            _avatar = _assetRepository.getAvatarByProfile(_friendInfo.profile);
            addChildAt(_avatar,1);
            _nameTextField.text = _friendInfo.name;
         }
         drawLayout();
      }
      
      private function clear() : void
      {
         if(_avatar && contains(_avatar))
         {
            removeChild(_avatar);
         }
      }
      
      public function drawLayout() : void
      {
         if(_avatar)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_avatar,_background,12,10);
         }
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_nameTextField,_background,90);
         MobileAlignmentUtil.alignAccordingToPositionOf(_checkbox,_background,324,23);
      }
      
      public function get friendInfo() : FriendInfo
      {
         return _friendInfo;
      }
      
      public function updateUserNameTextField(param1:String) : void
      {
         if(param1 != _nameTextField.text)
         {
            _nameTextField.text = param1;
         }
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         super.isSelected = param1;
         _checkbox.isSelected = param1;
      }
   }
}


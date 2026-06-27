package wom.view.screen.popups
{
   import peak.component.mobile.MPTextField;
   import peak.component.mobile.MPTextInput;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileGuestNamingPopUp extends MobileBasePopUp
   {
      
      private const WINDOW_WIDTH:int = 556;
      
      private const WINDOW_HEIGHT:int = 298;
      
      private var _limitationTF:MPTextField;
      
      private var _nameInput:MPTextInput;
      
      private var _enterNameTF:MPTextField;
      
      private var _avatarAsset:DisplayObject;
      
      private var _avatarId:int;
      
      private const _avatarAssetIds:Vector.<Object> = new Vector.<Object>();
      
      public function MobileGuestNamingPopUp()
      {
         super(556,298,null,false);
         _avatarAssetIds.push({
            "assetId":"GuestAvatar1",
            "id":1
         });
         _avatarAssetIds.push({
            "assetId":"GuestAvatar2",
            "id":2
         });
         _avatarAssetIds.push({
            "assetId":"GuestAvatar3",
            "id":3
         });
         _avatarAssetIds.push({
            "assetId":"GuestAvatar4",
            "id":4
         });
         _avatarAssetIds.push({
            "assetId":"GuestAvatar5",
            "id":5
         });
         _avatarAssetIds.push({
            "assetId":"GuestAvatar6",
            "id":6
         });
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.popups.guestnaming.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("MPose7Right");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 337;
         var _loc2_:String = "m.ui.popups.guestnaming.desc";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,null,22,110,100);
         addChild(_speechBubble);
         _avatarAsset = assetRepository.getDisplayObject(determineAvatarAssetId());
         addChild(_avatarAsset);
         _nameInput = new MobileWomTextInput();
         _nameInput.width = 196;
         _nameInput.maxChars = 10;
         addChild(_nameInput);
         _enterNameTF = new MobileWomTextField();
         _enterNameTF.textRendererProperties.textFormat = getWomTextFormat(23,"center",8882055);
         addChild(_enterNameTF);
         var _temp_9:* = _enterNameTF;
         var _loc3_:String = "m.ui.popups.guestnaming.enterName";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _enterNameTF.touchable = false;
         _limitationTF = new MobileWomTextField();
         _limitationTF.textRendererProperties.textFormat = getWomTextFormat(19);
         addChild(_limitationTF);
         var _temp_11:* = _limitationTF;
         var _loc4_:String = "m.ui.popups.guestnaming.limitation";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 259;
         _actionButton.isEnabled = false;
         addChild(_actionButton);
         var _temp_13:* = _actionButton;
         var _loc5_:String = "m.ui.popups.guestnaming.done";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,8,_background.height - _imageAsset.height - 18);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,183,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(_avatarAsset,_speechBubble,33,69);
         MobileAlignmentUtil.alignAccordingToPositionOf(_nameInput,_speechBubble,115,72);
         MobileAlignmentUtil.alignMiddleOf(_enterNameTF,_nameInput);
         MobileAlignmentUtil.alignBelowOf(_limitationTF,_speechBubble,5);
         _limitationTF.x += _speechBubble.width - _limitationTF.width - 20;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - (_actionButton.height >> 1) - 12);
      }
      
      public function onKeyboardOpened(param1:Event) : void
      {
         if(_enterNameTF.visible)
         {
            _enterNameTF.visible = false;
         }
      }
      
      private function determineAvatarAssetId() : String
      {
         var _loc2_:int = int(Math.random() * 100) % _avatarAssetIds.length;
         var _loc1_:Object = _avatarAssetIds[_loc2_];
         _avatarId = _loc1_.id;
         return _loc1_.assetId;
      }
      
      public function get nameInput() : MPTextInput
      {
         return _nameInput;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
   }
}


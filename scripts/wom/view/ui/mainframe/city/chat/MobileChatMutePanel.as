package wom.view.ui.mainframe.city.chat
{
   import feathers.controls.Button;
   import feathers.controls.Label;
   import peak.component.mobile.MPRigidButton;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Graphics;
   import starling.display.Shape;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileChatMutePanel extends Sprite implements View
   {
      
      private var _muteBackground:Shape;
      
      private var _senderPid:String;
      
      private var _muteButton:Button;
      
      private var _nameTextField:Label;
      
      private var _closeButton:Button;
      
      public function MobileChatMutePanel()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _muteBackground = new Shape();
         var _loc1_:Graphics = _muteBackground.graphics;
         _loc1_.beginFill(0,0.75);
         _loc1_.drawRoundRect(0,0,visibleWidth,visibleHeight,8);
         _loc1_.endFill();
         addChild(_muteBackground);
         _closeButton = new MPRigidButton("ButtonClose","ButtonCloseHover");
         addChild(_closeButton);
         _muteButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Small");
         _muteButton.width = 70;
         var _temp_4:* = _muteButton;
         var _loc2_:String = "ui.mainframe.city.chat.mute";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _muteButton.visible = true;
         addChild(_muteButton);
         _nameTextField = new MobileCaptionTextField();
         _nameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33);
         _nameTextField.height = 20;
         addChild(_nameTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignRightWithYMarginOf(_closeButton,_muteBackground,5,-_closeButton.width - 5);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_nameTextField,_muteBackground,70);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_muteButton,_muteBackground,115);
      }
      
      public function updateMutePanel(param1:String, param2:String) : void
      {
         _nameTextField.text = param1;
         _senderPid = param2;
         drawLayout();
      }
      
      public function get visibleWidth() : int
      {
         return 177;
      }
      
      public function get visibleHeight() : int
      {
         return 241;
      }
      
      public function get muteButton() : Button
      {
         return _muteButton;
      }
      
      public function get closeButton() : Button
      {
         return _closeButton;
      }
      
      public function get senderPid() : String
      {
         return _senderPid;
      }
      
      public function set senderPid(param1:String) : void
      {
         _senderPid = param1;
      }
   }
}


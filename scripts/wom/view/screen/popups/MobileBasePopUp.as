package wom.view.screen.popups
{
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.ui.common.MobileSpeechBubbleView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBasePopUp extends MobileGenericWindow
   {
      
      protected var _imageAsset:DisplayObject;
      
      protected var _speechBubble:MobileSpeechBubbleView;
      
      protected var _actionButton:MobileWomButton;
      
      public function MobileBasePopUp(param1:int, param2:int, param3:Vector.<WindowEnumeration> = null, param4:Object = null, param5:Object = null)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function get imageAsset() : DisplayObject
      {
         return _imageAsset;
      }
      
      public function set imageAsset(param1:DisplayObject) : void
      {
         _imageAsset = param1;
      }
      
      public function get speechBubble() : MobileSpeechBubbleView
      {
         return _speechBubble;
      }
      
      public function set speechBubble(param1:MobileSpeechBubbleView) : void
      {
         _speechBubble = param1;
      }
      
      public function get actionButton() : MobileWomButton
      {
         return _actionButton;
      }
      
      public function set actionButton(param1:MobileWomButton) : void
      {
         _actionButton = param1;
      }
   }
}


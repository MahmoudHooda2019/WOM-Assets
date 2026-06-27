package wom.view.screen.popups.emailpermission
{
   import peak.i18n.PText;
   import wom.model.game.window.MobileWindowEnumerationButton;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   
   public class MobileEmailPermissionDeniedPopUp extends MobileClementineChangableActionPopUp
   {
      
      private static const WINDOW_WIDTH:int = 604;
      
      private static const WINDOW_HEIGHT:int = 245;
      
      public function MobileEmailPermissionDeniedPopUp()
      {
         var _loc1_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _loc1_.width = 280;
         var _temp_1:* = _loc1_;
         var _loc3_:String = "m.ui.popups.emailpermissiondenied.gotit";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc2_:Vector.<MobileWindowEnumerationButton> = new <MobileWindowEnumerationButton>[new MobileWindowEnumerationButton(null,_loc1_)];
         var _temp_5:* = this;
         var _temp_4:* = 2;
         var _loc4_:String = "m.ui.popups.emailpermissiondenied.header";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = "m.ui.popups.emailpermissiondenied.desc";
         _temp_5.super(_temp_4,_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc5_),_loc2_,604,245);
      }
      
      override protected function getDescTextFieldWidth() : Number
      {
         return 394;
      }
      
      override protected function getSpeechBubbleArrowYMargin() : int
      {
         return 64;
      }
   }
}


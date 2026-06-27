package wom.view.screen.popups
{
   import peak.i18n.PText;
   import wom.model.game.window.MobileWindowEnumerationButton;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileOutOfOffersPopUp extends MobileClementineChangableActionPopUp
   {
      
      private static const WINDOW_WIDTH:int = 604;
      
      private static const WINDOW_HEIGHT:int = 245;
      
      public function MobileOutOfOffersPopUp()
      {
         var _loc4_:String = "m.ui.popups.outofoffers.header";
         var _loc3_:String = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = "m.ui.popups.outofoffers.desc";
         var _loc1_:String = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         var _loc2_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _loc2_.width = 280;
         var _temp_1:* = _loc2_;
         var _loc6_:String = "m.ui.popups.outofoffers.gotit";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         super(2,_loc3_,_loc1_,new <MobileWindowEnumerationButton>[new MobileWindowEnumerationButton(null,_loc2_)],604,245);
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


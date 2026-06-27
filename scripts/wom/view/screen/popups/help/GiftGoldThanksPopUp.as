package wom.view.screen.popups.help
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.game.gold.GoldGift;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   import wom.view.util.PopperBackgroundUtil;
   
   public class GiftGoldThanksPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 450;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _goldGift:GoldGift;
      
      private var _effectBackground:DisplayObject;
      
      private var _clementineAsset:DisplayObject;
      
      private var _speechBubble:SpeechBubbleView;
      
      private var _okButton:WomButton;
      
      public function GiftGoldThanksPopUp(param1:GoldGift)
      {
         super(450,306);
         _goldGift = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.helpedfriend.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _clementineAsset = assetRepository.getDisplayObject("ClementineMaybe");
         addChild(_clementineAsset);
         var _temp_6:* = §§findproperty(SpeechBubbleView);
         var _temp_5:* = 350;
         var _temp_4:* = "ui.windows.giftgold.thanks.desc";
         var _temp_3:* = _goldGift.sender.gameId;
         var _loc2_:String = NumberUtil.numberFormat(_goldGift.amountOfGold,0);
         var _loc3_:String = _temp_3;
         var _loc4_:String = _temp_4;
         _speechBubble = new SpeechBubbleView(_temp_5,peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_),25);
         addChild(_speechBubble);
         _okButton = new WomBlueLargeButton();
         _okButton.width = 170;
         var _temp_9:* = _okButton;
         var _loc5_:String = "ui.windows.giftgold.thanks.wow";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_okButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         _effectBackground = PopperBackgroundUtil.createPopper(this,assetRepository.getDisplayObject("Patlangac"),13,13,424,280,525);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,-37,-14);
         AlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,75,98);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,_background.height - 43);
      }
      
      public function get clementineAsset() : DisplayObject
      {
         return _clementineAsset;
      }
      
      public function get okButton() : WomButton
      {
         return _okButton;
      }
      
      public function get goldGift() : GoldGift
      {
         return _goldGift;
      }
      
      public function updateSpeechBubble(param1:String) : void
      {
         var _temp_3:* = _speechBubble;
         var _temp_2:* = "ui.windows.giftgold.thanks.desc";
         var _temp_1:* = param1;
         var _loc2_:String = NumberUtil.numberFormat(_goldGift.amountOfGold,0);
         var _loc3_:String = _temp_1;
         var _loc4_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_);
      }
   }
}


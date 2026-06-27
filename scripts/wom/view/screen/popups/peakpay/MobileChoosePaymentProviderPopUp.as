package wom.view.screen.popups.peakpay
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileChoosePaymentProviderPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 750;
      
      private static const WINDOW_HEIGHT:int = 450;
      
      private var _productId:String;
      
      private var _amountOfGold:int;
      
      private var _peakPayId:String;
      
      private var _peakPayButton:MPButton;
      
      private var _googleWalletButton:MPButton;
      
      private var _iconBackground1:DisplayObject;
      
      private var _iconBackground2:DisplayObject;
      
      private var _iconContainerPeakPay:Sprite;
      
      private var _iconAvea:DisplayObject;
      
      private var _iconTurkcell:DisplayObject;
      
      private var _iconVodafone:DisplayObject;
      
      private var _iconContainerGoogleWallet:Sprite;
      
      private var _iconVisa:DisplayObject;
      
      private var _iconMastercard:DisplayObject;
      
      private var _iconPeakGames:DisplayObject;
      
      private var _iconGoogleWallet:DisplayObject;
      
      public function MobileChoosePaymentProviderPopUp(param1:String, param2:int, param3:String)
      {
         super(750,450);
         _productId = param1;
         _amountOfGold = param2;
         _peakPayId = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "ui.windows.gold.gold";
         var _loc1_:int = _amountOfGold;
         var _loc2_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_));
         _iconBackground1 = assetRepository.getDisplayObject("MobileBeigeBackground");
         _iconBackground1.width = 325;
         _iconBackground1.height = 173;
         addChild(_iconBackground1);
         _iconBackground2 = assetRepository.getDisplayObject("MobileBeigeBackground");
         _iconBackground2.width = 325;
         _iconBackground2.height = 173;
         addChild(_iconBackground2);
         _iconContainerPeakPay = new Sprite();
         _iconAvea = assetRepository.getDisplayObject("IconAvea");
         _iconContainerPeakPay.addChild(_iconAvea);
         _iconTurkcell = assetRepository.getDisplayObject("IconTurkcell");
         _iconContainerPeakPay.addChild(_iconTurkcell);
         _iconVodafone = assetRepository.getDisplayObject("IconVodafone");
         _iconContainerPeakPay.addChild(_iconVodafone);
         addChild(_iconContainerPeakPay);
         _iconContainerGoogleWallet = new Sprite();
         _iconVisa = assetRepository.getDisplayObject("IconVisa");
         _iconContainerGoogleWallet.addChild(_iconVisa);
         _iconMastercard = assetRepository.getDisplayObject("IconMastercard");
         _iconContainerGoogleWallet.addChild(_iconMastercard);
         addChild(_iconContainerGoogleWallet);
         _iconPeakGames = assetRepository.getDisplayObject("IconPeakGames");
         addChild(_iconPeakGames);
         _iconGoogleWallet = assetRepository.getDisplayObject("IconGoogleWallet");
         addChild(_iconGoogleWallet);
         _peakPayButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _peakPayButton.width = 325;
         _peakPayButton.setPaddings(0,0,0,200);
         addChild(_peakPayButton);
         var _temp_15:* = _peakPayButton;
         var _loc3_:String = "m.ui.windows.gold.provider.peakpay";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _googleWalletButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _googleWalletButton.width = 325;
         _googleWalletButton.setPaddings(0,0,0,200);
         addChild(_googleWalletButton);
         var _temp_17:* = _googleWalletButton;
         var _loc4_:String = "m.ui.windows.gold.provider.wallet";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_peakPayButton,_background,40,110);
         MobileAlignmentUtil.alignRightOf(_googleWalletButton,_peakPayButton,20);
         MobileAlignmentUtil.alignBelowOf(_iconBackground1,_peakPayButton,20);
         MobileAlignmentUtil.alignBelowOf(_iconBackground2,_googleWalletButton,20);
         MobileAlignmentUtil.alignRightOf(_iconTurkcell,_iconAvea);
         MobileAlignmentUtil.alignRightOf(_iconVodafone,_iconTurkcell);
         MobileAlignmentUtil.alignRightOf(_iconMastercard,_iconVisa);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_iconContainerPeakPay,_peakPayButton,100);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_iconContainerGoogleWallet,_googleWalletButton,100);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_iconPeakGames,_peakPayButton,180);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_iconGoogleWallet,_googleWalletButton,180);
      }
      
      public function get peakPayButton() : MPButton
      {
         return _peakPayButton;
      }
      
      public function get googleWalletButton() : MPButton
      {
         return _googleWalletButton;
      }
      
      public function get productId() : String
      {
         return _productId;
      }
      
      public function get peakPayId() : String
      {
         return _peakPayId;
      }
   }
}


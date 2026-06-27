package wom.view.screen.windows.catapult
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileCatapultRechargeWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 478;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _secondBackground:DisplayObject;
      
      private var lumberCatapultRechargeView:MobileCatapultElementRechargeView;
      
      private var stoneCatapultRechargeView:MobileCatapultElementRechargeView;
      
      private var mightCatapultRechargeView:MobileCatapultElementRechargeView;
      
      private var _catapultLevel:int;
      
      public function MobileCatapultRechargeWindow(param1:int, param2:Vector.<WindowEnumeration> = null)
      {
         super(478,306,param2);
         _catapultLevel = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.catapult.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _secondBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         _secondBackground.height = 240;
         _secondBackground.width = 415;
         addChild(_secondBackground);
         lumberCatapultRechargeView = new MobileCatapultElementRechargeView(1,_catapultLevel >= 1);
         stoneCatapultRechargeView = new MobileCatapultElementRechargeView(2,_catapultLevel >= 2);
         mightCatapultRechargeView = new MobileCatapultElementRechargeView(3,_catapultLevel >= 3);
         addChild(lumberCatapultRechargeView);
         addChild(stoneCatapultRechargeView);
         addChild(mightCatapultRechargeView);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_secondBackground,_background);
         MobileAlignmentUtil.alignAccordingToPositionOf(lumberCatapultRechargeView,_secondBackground,52,28);
         MobileAlignmentUtil.alignAccordingToPositionOf(stoneCatapultRechargeView,lumberCatapultRechargeView,122,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(mightCatapultRechargeView,stoneCatapultRechargeView,122,0);
      }
      
      public function updateWithCatapultLevel(param1:int) : void
      {
         if(param1 != _catapultLevel)
         {
            _catapultLevel = param1;
            lumberCatapultRechargeView.updateAvailability(_catapultLevel >= 1);
            stoneCatapultRechargeView.updateAvailability(_catapultLevel >= 1);
            mightCatapultRechargeView.updateAvailability(_catapultLevel >= 1);
         }
      }
   }
}


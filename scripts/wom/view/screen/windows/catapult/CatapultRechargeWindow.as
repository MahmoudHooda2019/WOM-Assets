package wom.view.screen.windows.catapult
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.GenericWindow;
   
   public class CatapultRechargeWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 452;
      
      private static const WINDOW_HEIGHT:int = 276;
      
      public static const CATAPULT_SILUETTE_ID:String = "B23Silhouette";
      
      private var _catapultSilhouette:DisplayObject;
      
      private var lumberCatapultRechargeView:CatapultRechargeView;
      
      private var stoneCatapultRechargeView:CatapultRechargeView;
      
      private var mightCatapultRechargeView:CatapultRechargeView;
      
      private var _catapultLevel:int;
      
      public function CatapultRechargeWindow(param1:int, param2:Vector.<WindowEnumeration> = null)
      {
         super(452,276,param2);
         _catapultLevel = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.catapult.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _catapultSilhouette = assetRepository.getDisplayObject("B23Silhouette");
         addChild(_catapultSilhouette);
         lumberCatapultRechargeView = new CatapultRechargeView(1,_catapultLevel >= 1);
         stoneCatapultRechargeView = new CatapultRechargeView(2,_catapultLevel >= 2);
         mightCatapultRechargeView = new CatapultRechargeView(3,_catapultLevel >= 3);
         addChild(lumberCatapultRechargeView);
         addChild(stoneCatapultRechargeView);
         addChild(mightCatapultRechargeView);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
      }
      
      public function drawLayout() : void
      {
         _catapultSilhouette.x = 126 - _catapultSilhouette.width;
         _catapultSilhouette.y = 50;
         lumberCatapultRechargeView.x = 145;
         lumberCatapultRechargeView.y = 56;
         AlignmentUtil.alignBelowOf(stoneCatapultRechargeView,lumberCatapultRechargeView,10);
         AlignmentUtil.alignBelowOf(mightCatapultRechargeView,stoneCatapultRechargeView,10);
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
      
      public function get catapultSilhouette() : DisplayObject
      {
         return _catapultSilhouette;
      }
   }
}


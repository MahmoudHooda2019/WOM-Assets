package wom.view.screen.windows.gold
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.gold.GoldProductDTO;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.MobileFullScreenWindow;
   
   public class MobileGetGoldWindow extends MobileFullScreenWindow
   {
      
      private static const TOP_SELLER_INDEX:int = 4;
      
      private var darkBackground:DisplayObject;
      
      private var goldProductViews:Vector.<MobileGetGoldProductView>;
      
      private var _goldProducts:Vector.<GoldProductDTO>;
      
      private var _monetizationType:MonetizationType;
      
      private var _topSellerGoldProductId:String;
      
      private var _showMobilePaymentButton:Boolean;
      
      public function MobileGetGoldWindow(param1:Vector.<GoldProductDTO>, param2:MonetizationType, param3:Boolean, param4:String, param5:Vector.<WindowEnumeration>, param6:Object)
      {
         super(true,param5);
         _goldProducts = param1;
         _monetizationType = param2;
         _showMobilePaymentButton = param3;
         _topSellerGoldProductId = param4;
      }
      
      override protected function initLayout() : void
      {
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:MobileGetGoldProductView = null;
         super.initLayout();
         var _loc8_:String = "ui.windows.gold.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc8_));
         goldProductViews = new Vector.<MobileGetGoldProductView>();
         var _loc3_:int = 0;
         for each(var _loc1_ in _goldProducts)
         {
            _loc5_ = _loc3_ == 0 ? 0 : 100 - (_loc1_.localPrice * 100 / (_loc1_.amountOfGold * _goldProducts[0].localPrice / _goldProducts[0].amountOfGold) >> 0);
            if(_topSellerGoldProductId != null)
            {
               _loc2_ = _loc1_.id != null && _loc1_.id == _topSellerGoldProductId;
            }
            else
            {
               _loc2_ = _loc3_ == 4;
            }
            _loc4_ = new MobileGetGoldProductView(_loc1_,MonetizationType.ADD_GOLD,_loc2_,_loc5_,_loc3_);
            goldProductViews.push(_loc4_);
            addChild(goldProductViews[_loc3_]);
            _loc3_++;
         }
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         darkBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         darkBackground.width = 1000;
         darkBackground.height = 669;
         addChild(darkBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(darkBackground,_background,_windowWidth - darkBackground.width >> 1,88);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < goldProductViews.length)
         {
            _loc3_ = 24 + 325 * (_loc1_ > 2 ? _loc1_ - 3 : _loc1_);
            _loc2_ = 25 + 315 * (_loc1_ > 2 ? 1 : 0);
            MobileAlignmentUtil.alignAccordingToPositionOf(goldProductViews[_loc1_],darkBackground,_loc3_,_loc2_);
            _loc1_++;
         }
      }
   }
}


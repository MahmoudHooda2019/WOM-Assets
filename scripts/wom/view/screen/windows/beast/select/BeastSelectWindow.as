package wom.view.screen.windows.beast.select
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.view.util.GenericWindow;
   
   public class BeastSelectWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 732;
      
      private static const WINDOW_HEIGHT:int = 490;
      
      private var beastKeeperSelectItemViewBackgrounds:Vector.<DisplayObject>;
      
      private var beastKeeperSelectItemViews:Vector.<BeastSelectItemView>;
      
      private var _initialBeastTypeId:int;
      
      public function BeastSelectWindow(param1:int = -1, param2:int = 732, param3:int = 490)
      {
         super(param2,param3);
         _initialBeastTypeId = param1;
         beastKeeperSelectItemViewBackgrounds = new Vector.<DisplayObject>();
         beastKeeperSelectItemViews = new Vector.<BeastSelectItemView>();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.beast.select.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < beastKeeperSelectItemViews.length)
         {
            beastKeeperSelectItemViewBackgrounds[_loc1_].x = beastKeeperSelectItemViews[_loc1_].x = _loc1_ * 173 + 27;
            beastKeeperSelectItemViewBackgrounds[_loc1_].y = beastKeeperSelectItemViews[_loc1_].y = 40;
            _loc1_++;
         }
      }
      
      private function clear() : void
      {
         for each(var _loc2_ in beastKeeperSelectItemViewBackgrounds)
         {
            if(contains(_loc2_))
            {
               removeChild(_loc2_);
            }
         }
         beastKeeperSelectItemViewBackgrounds.length = 0;
         for each(var _loc1_ in beastKeeperSelectItemViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         beastKeeperSelectItemViews.length = 0;
      }
      
      public function update(param1:Vector.<BeastTypeDIO>, param2:BeastInfo, param3:Dictionary) : void
      {
         var _loc6_:* = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:BeastSelectItemView = null;
         clear();
         for each(_loc6_ in param1)
         {
            _loc4_ = assetRepository.getDisplayObject("BackgroundLight");
            _loc4_.width = 159;
            _loc4_.height = 419;
            beastKeeperSelectItemViewBackgrounds.push(_loc4_);
            addChild(_loc4_);
         }
         for each(_loc6_ in param1)
         {
            _loc5_ = new BeastSelectItemView(_loc6_,param2 != null && param2.typeId == _loc6_.id || _loc6_.id in param3 ? true : false);
            beastKeeperSelectItemViews.push(_loc5_);
            addChild(_loc5_);
         }
         drawLayout();
      }
      
      public function get initialBeastTypeId() : int
      {
         return _initialBeastTypeId;
      }
   }
}


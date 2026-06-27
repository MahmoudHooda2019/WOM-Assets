package wom.view.screen.windows.beast.keeper
{
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.beast.BeastStatusType;
   import wom.view.util.BaseWindowPanel;
   
   public class BeastKeeperPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 669;
      
      private static const HEIGHT:int = 447;
      
      private var _itemViews:Vector.<BeastKeeperItemView>;
      
      private var _selectedItemViews:Vector.<BeastKeeperSelectedItemView>;
      
      public function BeastKeeperPanel()
      {
         super(669,447);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _itemViews = new Vector.<BeastKeeperItemView>();
         _selectedItemViews = new Vector.<BeastKeeperSelectedItemView>();
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_itemViews[_loc1_],bg,_loc1_ * 171,0);
            AlignmentUtil.alignAccordingToPositionOf(_selectedItemViews[_loc1_],bg,0,284);
            _loc1_++;
         }
         super.drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      private function clear() : void
      {
         for each(var _loc1_ in _itemViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _itemViews.length = 0;
         for each(var _loc2_ in _selectedItemViews)
         {
            if(contains(_loc2_))
            {
               removeChild(_loc2_);
            }
         }
         _selectedItemViews.length = 0;
      }
      
      public function updateBeasts(param1:BeastInfo, param2:Dictionary, param3:Vector.<BeastTypeDIO>) : void
      {
         var _loc4_:BeastKeeperItemView = null;
         var _loc7_:BeastKeeperSelectedItemView = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:BeastStatusType = null;
         clear();
         for each(var _loc8_ in param3)
         {
            if(String(_loc8_.id) in param2)
            {
               _loc5_ = int(param2[_loc8_.id]["level"]);
               _loc9_ = int(param2[_loc8_.id]["bonusStage"]);
               _loc6_ = BeastStatusType.IN_KEEPER;
            }
            else if(param1 != null && param1.typeId == _loc8_.id)
            {
               _loc5_ = param1.level;
               _loc9_ = param1.bonusStage;
               _loc6_ = BeastStatusType.IN_CAVE;
            }
            else
            {
               _loc5_ = 1;
               _loc9_ = 0;
               _loc6_ = BeastStatusType.NON_RAISED;
            }
            _loc4_ = new BeastKeeperItemView(_loc8_,_loc5_,_loc6_);
            _itemViews.push(_loc4_);
            addChild(_loc4_);
            _loc4_.addEventListener("mouseOver",onItemViewMouseOver,false,0,true);
            _loc7_ = new BeastKeeperSelectedItemView(_loc8_,_loc5_,_loc9_);
            _selectedItemViews.push(_loc7_);
            addChild(_loc7_);
            _loc7_.visible = false;
         }
         if(_selectedItemViews.length > 0)
         {
            _selectedItemViews[0].visible = true;
         }
         drawLayout();
      }
      
      private function onItemViewMouseOver(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BeastKeeperItemView = param1.currentTarget as BeastKeeperItemView;
         if(_loc2_)
         {
            _loc4_ = _itemViews.indexOf(_loc2_);
            for each(var _loc3_ in _selectedItemViews)
            {
               _loc3_.visible = false;
            }
            _selectedItemViews[_loc4_].visible = true;
         }
      }
   }
}


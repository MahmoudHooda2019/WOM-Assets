package wom.view.screen.windows.blacksmith
{
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.util.BaseWindowPanel;
   
   public class BlacksmithSelectEventItemPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 616;
      
      private static const HEIGHT:int = 202;
      
      private var _eventItemViews:Vector.<BlacksmithEventItemView>;
      
      private var eventItemListBackground:AssetDisplayObject;
      
      private var eventItemInfoPanel:EventItemInfoPanel;
      
      public function BlacksmithSelectEventItemPanel()
      {
         super(616,202);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         eventItemListBackground = assetRepository.getDisplayObject("BackgroundLight");
         eventItemListBackground.width = 313;
         eventItemListBackground.height = 202;
         addChild(eventItemListBackground);
         eventItemInfoPanel = new EventItemInfoPanel();
         eventItemInfoPanel.x = 329;
         eventItemInfoPanel.y = 0;
         addChild(eventItemInfoPanel);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignRightOf(eventItemInfoPanel,eventItemListBackground,16);
      }
      
      public function createEventAndFillItemViews(param1:Vector.<EventItemDIO>, param2:UnitTypeInfo) : void
      {
         var _loc5_:int = 0;
         var _loc4_:BlacksmithEventItemView = null;
         if(_eventItemViews)
         {
            return;
         }
         var _loc3_:int = 0;
         _eventItemViews = new Vector.<BlacksmithEventItemView>();
         _loc5_ = 0;
         while(_loc5_ < 15)
         {
            _loc4_ = new BlacksmithEventItemView(_loc5_ < param1.length ? param1[_loc5_] : null,_loc3_);
            _eventItemViews.push(_loc4_);
            if(_loc3_ == 0)
            {
               AlignmentUtil.alignAccordingToPositionOf(_loc4_,eventItemListBackground,11,20);
            }
            else if(_loc3_ % 5 == 0)
            {
               _loc4_.x = _eventItemViews[_loc3_ - 5].x;
               _loc4_.y = _eventItemViews[_loc3_ - 5].y + 55;
            }
            else
            {
               _loc4_.x = _eventItemViews[_loc3_ - 1].x + 59;
               _loc4_.y = _eventItemViews[_loc3_ - 1].y;
            }
            addChild(_loc4_);
            _loc3_++;
            _loc5_++;
         }
         if(_eventItemViews.length > 0)
         {
            loadEventItemData(param1[0],param2);
         }
      }
      
      public function updateEventItems(param1:Vector.<EventItemDIO>, param2:UnitTypeInfo) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _eventItemViews[_loc3_].updateEventItemView(param1[_loc3_]);
            _loc3_++;
         }
         if(param1.length > 0)
         {
            eventItemInfoPanel.updateInfoPanel(param1[0],param2);
         }
      }
      
      public function loadEventItemData(param1:EventItemDIO, param2:UnitTypeInfo) : void
      {
         if(param1 != null)
         {
            eventItemInfoPanel.updateInfoPanel(param1,param2);
         }
      }
      
      public function get eventItemViews() : Vector.<BlacksmithEventItemView>
      {
         return _eventItemViews;
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
   }
}


package wom.view.ui.mainframe.combat.eventitems
{
   import flash.utils.Dictionary;
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.event.EventItemType;
   import wom.view.ui.mainframe.combat.*;
   
   public class MobileCombatMenuEventItemsPanel extends MobileBaseBottomMainframePanel implements View
   {
      
      public static const USABLE_ITEM_COUNT:int = 3;
      
      private var _usedItemCount:int;
      
      private var _maxNumberOfEventItemDeployReached:Boolean = false;
      
      public function MobileCombatMenuEventItemsPanel()
      {
         super();
      }
      
      public function updateWithEventItems(param1:Vector.<EventItemDIO>, param2:Dictionary) : void
      {
         var _loc6_:int = 0;
         var _loc4_:EventItemDIO = null;
         var _loc3_:int = 0;
         var _loc5_:MobileCombatEventItemView = null;
         _usedItemCount = 0;
         clearViews();
         if(param1)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc4_ = param1[_loc6_];
               _loc3_ = int(param2[_loc4_.id]);
               if(_loc3_ > 0 && (_loc4_.itemType == EventItemType.BEAST.id || _loc4_.itemType == EventItemType.BUILDING.id || _loc4_.itemType == EventItemType.CATAPULT.id || _loc4_.itemType == EventItemType.MERCENARY.id))
               {
                  _loc5_ = createEventItemView(_loc4_,_loc3_);
                  _views.push(_loc5_);
               }
               _loc6_++;
            }
         }
         drawLayout();
      }
      
      private function createEventItemView(param1:EventItemDIO, param2:int) : MobileCombatEventItemView
      {
         var _loc3_:MobileCombatEventItemView = null;
         if(param1.itemType == EventItemType.BEAST.id)
         {
            _loc3_ = new MobileCombatEventItemView(param1,param2);
         }
         else if(param1.itemType == EventItemType.MERCENARY.id && param1.warBuilding)
         {
            _loc3_ = new MobileCombatBuildingEventItemView(param1,param2,param1.relatedId);
         }
         else if(param1.itemType == EventItemType.MERCENARY.id)
         {
            _loc3_ = new MobileMercenaryEventItemView(param1,param2,param1.relatedId);
         }
         else if(param1.itemType == EventItemType.CATAPULT.id)
         {
            _loc3_ = new MobileCatapultEventItemView(param1,param2);
         }
         else
         {
            _loc3_ = new MobileCombatEventItemView(param1,param2);
         }
         _scrollPane.addChild(_loc3_);
         return _loc3_;
      }
      
      public function itemUsed(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MobileCombatEventItemView = null;
         _usedItemCount = _usedItemCount + 1;
         if(_usedItemCount >= 3)
         {
            _maxNumberOfEventItemDeployReached = true;
            _loc3_ = 0;
            while(_loc3_ < _views.length)
            {
               _loc2_ = _views[_loc3_] as MobileCombatEventItemView;
               _loc2_.updateItemEnabling(false);
               _loc3_++;
            }
         }
      }
      
      public function get usedItemCount() : int
      {
         return _usedItemCount;
      }
      
      public function get maxNumberOfEventItemDeployReached() : Boolean
      {
         return _maxNumberOfEventItemDeployReached;
      }
      
      public function get eventItemViews() : Vector.<Sprite>
      {
         return _views;
      }
   }
}


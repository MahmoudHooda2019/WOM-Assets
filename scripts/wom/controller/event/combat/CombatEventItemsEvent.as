package wom.controller.event.combat
{
   import flash.events.Event;
   
   public class CombatEventItemsEvent extends Event
   {
      
      public static const ITEM_DEPLOYED:String = "itemDeployed";
      
      public static const ITEMS_TAB_OPENED:String = "itemsTabOpened";
      
      public static const ARMY_TAB_OPENED:String = "armyTabOpened";
      
      public static const COMBAT_BUILDING_SELECTED:String = "combatBuildingSelected";
      
      public static const CATAPULT_SELECTED:String = "catapultSelected";
      
      public static const MERCENARY_SELECTED:String = "mercenarySelected";
      
      public static const ITEM_DEPLOY_IS_CANCELLED:String = "itemDeployIsCancelled";
      
      private var _relatedId:int;
      
      public function CombatEventItemsEvent(param1:String, param2:int)
      {
         super(param1);
         _relatedId = param2;
      }
      
      override public function clone() : Event
      {
         return new CombatEventItemsEvent(type,_relatedId);
      }
      
      public function get relatedId() : int
      {
         return _relatedId;
      }
   }
}


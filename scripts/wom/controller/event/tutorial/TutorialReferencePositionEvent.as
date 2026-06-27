package wom.controller.event.tutorial
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class TutorialReferencePositionEvent extends Event
   {
      
      public static const OBJECT_TO_BE_ALIGNED_WINDOW:int = 1;
      
      public static const OBJECT_TO_BE_ALIGNED_ARROW:int = 2;
      
      public static const GET_NEWEST_POP_UP_POSITION:String = "getNewestPopUpPosition";
      
      public static const GET_NEWEST_SECONDARY_POP_UP_POSITION:String = "getNewestSecondaryPopUpPosition";
      
      public static const GET_RESOURCE_PANEL_POSITION:String = "getResourcePanelPosition";
      
      public static const GET_MENU_PANEL_POSITION:String = "getMenuPanelPosition";
      
      public static const GET_BUILD_SHOWCASE_VIEW_POSITION:String = "getBuildShowcaseViewPosition";
      
      public static const GET_CENTER_OF_CITY_POSITION:String = "getCenterOfCityPosition";
      
      public static const GET_BUILDING_POSITION:String = "getBuildingPosition";
      
      public static const GET_BUILDING_PROGRESSBAR_POSITION:String = "getBuildingProgressBarPosition";
      
      public static const GET_MAP_TOWN_POSITION:String = "getMapTownPosition";
      
      public static const GET_MAP_TOWN_OPTIONS_MENU_POSITION:String = "getMapTownOptionsMenuPosition";
      
      public static const GET_COMBAT_MERC_DEPLOY_TAB_MERC_VIEW_POSITION:String = "getCombatMercDeployTabMercViewPosition";
      
      public static const GET_COMBAT_MENU_PANEL_POSITION:String = "getCombatMenuPanelPosition";
      
      public static const GET_INVENTORY_ITEM_VIEW_POSITION:String = "getInventoryItemViewPosition";
      
      public static const GET_QUEST_PREVIEW_VIEW_POSITION:String = "getQuestPreviewViewPosition";
      
      public static const GET_HIRING_MERC_VIEW_POSITION:String = "getHiringMercViewPosition";
      
      public static const GET_WORKER_PANEL_POSITION:String = "getWorkerPanelPosition";
      
      public static const GET_PROTECTION_PANEL_POSITION:String = "getProtectionPanelPosition";
      
      public static const GET_TOP_RIGHT_POSITION:String = "getTopRightPosition";
      
      public static const GET_BOTTOM_LEFT_POSITION:String = "getBottomLeftPosition";
      
      public static const GET_BOTTOM_RIGHT_POSITION:String = "getBottomRightPosition";
      
      public static const GET_TUTURIAL_DONE_BUTTON_POSITION:String = "getTutorialDoneButtonPosition";
      
      public static const GET_RECON_POINTS_BAR_POSITION:String = "getReconPointsBarPosition";
      
      public static const GET_CENTER_OF_SCREEN_POSITION:String = "getCenterOfScreenPosition";
      
      public static const GET_MENU_PANEL_BUILD_BUTTON_POSITION:String = "getMenuPanelBuildButtonPosition";
      
      public static const GET_MENU_PANEL_UPGRADE_BUTTON_POSITION:String = "getMenuPanelUpgradeButtonPosition";
      
      public static const GET_MENU_PANEL_WAR_BUTTON_POSITION:String = "getMenuPanelWarButtonPosition";
      
      public static const GET_BATTLE_PROGRESS_BAR_POSITION:String = "getBattleProgressBarPosition";
      
      public static const GET_MAP_CAMPAIGN_BUTTON_POSITION:String = "getMapCampaignButtonPosition";
      
      public static const GET_MANDATORY_ACTION_BUTTON_POSITION:String = "getMandatoryActionButtonPosition";
      
      public static const GET_BUY_EXTRA_WORKER_POSITION:String = "getBuyExtraWorkerPosition";
      
      public static const GET_SECONDARY_ACTION_BUTTON_POSITION:String = "getSecondaryActionButtonPosition";
      
      public static const POSITION_READY:String = "positionReady";
      
      public static const GET_POSITION:String = "getPosition";
      
      private var _objectToBeAligned:int;
      
      private var _position:Point;
      
      private var _additionalInfo:Dictionary;
      
      private var _displayObject:Object;
      
      public function TutorialReferencePositionEvent(param1:String, param2:int, param3:Point = null, param4:Dictionary = null, param5:Object = null)
      {
         super(param1);
         _objectToBeAligned = param2;
         _position = param3;
         _additionalInfo = param4 != null ? param4 : new Dictionary();
         _displayObject = param5;
      }
      
      override public function clone() : Event
      {
         return new TutorialReferencePositionEvent(type,_objectToBeAligned,_position,_additionalInfo,_displayObject);
      }
      
      public function get objectToBeAligned() : int
      {
         return _objectToBeAligned;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get additionalInfo() : Dictionary
      {
         return _additionalInfo;
      }
      
      public function get displayObject() : Object
      {
         return _displayObject;
      }
   }
}


package wom.controller.event
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import wom.model.game.WomScreenType;
   
   public class ActivateScreenEvent extends Event
   {
      
      public static const ACTIVATE:String = "activate";
      
      public static const ACTIVATE_PREVIOUS_SCREEN:String = "activatePreviousScreen";
      
      public static const ADDITIONAL_INFO_OPEN_MAP_LIST_WINDOW:String = "openMapListWindow";
      
      public static const MAP_SCREEN_CAMPAIGN_MODE:String = "mapScreenCampaignMode";
      
      public static const INITIATE_VISIT:String = "initiateVisit";
      
      private var _screen:WomScreenType;
      
      private var _additionalInfo:Dictionary;
      
      private var _onCompleteFunction:Function;
      
      public function ActivateScreenEvent(param1:String, param2:WomScreenType = null, param3:Dictionary = null, param4:Function = null)
      {
         super(param1);
         _screen = param2;
         _additionalInfo = param3 != null ? param3 : new Dictionary();
         _onCompleteFunction = param4;
      }
      
      override public function clone() : Event
      {
         return new ActivateScreenEvent(type,_screen,_additionalInfo,_onCompleteFunction);
      }
      
      public function get screen() : WomScreenType
      {
         return _screen;
      }
      
      public function set screen(param1:WomScreenType) : void
      {
         _screen = param1;
      }
      
      public function get additionalInfo() : Dictionary
      {
         return _additionalInfo;
      }
      
      public function get onCompleteFunction() : Function
      {
         return _onCompleteFunction;
      }
   }
}


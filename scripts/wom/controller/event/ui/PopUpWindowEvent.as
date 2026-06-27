package wom.controller.event.ui
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import wom.model.game.PopUpWindowInfo;
   
   public class PopUpWindowEvent extends Event
   {
      
      public static const SHOW_POP_UP_WINDOW:String = "showPopUpWindow";
      
      public static const SHOW_SECONDARY_POP_UP_WINDOW:String = "showSecondaryPopUpWindow";
      
      public static const CLOSE_POP_UP_WINDOW:String = "closePopUpWindow";
      
      public static const CLOSE_TOP_POP_UP_WINDOW:String = "closeTopPopUpWindow";
      
      public static const CLOSE_SECONDARY_POP_UP_WINDOW:String = "closeSecondaryPopUpWindow";
      
      public static const NOTIFY_CLOSING_WINDOW:String = "notifyClosingWindow";
      
      public static const NOTIFY_CLOSING_SECONDARY_WINDOW:String = "notifyClosingSecondaryWindow";
      
      public static const NOTIFY_CLOSING_CHECK_CLOSEABLE_WINDOW:String = "notifyClosingCheckCloseableWindow";
      
      public static const DELAY_POP_UPS:String = "delayPopUps";
      
      public static const SHOW_DELAYED_POP_UPS:String = "showDelayedPopUps";
      
      public static const ALL_POP_UPS_CLOSED:String = "allPopUpsClosed";
      
      public static const VECTOR_POSITION_HEAD:int = 0;
      
      public static const VECTOR_POSITION_LEAF:int = -1;
      
      private var _popUpWindowInfo:PopUpWindowInfo;
      
      private var _delayPopupsBefore:Object;
      
      private var _delayPopupsAfter:Object;
      
      public function PopUpWindowEvent(param1:String, param2:DisplayObject, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null, param7:Object = null)
      {
         super(param1);
         _popUpWindowInfo = new PopUpWindowInfo(param2,param3 != null ? int(param3) : -1,param4 != null ? param4 : true,param5 != null ? param5 : false);
         _delayPopupsBefore = param6;
         _delayPopupsAfter = param7;
      }
      
      override public function clone() : Event
      {
         return new PopUpWindowEvent(type,_popUpWindowInfo.window,_popUpWindowInfo.vectorPosition,_popUpWindowInfo.showModal,_popUpWindowInfo.customPosition,_delayPopupsBefore,_delayPopupsAfter);
      }
      
      public function get popUpWindowInfo() : PopUpWindowInfo
      {
         return _popUpWindowInfo;
      }
      
      public function get delayPopupsBefore() : Object
      {
         return _delayPopupsBefore;
      }
      
      public function get delayPopupsAfter() : Object
      {
         return _delayPopupsAfter;
      }
   }
}


package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.component.attribute.data.MapTileData;
   
   public class TownOptionsMenuEvent extends Event
   {
      
      public static const SHOW:String = "showTownOptionsMenu";
      
      public static const TRIGGER_WITHOUT_SHOWING:String = "triggerWithoutShowing";
      
      public static const CLOSE:String = "closeTownOptionsMenu";
      
      public var mapTileData:MapTileData;
      
      public function TownOptionsMenuEvent(param1:String, param2:MapTileData = null)
      {
         super(param1);
         this.mapTileData = param2;
      }
   }
}


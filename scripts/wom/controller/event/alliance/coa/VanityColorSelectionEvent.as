package wom.controller.event.alliance.coa
{
   import flash.events.Event;
   import wom.model.game.alliance.coa.VanityColorType;
   
   public class VanityColorSelectionEvent extends Event
   {
      
      public static const COLOR_SELECTED:String = "colorSelected";
      
      public static const SELECTOR_PALETTE_SHOWN:String = "selectorPaletteOpened";
      
      public static const CLOSE_PALETTE:String = "closePalette";
      
      private var _selectedColor:VanityColorType;
      
      private var _selectorId:int;
      
      public function VanityColorSelectionEvent(param1:String, param2:VanityColorType, param3:int)
      {
         super(param1);
         _selectedColor = param2;
         _selectorId = param3;
      }
      
      override public function clone() : Event
      {
         return new VanityColorSelectionEvent(type,_selectedColor,_selectorId);
      }
      
      public function get selectedColor() : VanityColorType
      {
         return _selectedColor;
      }
      
      public function get selectorId() : int
      {
         return _selectorId;
      }
   }
}


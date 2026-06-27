package wom.controller.event.tutorial
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class TutorialVisibleItemsEvent extends Event
   {
      
      public static const UPDATE_VISIBLE_OF_TUTORIAL_ITEMS:String = "updateVisibleOfTutorialItems";
      
      public static const CATEGORY_CITY_UI_LAYER:String = "cityUiLayer";
      
      public static const CATEGORY_MENU_PANEL:String = "menuPanel";
      
      private var _categoryMap:Dictionary;
      
      public function TutorialVisibleItemsEvent(param1:String, param2:Dictionary)
      {
         super(param1);
         _categoryMap = param2;
      }
      
      override public function clone() : Event
      {
         return new TutorialVisibleItemsEvent(type,_categoryMap);
      }
      
      public function get categoryMap() : Dictionary
      {
         return _categoryMap;
      }
   }
}


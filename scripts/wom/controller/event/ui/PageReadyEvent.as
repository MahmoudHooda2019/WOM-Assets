package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class PageReadyEvent extends Event
   {
      
      public static const INVENTORY_PAGE_READY:String = "inventoryPageReady";
      
      public static const BUILD_PAGE_READY:String = "buildPageReady";
      
      public static const BUILD_DECORATION_PAGE_READY:String = "buildDecorationPageReady";
      
      private var _pageNumber:int;
      
      private var _totalItemCount:int;
      
      private var _items:Vector.<*>;
      
      public function PageReadyEvent(param1:String, param2:int, param3:int, param4:Vector.<*>)
      {
         super(param1);
         _pageNumber = param2;
         _totalItemCount = param3;
         _items = param4;
      }
      
      override public function clone() : Event
      {
         return new PageReadyEvent(type,_pageNumber,_totalItemCount,_items);
      }
      
      public function get pageNumber() : int
      {
         return _pageNumber;
      }
      
      public function get totalItemCount() : int
      {
         return _totalItemCount;
      }
      
      public function get items() : Vector.<*>
      {
         return _items;
      }
   }
}


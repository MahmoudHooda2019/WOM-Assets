package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class GetPageEvent extends Event
   {
      
      public static const GET_INVENTORY_PAGE:String = "getInventoryPage";
      
      public static const GET_BUILD_PAGE:String = "getBuildPage";
      
      public static const GET_BUILD_DECORATION_PAGE:String = "getBuildDecorationPage";
      
      private var _pageNumber:int;
      
      private var _itemCountPerPage:int;
      
      public function GetPageEvent(param1:String, param2:int, param3:uint)
      {
         super(param1);
         _pageNumber = param2;
         _itemCountPerPage = param3;
      }
      
      override public function clone() : Event
      {
         return new GetPageEvent(type,_pageNumber,_itemCountPerPage);
      }
      
      public function get pageNumber() : int
      {
         return _pageNumber;
      }
      
      public function get itemCountPerPage() : int
      {
         return _itemCountPerPage;
      }
   }
}


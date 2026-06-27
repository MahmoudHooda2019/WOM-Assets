package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.building.BuildMenuCategory;
   
   public class GetBuildPageEvent extends GetPageEvent
   {
      
      private var _category:BuildMenuCategory;
      
      public function GetBuildPageEvent(param1:String, param2:int, param3:int, param4:BuildMenuCategory)
      {
         super(param1,param2,param3);
         _category = param4;
      }
      
      override public function clone() : Event
      {
         return new GetBuildPageEvent(type,pageNumber,itemCountPerPage,_category);
      }
      
      public function get category() : BuildMenuCategory
      {
         return _category;
      }
   }
}


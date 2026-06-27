package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.building.BuildMenuDecorationCategory;
   
   public class GetBuildDecorationPageEvent extends GetPageEvent
   {
      
      private var _category:BuildMenuDecorationCategory;
      
      public function GetBuildDecorationPageEvent(param1:String, param2:int, param3:int, param4:BuildMenuDecorationCategory)
      {
         super(param1,param2,param3);
         _category = param4;
      }
      
      override public function clone() : Event
      {
         return new GetBuildDecorationPageEvent(type,pageNumber,itemCountPerPage,_category);
      }
      
      public function get category() : BuildMenuDecorationCategory
      {
         return _category;
      }
   }
}


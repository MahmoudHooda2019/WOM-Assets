package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.building.BuildMenuDecorationCategory;
   
   public class BuildDecorationPageReadyEvent extends PageReadyEvent
   {
      
      private var _buildMenuCategory:BuildMenuDecorationCategory;
      
      public function BuildDecorationPageReadyEvent(param1:String, param2:int, param3:int, param4:Vector.<*>, param5:BuildMenuDecorationCategory)
      {
         super(param1,param2,param3,param4);
         this._buildMenuCategory = param5;
      }
      
      override public function clone() : Event
      {
         return new BuildDecorationPageReadyEvent(type,pageNumber,totalItemCount,items,_buildMenuCategory);
      }
      
      public function get buildMenuCategory() : BuildMenuDecorationCategory
      {
         return _buildMenuCategory;
      }
   }
}


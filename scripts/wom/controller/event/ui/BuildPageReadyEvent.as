package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.building.BuildMenuCategory;
   
   public class BuildPageReadyEvent extends PageReadyEvent
   {
      
      private var _buildMenuCategory:BuildMenuCategory;
      
      public function BuildPageReadyEvent(param1:String, param2:int, param3:int, param4:Vector.<*>, param5:BuildMenuCategory)
      {
         super(param1,param2,param3,param4);
         this._buildMenuCategory = param5;
      }
      
      override public function clone() : Event
      {
         return new BuildPageReadyEvent(type,pageNumber,totalItemCount,items,_buildMenuCategory);
      }
      
      public function get buildMenuCategory() : BuildMenuCategory
      {
         return _buildMenuCategory;
      }
   }
}


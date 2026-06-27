package wom.view.screen.popups.topoff
{
   import wom.model.game.window.WindowEnumeration;
   
   public class MobileConstructTopOffResourcesPopUp extends MobileBaseTopOffResourcesPopUp
   {
      
      private var _buildingTypeId:int;
      
      public function MobileConstructTopOffResourcesPopUp(param1:String, param2:int, param3:Array = null, param4:Vector.<WindowEnumeration> = null)
      {
         super(param1,param3,param4);
         _buildingTypeId = param2;
      }
      
      public function get buildingTypeId() : int
      {
         return _buildingTypeId;
      }
   }
}


package wom.view.component
{
   import com.yahoo.astra.fl.controls.tabBarClasses.TabButton;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   
   public class WomBeastCaveTabBar extends WomTabBar
   {
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _beastKeeperStatus:int;
      
      public function WomBeastCaveTabBar(param1:BuildingTypeDIO, param2:int = 144)
      {
         super(param2);
         _buildingTypeDIO = param1;
         _beastKeeperStatus = 1;
      }
      
      override protected function newInstanceOfWomTabButton() : WomTabButton
      {
         return new WomBeastCaveTabButton(_buildingTypeDIO,getWomTabButtonWidth());
      }
      
      public function set beastKeeperExist(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:WomBeastCaveTabButton = null;
         _beastKeeperStatus = param1;
         _loc3_ = 0;
         while(_loc3_ < this.buttons.length)
         {
            _loc2_ = this.buttons[_loc3_] as WomBeastCaveTabButton;
            _loc2_.beastKeeperStatus = param1;
            _loc3_++;
         }
      }
      
      override protected function getButton() : TabButton
      {
         var _loc1_:TabButton = super.getButton();
         if(_loc1_ is WomBeastCaveTabButton)
         {
            (_loc1_ as WomBeastCaveTabButton).beastKeeperStatus = _beastKeeperStatus;
         }
         _loc1_.addEventListener("showSecondaryPopUpWindow",onShowSecondaryPopUpWindow);
         return _loc1_;
      }
      
      private function onShowSecondaryPopUpWindow(param1:PopUpWindowEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}


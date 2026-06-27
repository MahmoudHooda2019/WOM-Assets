package wom.view.component
{
   import fl.controls.Button;
   import flash.events.MouseEvent;
   import peak.i18n.PText;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.game.window.WindowEnumerationButton;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.screen.popups.ClementineChangableActionPopUp;
   
   public class WomBeastCaveTabButton extends WomTabButton
   {
      
      public static const BEAST_KEEPER_STATUS_EXIST:int = 0;
      
      public static const BEAST_KEEPER_STATUS_NON_EXIST:int = 1;
      
      public static const BEAST_KEEPER_STATUS_UNHEALTHY:int = 2;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _beastKeeperStatus:int;
      
      public function WomBeastCaveTabButton(param1:BuildingTypeDIO, param2:int = 141)
      {
         super(param2);
         _buildingTypeDIO = param1;
         _beastKeeperStatus = 1;
      }
      
      override protected function toggleSelected(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc4_:WomButton = null;
         var _loc5_:ClementineChangableActionPopUp = null;
         if(param1.target is Button && _temp_2 == peak.i18n.PText.INSTANCE.getText0(_loc8_))
         {
            if(_beastKeeperStatus == 0)
            {
               super.toggleSelected(param1);
            }
            else
            {
               _loc2_ = new Vector.<WindowEnumerationButton>();
               if(_beastKeeperStatus == 1)
               {
                  var _loc9_:String = "ui.windows.beast.cave.keeper.buildfirst.header";
                  _loc7_ = peak.i18n.PText.INSTANCE.getText0(_loc9_);
                  var _loc10_:String = "ui.windows.beast.cave.keeper.buildfirst.desc";
                  _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc10_);
                  _loc6_ = 1;
                  _loc4_ = new WomGreenLargeButton();
                  var _temp_4:* = _loc4_;
                  var _loc11_:String = "ui.windows.build.buildnow";
                  _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
                  _loc4_.rightLabel = String(StoreUtil.buildingPriceWithRequirementsVector(_buildingTypeDIO.resourceCosts[0],_buildingTypeDIO.upgradeDurationsPerLevel[0]));
                  _loc4_.width = 300;
                  _loc2_.push(new WindowEnumerationButton(new WindowEnumeration(41,{}),_loc4_,"Gold"));
               }
               else if(_beastKeeperStatus == 2)
               {
                  var _loc12_:String = "ui.error.oops";
                  _loc7_ = peak.i18n.PText.INSTANCE.getText0(_loc12_);
                  var _loc13_:String = "ui.windows.beast.cave.keeper.nothealthy";
                  _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc13_);
                  _loc6_ = 2;
                  _loc4_ = new WomBlueLargeButton();
                  _loc4_.width = 115;
                  var _temp_6:* = _loc4_;
                  var _loc14_:String = "ui.common.gotit";
                  _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc14_);
                  _loc2_.push(new WindowEnumerationButton(new WindowEnumeration(35,{}),_loc4_));
               }
               _loc5_ = new ClementineChangableActionPopUp(_loc6_,_loc7_,_loc3_,_loc2_);
               dispatchEvent(new PopUpWindowEvent("showSecondaryPopUpWindow",_loc5_));
            }
         }
         else
         {
            super.toggleSelected(param1);
         }
      }
      
      public function get beastKeeperStatus() : int
      {
         return _beastKeeperStatus;
      }
      
      public function set beastKeeperStatus(param1:int) : void
      {
         _beastKeeperStatus = param1;
      }
   }
}


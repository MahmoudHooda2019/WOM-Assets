package wom.view.screen.popups.building
{
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   
   public class BuildingCompletedPopUp extends GenericBuildingPopUp
   {
      
      public function BuildingCompletedPopUp(param1:BuildingTypeDIO, param2:int = 1)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "ui.popups.building.completed.header";
         var _loc1_:String = "domain.building." + buildingTypeDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         var _temp_4:* = messageField;
         var _temp_3:* = "domain.buildingkinds." + buildingTypeDIO.kind.id + ".buildingcompleted";
         var _loc4_:String = "domain.building." + buildingTypeDIO.id + ".name";
         var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc6_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
   }
}


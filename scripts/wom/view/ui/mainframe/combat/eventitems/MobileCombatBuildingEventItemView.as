package wom.view.ui.mainframe.combat.eventitems
{
   import wom.model.domain.domaininfoobject.EventItemDIO;
   
   public class MobileCombatBuildingEventItemView extends MobileCombatEventItemView
   {
      
      private var _relatedId:int;
      
      public function MobileCombatBuildingEventItemView(param1:EventItemDIO, param2:int, param3:int = -1)
      {
         super(param1,param2);
         _relatedId = param3;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         shieldIcon.visible = levelTextField.visible = true;
         levelTextField.text = "" + unitTypeInfo.currentLevel;
      }
      
      public function get relatedId() : int
      {
         return _relatedId;
      }
   }
}


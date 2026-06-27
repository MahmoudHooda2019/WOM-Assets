package wom.view.ui.mainframe.combat
{
   import peak.starling.InflatedBoundsSprite;
   import starling.display.DisplayObject;
   import wom.model.component.enum.ELOStarType;
   
   public class MobileBattlePointsSmallStarView extends InflatedBoundsSprite
   {
      
      private var _starView:DisplayObject;
      
      private var _starType:ELOStarType;
      
      public function MobileBattlePointsSmallStarView(param1:DisplayObject, param2:ELOStarType)
      {
         super();
         _starView = param1;
         _starType = param2;
         initLayout();
      }
      
      public function initLayout() : void
      {
         addChild(_starView);
      }
      
      public function get starType() : ELOStarType
      {
         return _starType;
      }
   }
}


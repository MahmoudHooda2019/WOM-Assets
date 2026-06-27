package wom.view.screen.windows.report.battlereport
{
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.component.enum.ELOStarType;
   
   public class MobileBattlePointsBigStarView extends Sprite
   {
      
      private var _starView:DisplayObject;
      
      private var _starType:ELOStarType;
      
      public function MobileBattlePointsBigStarView(param1:DisplayObject, param2:ELOStarType)
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


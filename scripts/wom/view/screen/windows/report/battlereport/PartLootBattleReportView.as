package wom.view.screen.windows.report.battlereport
{
   import flash.display.DisplayObject;
   
   public class PartLootBattleReportView extends BaseBattleReportView
   {
      
      private var _partId:int;
      
      private var _icon:DisplayObject;
      
      public function PartLootBattleReportView(param1:int, param2:String, param3:String, param4:int, param5:Boolean = false)
      {
         _partId = param1;
         super(param2,param3,param4,param5);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_icon)
         {
            _icon.x = _background.width - 44;
            _icon.y = 2;
         }
      }
      
      public function updateIcon(param1:String) : void
      {
         if(_icon)
         {
            removeChild(_icon);
         }
         _icon = assetRepository.getDisplayObject(param1);
         _icon.scaleX = _icon.scaleY = 0.5;
         addChild(_icon);
         drawLayout();
      }
      
      public function get partId() : int
      {
         return _partId;
      }
   }
}


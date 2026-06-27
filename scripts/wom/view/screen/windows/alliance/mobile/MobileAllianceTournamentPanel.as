package wom.view.screen.windows.alliance.mobile
{
   import peak.display.View;
   import starling.display.Sprite;
   
   public class MobileAllianceTournamentPanel extends Sprite implements View
   {
      
      private var _listPanel:MobileAllianceTournamentListPanel;
      
      private var _widthDifference:int;
      
      public function MobileAllianceTournamentPanel(param1:int)
      {
         super();
         _widthDifference = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _listPanel = new MobileAllianceTournamentListPanel(_widthDifference);
         addChild(_listPanel);
      }
      
      public function drawLayout() : void
      {
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
         _listPanel.updateTabActivation(param1);
      }
   }
}


package wom.view.screen.windows.beast.cave
{
   import peak.util.AlignmentUtil;
   import wom.view.screen.windows.beast.keeper.BeastKeeperPanel;
   import wom.view.util.BaseWindowPanel;
   
   public class BeastCaveBeastKeeperPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 693;
      
      private static const HEIGHT:int = 472;
      
      private var _beastKeeperPanel:BeastKeeperPanel;
      
      public function BeastCaveBeastKeeperPanel()
      {
         super(693,472);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _beastKeeperPanel = new BeastKeeperPanel();
         addChild(_beastKeeperPanel);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_beastKeeperPanel,bg,12,15);
         super.drawLayout();
      }
   }
}


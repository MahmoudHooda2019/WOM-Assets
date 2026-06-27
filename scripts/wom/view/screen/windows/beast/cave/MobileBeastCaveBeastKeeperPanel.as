package wom.view.screen.windows.beast.cave
{
   import peak.util.MobileAlignmentUtil;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperPanel;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBeastCaveBeastKeeperPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 774;
      
      private static const HEIGHT:int = 514;
      
      private var _beastKeeperPanel:MobileBeastKeeperPanel;
      
      public function MobileBeastCaveBeastKeeperPanel()
      {
         super(774,514);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _beastKeeperPanel = new MobileBeastKeeperPanel(868);
         _beastKeeperPanel.scaleX = _beastKeeperPanel.scaleY = 0.89;
         addChild(_beastKeeperPanel);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_beastKeeperPanel,bg);
         super.drawLayout();
      }
   }
}


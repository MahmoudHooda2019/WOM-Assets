package wom.view.screen.windows.league.mobile
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   
   public class MobileLeaguePanel extends Sprite implements View
   {
      
      private var _headerPanel:MobileLeagueHeaderPanel;
      
      private var _listPanel:MobileLeagueMembersListPanel;
      
      private var _generalInfoPanel:MobileLeagueGeneralInfoPanel;
      
      private var _helpButton:MPButton;
      
      public function MobileLeaguePanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _headerPanel = new MobileLeagueHeaderPanel();
         addChild(_headerPanel);
         _listPanel = new MobileLeagueMembersListPanel();
         addChild(_listPanel);
         _generalInfoPanel = new MobileLeagueGeneralInfoPanel();
         _generalInfoPanel.visible = false;
         addChild(_generalInfoPanel);
         _helpButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _helpButton.visible = false;
         addChild(_helpButton);
      }
      
      public function drawLayout() : void
      {
         _listPanel.y = 123;
         _generalInfoPanel.y = 123;
         _helpButton.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_helpButton,_headerPanel,_headerPanel.width - _helpButton.width - 8);
      }
      
      public function get helpButton() : MPButton
      {
         return _helpButton;
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         _generalInfoPanel.visible = param1;
         _listPanel.visible = !param1;
      }
      
      public function togglePanels(param1:Boolean) : void
      {
         _helpButton.visible = param1;
         toggleHint(!param1);
      }
      
      public function get hintVisible() : Boolean
      {
         return _generalInfoPanel.visible;
      }
   }
}


package wom.view.screen.windows.league
{
   import fl.controls.Button;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.util.BaseWindowPanel;
   
   public class LeaguePanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 445;
      
      private var _headerPanel:LeagueHeaderPanel;
      
      private var _listPanel:LeagueMembersListPanel;
      
      private var _generalInfoPanel:LeagueGeneralInfoPanel;
      
      private var _helpButton:Button;
      
      public function LeaguePanel()
      {
         super(603,445);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _headerPanel = new LeagueHeaderPanel();
         addChild(_headerPanel);
         _listPanel = new LeagueMembersListPanel();
         addChild(_listPanel);
         _generalInfoPanel = new LeagueGeneralInfoPanel();
         _generalInfoPanel.visible = false;
         addChild(_generalInfoPanel);
         _helpButton = new QuestHintButton();
         _helpButton.visible = false;
         addChild(_helpButton);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_headerPanel,bg,0,0);
         AlignmentUtil.alignAccordingToPositionOf(_listPanel,bg,0,75);
         AlignmentUtil.alignAccordingToPositionOf(_generalInfoPanel,bg,0,75);
         AlignmentUtil.alignAccordingToPositionOf(_helpButton,bg,603 - _helpButton.width - 3,3);
         super.drawLayout();
      }
      
      public function get helpButton() : Button
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
   }
}


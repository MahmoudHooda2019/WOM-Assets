package wom.view.screen.windows.alliance
{
   public class AllianceCandidatesListPanel extends AllianceMembersPanel
   {
      
      private var _isSearchedCandidatesPanel:Boolean;
      
      public function AllianceCandidatesListPanel(param1:Boolean = false)
      {
         super();
         _isSearchedCandidatesPanel = param1;
      }
      
      override protected function initHeaderWidths() : void
      {
         headerWidths["level"] = 85;
         headerWidths["name"] = 155;
         headerWidths["battle_points"] = 103;
         headerWidths["actions"] = 309;
      }
      
      public function get isSearchedCandidatesPanel() : Boolean
      {
         return _isSearchedCandidatesPanel;
      }
   }
}


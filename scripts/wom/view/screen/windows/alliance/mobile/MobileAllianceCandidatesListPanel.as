package wom.view.screen.windows.alliance.mobile
{
   public class MobileAllianceCandidatesListPanel extends MobileAllianceMembersPanel
   {
      
      private var _isSearchedCandidatesPanel:Boolean;
      
      public function MobileAllianceCandidatesListPanel(param1:int, param2:Boolean = false)
      {
         super(param1);
         _isSearchedCandidatesPanel = param2;
      }
      
      public function get isSearchedCandidatesPanel() : Boolean
      {
         return _isSearchedCandidatesPanel;
      }
   }
}


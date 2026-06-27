package wom.view.screen.windows.alliance.mobile
{
   public class MobileMyAlliancePanel extends MobileAlliancePanel
   {
      
      public function MobileMyAlliancePanel(param1:int, param2:Boolean = false, param3:int = 0)
      {
         super(param1,param2,param3);
      }
      
      override protected function getMemberPanelInstance() : MobileAllianceMembersPanel
      {
         return new MobileMyAllianceMembersPanel(_widthDifference,_fromBrowseTab);
      }
   }
}


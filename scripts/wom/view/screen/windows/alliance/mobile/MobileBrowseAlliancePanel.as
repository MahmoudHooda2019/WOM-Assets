package wom.view.screen.windows.alliance.mobile
{
   import peak.display.View;
   import peak.logging.log;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.service.logging.WomLoggerContexts;
   
   public class MobileBrowseAlliancePanel extends Sprite implements View
   {
      
      private var _listPanel:MobileBrowseAllianceListPanel;
      
      private var _allianceInfoPanel:MobileAlliancePanel;
      
      private var _createAlliancepanel:MobileCreateAlliancePanel;
      
      private var _allianceToBeViewed:AllianceDetailInfo;
      
      private var _widthDifference:int;
      
      public function MobileBrowseAlliancePanel(param1:int)
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
         _listPanel = new MobileBrowseAllianceListPanel(_widthDifference);
         addChild(_listPanel);
         _allianceInfoPanel = new MobileAlliancePanel(_widthDifference,true);
         _allianceInfoPanel.visible = false;
         addChild(_allianceInfoPanel);
      }
      
      public function updateVisibilityOfCreateAlliancePanel(param1:Boolean) : void
      {
         if(_createAlliancepanel == null)
         {
            if(param1)
            {
               _createAlliancepanel = new MobileCreateAlliancePanel(false,_widthDifference);
               _createAlliancepanel.visible = true;
               addChild(_createAlliancepanel);
            }
         }
         else
         {
            _createAlliancepanel.visible = param1;
         }
      }
      
      public function drawLayout() : void
      {
      }
      
      public function updatePanelsVisibility(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         updateVisibilityOfCreateAlliancePanel(param3);
         _listPanel.visible = param4;
         if(param1 || param2)
         {
            _allianceInfoPanel.visible = true;
            if(param1)
            {
               _allianceInfoPanel.activateGeneralInfoTab();
            }
            else if(param2)
            {
               _allianceInfoPanel.activateAllianceMembersTab();
            }
            else
            {
               log(WomLoggerContexts.GAME,"Browse alliance detail, non of members and general info are visible");
            }
         }
         else
         {
            _allianceInfoPanel.visible = false;
            updateViewedAlliance(null);
         }
      }
      
      public function updateViewedAlliance(param1:AllianceDetailInfo) : void
      {
         _allianceToBeViewed = param1;
         _allianceInfoPanel.updateWithAlliance(param1,AllianceRoleType.OUTSIDER);
      }
      
      public function updateAllianceLeaderName(param1:String) : void
      {
         _allianceInfoPanel.updateLeaderName(param1);
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
         _listPanel.updateTabActivation(param1);
         if(_createAlliancepanel)
         {
            _createAlliancepanel.updateTabActivation(param1);
         }
      }
      
      public function get allianceToBeViewed() : AllianceDetailInfo
      {
         return _allianceToBeViewed;
      }
   }
}


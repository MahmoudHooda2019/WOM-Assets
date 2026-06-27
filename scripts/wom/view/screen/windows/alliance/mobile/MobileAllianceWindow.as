package wom.view.screen.windows.alliance.mobile
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.MobileButtonTabbedFullscreenWindow;
   
   public class MobileAllianceWindow extends MobileButtonTabbedFullscreenWindow
   {
      
      public static const GENERAL_INFO_TAB:int = 0;
      
      public static const MEMBERS_TAB:int = 1;
      
      public static const BROWSE_ALLIANCE_PANEL:int = 0;
      
      public static const ALLIANCE_TOURNAMENT_PANEL:int = 1;
      
      public static const MY_ALLIANCE_PANEL:int = 2;
      
      public static const CANDIDATES_PANEL:int = 3;
      
      private var _helpButton:MPButton;
      
      private var contentContainer:Sprite;
      
      private var _browseAllianceButton:MPButton;
      
      private var _allianceTournamentButton:MPButton;
      
      private var _myAllianceButton:MPButton;
      
      private var _candidatesButton:MPButton;
      
      private var _buttonIndexToButtonMap:Dictionary;
      
      private var browsePanel:MobileBrowseAlliancePanel;
      
      private var tournamentPanel:MobileAllianceTournamentPanel;
      
      private var myAlliancePanel:MobileAlliancePanel;
      
      private var candidatesPanel:MobileAllianceCandidatesPanel;
      
      private var _defaultPanel:int;
      
      private var _defaultTab:int;
      
      public function MobileAllianceWindow(param1:int = 1, param2:int = 0, param3:Vector.<WindowEnumeration> = null)
      {
         super(false,param3);
         _defaultPanel = param1;
         _defaultTab = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         contentContainer = new Sprite();
         addChild(contentContainer);
         var _temp_2:* = contentContainer;
         var _loc2_:String = "ui.windows.alliance.browse.header";
         _browseAllianceButton = createTabButton(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc2_),267);
         var _temp_5:* = contentContainer;
         var _loc3_:String = "ui.windows.alliance.tournament.header";
         _allianceTournamentButton = createTabButton(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc3_),210);
         var _temp_8:* = contentContainer;
         var _loc4_:String = "ui.windows.alliance.myalliance.header";
         _myAllianceButton = createTabButton(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc4_),194);
         var _temp_11:* = contentContainer;
         var _loc5_:String = "ui.windows.alliance.candidates.header";
         _candidatesButton = createTabButton(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc5_),225);
         var _loc1_:int = _windowWidth - 1024;
         browsePanel = new MobileBrowseAlliancePanel(_loc1_);
         tournamentPanel = new MobileAllianceTournamentPanel(_loc1_);
         myAlliancePanel = new MobileMyAlliancePanel(_loc1_,false,_defaultTab == 1 ? 1 : 0);
         candidatesPanel = new MobileAllianceCandidatesPanel(_loc1_);
         addTab(contentContainer,_browseAllianceButton,browsePanel,12,84);
         addTab(contentContainer,_allianceTournamentButton,tournamentPanel,12,84);
         addTab(contentContainer,_myAllianceButton,myAlliancePanel,12,84);
         addTab(contentContainer,_candidatesButton,candidatesPanel,12,84);
         _buttonIndexToButtonMap = new Dictionary();
         _buttonIndexToButtonMap[0] = _browseAllianceButton;
         _buttonIndexToButtonMap[1] = _allianceTournamentButton;
         _buttonIndexToButtonMap[2] = _myAllianceButton;
         _buttonIndexToButtonMap[3] = _candidatesButton;
         _helpButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         addChild(_helpButton);
         drawLayout();
         switch(_defaultPanel)
         {
            case 0:
               activateTabByButton(_browseAllianceButton);
               break;
            case 1:
               activateTabByButton(_allianceTournamentButton);
               break;
            case 2:
               activateTabByButton(_myAllianceButton);
               break;
            case 3:
               activateTabByButton(_candidatesButton);
         }
      }
      
      public function drawLayout() : void
      {
         _browseAllianceButton.validate();
         _allianceTournamentButton.validate();
         _myAllianceButton.validate();
         _candidatesButton.validate();
         closeButton.validate();
         _helpButton.validate();
         MobileAlignmentUtil.alignRightOf(_allianceTournamentButton,_browseAllianceButton,5);
         MobileAlignmentUtil.alignRightOf(_myAllianceButton,_allianceTournamentButton,5);
         MobileAlignmentUtil.alignRightOf(_candidatesButton,_myAllianceButton,5);
         _helpButton.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_helpButton,_closeButton,-14 - _helpButton.width);
      }
      
      public function updateTabsWithAllianceInfo(param1:AllianceInfo) : void
      {
         var _loc3_:Boolean = param1.myAllianceSummary != null;
         var _loc2_:Boolean = _loc3_ && param1.myAllianceSummary.role == AllianceRoleType.LEADER;
         _myAllianceButton.visible = _loc3_;
         _candidatesButton.visible = _loc2_;
      }
      
      public function activateTabByIndex(param1:int) : void
      {
         var _loc2_:MPButton = null;
         if(param1 in _buttonIndexToButtonMap)
         {
            _loc2_ = _buttonIndexToButtonMap[param1];
            if(_loc2_.visible)
            {
               activateTabByButton(_loc2_);
            }
         }
      }
      
      override public function activateTabByButton(param1:MPButton) : void
      {
         var _loc2_:Sprite = activePanel;
         super.activateTabByButton(param1);
         if(_loc2_ != activePanel)
         {
            updateTabActivation(_loc2_,false);
            updateTabActivation(activePanel,true);
         }
      }
      
      private function updateTabActivation(param1:Sprite, param2:Boolean) : void
      {
         if(param1)
         {
            if(param2)
            {
               if(param1.isFlattened)
               {
                  param1.unflatten();
               }
            }
            else
            {
               param1.flatten();
            }
            if(param1 == browsePanel)
            {
               browsePanel.updateTabActivation(param2);
            }
            else if(param1 == tournamentPanel)
            {
               tournamentPanel.updateTabActivation(param2);
            }
            else if(param1 == myAlliancePanel)
            {
               myAlliancePanel.updateTabActivation(param2);
            }
            else if(param1 == candidatesPanel)
            {
               candidatesPanel.updateTabActivation(param2);
            }
         }
      }
      
      public function get helpButton() : MPButton
      {
         return _helpButton;
      }
   }
}


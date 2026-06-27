package wom.view.screen.windows.alliance.mobile
{
   import feathers.data.ListCollection;
   import peak.component.mobile.MPButton;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTabBar;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileAlliancePanel extends Sprite implements View
   {
      
      private static var WIDTH:int = 1000;
      
      private static var HEIGHT:int = 626;
      
      public static const TAB_GENERAL_INFO:int = 0;
      
      public static const TAB_MY_ALLIANCE_MEMBERS:int = 1;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _tabBar:MobileWomTabBar;
      
      private var _membersPanel:MobileAllianceMembersPanel;
      
      private var _generalInfoPanel:MobileAllianceGeneralInfoPanel;
      
      private var _editPanel:MobileCreateAlliancePanel;
      
      private var _activePanel:Sprite;
      
      private var _backToAlliancesButton:MPButton;
      
      protected var _fromBrowseTab:Boolean;
      
      protected var _widthDifference:int;
      
      private var _defaultVisibleTab:int;
      
      public function MobileAlliancePanel(param1:int, param2:Boolean = false, param3:int = 0)
      {
         super();
         _widthDifference = param1;
         _fromBrowseTab = param2;
         _defaultVisibleTab = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _tabBar = new MobileWomTabBar();
         var _temp_6:* = _tabBar;
         var _temp_5:* = §§findproperty(ListCollection);
         var _temp_2:* = "label";
         var _loc1_:String = "ui.windows.alliance.myalliance.generalinfo";
         var _temp_4:* = {_temp_2:peak.i18n.PText.INSTANCE.getText0(_loc1_)};
         var _temp_3:* = "label";
         var _loc2_:String = "ui.windows.alliance.myalliance.membersbutton";
         _temp_6.dataProvider = new ListCollection([_temp_4,{_temp_3:peak.i18n.PText.INSTANCE.getText0(_loc2_)}]);
         _tabBar.selectedIndex = _defaultVisibleTab;
         addChild(_tabBar);
         background = assetRepository.getDisplayObject("MobileDarkBackground");
         background.width = WIDTH + _widthDifference;
         background.height = HEIGHT;
         addChild(background);
         _generalInfoPanel = new MobileAllianceGeneralInfoPanel(_fromBrowseTab);
         _generalInfoPanel.visible = _defaultVisibleTab == 0;
         addChild(_generalInfoPanel);
         _membersPanel = getMemberPanelInstance();
         _membersPanel.visible = _defaultVisibleTab == 1;
         addChild(_membersPanel);
         _activePanel = _defaultVisibleTab == 0 ? _generalInfoPanel : _membersPanel;
         _editPanel = null;
         _backToAlliancesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _backToAlliancesButton.width = 250;
         var _temp_13:* = _backToAlliancesButton;
         var _loc3_:String = "ui.windows.alliance.browse.backtoalliances";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _backToAlliancesButton.visible = _fromBrowseTab;
         addChild(_backToAlliancesButton);
         drawLayout();
      }
      
      protected function getMemberPanelInstance() : MobileAllianceMembersPanel
      {
         return new MobileAllianceMembersPanel(_widthDifference,_fromBrowseTab);
      }
      
      public function drawLayout() : void
      {
         _backToAlliancesButton.validate();
         MobileAlignmentUtil.alignBelowOf(background,_tabBar,-9);
         _tabBar.x += 10;
         MobileAlignmentUtil.alignAccordingToPositionOf(_backToAlliancesButton,background,background.width - _backToAlliancesButton.width,-_backToAlliancesButton.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_generalInfoPanel,background,_widthDifference >> 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_membersPanel,background,0);
      }
      
      public function get tabBar() : MobileWomTabBar
      {
         return _tabBar;
      }
      
      public function activateGeneralInfoTab() : void
      {
         activatePanel(_generalInfoPanel);
         updateVisibilityOfEditPanel(false);
      }
      
      public function activateAllianceMembersTab() : void
      {
         activatePanel(_membersPanel);
         updateVisibilityOfEditPanel(false);
      }
      
      public function activatePanel(param1:Sprite) : void
      {
         if(_activePanel != null)
         {
            _activePanel.visible = false;
         }
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      public function updateVisibilityOfEditPanel(param1:Boolean) : void
      {
         if(_editPanel == null)
         {
            if(param1)
            {
               _editPanel = new MobileCreateAlliancePanel(true,_widthDifference);
               _editPanel.visible = true;
               addChild(_editPanel);
            }
         }
         else
         {
            _editPanel.visible = param1;
         }
      }
      
      public function updateLeaderName(param1:String) : void
      {
         _generalInfoPanel.updateLeaderName(param1);
      }
      
      public function updateWithAlliance(param1:AllianceDetailInfo, param2:AllianceRoleType) : void
      {
         if(param1 == null && _tabBar)
         {
            _tabBar.selectedIndex = 0;
         }
         _generalInfoPanel.updateWithAllianceInfo(param1,param2);
         _membersPanel.allianceToBeViewed = param1;
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
         if(_editPanel)
         {
            _editPanel.updateTabActivation(param1);
         }
      }
      
      public function get backToAlliancesButton() : MPButton
      {
         return _backToAlliancesButton;
      }
      
      public function get fromBrowseTab() : Boolean
      {
         return _fromBrowseTab;
      }
   }
}


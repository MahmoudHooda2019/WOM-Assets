package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTabBar;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.util.GenericWindow;
   
   public class AllianceWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 716;
      
      private static const WINDOW_HEIGHT:int = 555;
      
      public static const TAB_INDEX_BROWSE:int = 0;
      
      public static const TAB_INDEX_TOURNAMENT:int = 1;
      
      public static const TAB_INDEX_MY_ALLIANCE:int = 2;
      
      public static const TAB_INDEX_CANDIDATES:int = 3;
      
      private var _tabBar:WomTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var _initialTabIndex:int;
      
      private var _helpButton:Button;
      
      private var helpContainer:Sprite;
      
      private var contentContainer:Sprite;
      
      private var _isMember:Boolean;
      
      private var _isLeader:Boolean;
      
      public function AllianceWindow(param1:int = 0, param2:Vector.<WindowEnumeration> = null)
      {
         super(716,555,param2);
         _initialTabIndex = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.alliance.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         contentContainer = new Sprite();
         addChild(contentContainer);
         _tabPanels = new Dictionary();
         addTab(0,new BrowseAlliancePanel());
         addTab(1,new AllianceTournamentPanel());
         addTab(2,new MyAlliancePanel());
         addTab(3,new AllianceCandidatesPanel());
         _tabBar = new WomTabBar();
         contentContainer.addChild(_tabBar);
         helpContainer = new Sprite();
         helpContainer.visible = false;
         addChild(helpContainer);
         createAndAddHelpContent();
         _helpButton = new QuestHintButton();
         addChild(_helpButton);
         drawLayout();
      }
      
      private function createAndAddHelpContent() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc5_:TextField = null;
         var _loc6_:int = 0;
         var _loc4_:DisplayObject = assetRepository.getDisplayObject("BackgroundDark");
         _loc4_.width = 664;
         _loc4_.height = 500;
         AlignmentUtil.alignAccordingToPositionOf(_loc4_,_background,26,30);
         helpContainer.addChild(_loc4_);
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("PoseMedium4");
         AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc4_,10,54);
         helpContainer.addChild(_loc3_);
         var _temp_2:* = helpContainer;
         var _loc9_:String = "ui.windows.alliance.help.title";
         var _loc2_:TextField = createDefaultCaptionTextField(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc9_),WomTextFormats.FONT_SIZE_22);
         AlignmentUtil.alignAccordingToPositionOf(_loc2_,_loc4_,200,85);
         var _loc8_:DisplayObject = _loc2_;
         var _loc7_:int = _loc2_.height;
         _loc6_ = 1;
         while(_loc6_ < 8)
         {
            _loc1_ = assetRepository.getDisplayObject("MainQuestPreviewComplete");
            AlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_loc8_,10,_loc7_);
            if(_loc6_ == 1)
            {
               _loc1_.x += 25;
               _loc1_.y += 5;
            }
            helpContainer.addChild(_loc1_);
            var _temp_6:* = helpContainer;
            var _loc10_:String = "ui.windows.alliance.help.tips." + _loc6_;
            _loc5_ = createDefaultTextField(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc10_),WomTextFormats.FONT_SIZE_18,405);
            AlignmentUtil.alignRightOf(_loc5_,_loc1_,3);
            helpContainer.addChild(_loc5_);
            _loc8_ = _loc1_;
            _loc7_ = _loc5_.height;
            _loc6_++;
         }
      }
      
      private function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:GlowFilter = null) : TextField
      {
         var _loc5_:TextField = new CaptionTextField(param4 == null ? WomTextFormats.BLACK_FILTER : param4);
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.text = param2;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      private function createDefaultTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:Object = null) : TextField
      {
         var _loc5_:TextField = new WomTextField();
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.width = param4 == null ? 450 : param4 as int;
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.text = param2;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_tabBar,_background,40,44);
         for each(var _loc1_ in _tabPanels)
         {
            AlignmentUtil.alignAccordingToPositionOf(_loc1_,_background,26,87);
         }
         _helpButton.x = _closeButton.x - 3 - _helpButton.width;
         _helpButton.y = _closeButton.y;
      }
      
      public function updateTabsWithAllianceInfo(param1:AllianceInfo) : void
      {
         var _loc2_:int = int(_tabBar.dataProvider == null ? -1 : _tabBar.selectedIndex);
         _isMember = param1.myAllianceSummary != null;
         _isLeader = _isMember && param1.myAllianceSummary.role == AllianceRoleType.LEADER;
         var _loc3_:Array = [];
         var _temp_4:* = _loc3_;
         var _loc4_:String = "ui.windows.alliance.browse.header";
         _temp_4.push(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         var _temp_5:* = _loc3_;
         var _loc5_:String = "ui.windows.alliance.tournament.header";
         _temp_5.push(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         if(_isMember)
         {
            var _temp_6:* = _loc3_;
            var _loc6_:String = "ui.windows.alliance.myalliance.header";
            _temp_6.push(peak.i18n.PText.INSTANCE.getText0(_loc6_));
         }
         if(_isLeader)
         {
            var _temp_7:* = _loc3_;
            var _loc7_:String = "ui.windows.alliance.candidates.header";
            _temp_7.push(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         }
         _tabBar.dataProvider = new DataProvider(_loc3_);
         if(_loc2_ == -1 || _loc2_ == 3 && !_isLeader || _loc2_ == 2 && !_isMember)
         {
            if(_loc2_ == -1 && _isMember)
            {
               activateTabByIndex(1);
            }
            else
            {
               activateTabByIndex(0);
            }
            drawLayout();
         }
      }
      
      private function addTab(param1:int, param2:Sprite) : void
      {
         _tabPanels[param1] = param2;
         param2.visible = false;
         contentContainer.addChild(param2);
      }
      
      public function activateTabByIndex(param1:int) : void
      {
         _tabBar.selectedIndex = param1;
         activatePanel(_tabPanels[param1]);
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
      
      public function toggleHint(param1:Boolean) : void
      {
         helpContainer.visible = param1;
         contentContainer.visible = !param1;
      }
      
      public function get tabBar() : WomTabBar
      {
         return _tabBar;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
      
      public function get helpButton() : Button
      {
         return _helpButton;
      }
      
      public function get isMember() : Boolean
      {
         return _isMember;
      }
      
      public function get isLeader() : Boolean
      {
         return _isLeader;
      }
   }
}


package wom.view.screen.windows.beast.cave
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
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomBeastCaveTabBar;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.util.GenericWindow;
   
   public class BeastCaveWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 735;
      
      private static const WINDOW_HEIGHT:int = 573;
      
      private var _beastKeeperBuildingTypeDIO:BuildingTypeDIO;
      
      private var _initialTabIndex:int;
      
      private var _tabBar:WomBeastCaveTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var _helpButton:Button;
      
      private var helpContainer:Sprite;
      
      private var contentContainer:Sprite;
      
      public function BeastCaveWindow(param1:BuildingTypeDIO, param2:int = 0, param3:Vector.<WindowEnumeration> = null)
      {
         super(735,573,param3);
         _beastKeeperBuildingTypeDIO = param1;
         _initialTabIndex = param2;
         _tabPanels = new Dictionary();
      }
      
      private static function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:GlowFilter = null) : TextField
      {
         var _loc5_:TextField = new CaptionTextField(param4 == null ? WomTextFormats.BLACK_FILTER : param4);
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.text = param2;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      private static function createDefaultTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:Object = null) : TextField
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
      
      private function addTab(param1:int, param2:Sprite) : void
      {
         _tabPanels[param1] = param2;
         param2.x = 21;
         param2.y = 80;
         param2.visible = false;
         contentContainer.addChild(param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.beast.cave.beast.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         contentContainer = new Sprite();
         addChild(contentContainer);
         _tabBar = new WomBeastCaveTabBar(_beastKeeperBuildingTypeDIO);
         addTab(0,new BeastPanel());
         addTab(1,new EvolutionPanel());
         addTab(2,new BeastCaveBeastKeeperPanel());
         addTab(3,new DailyFeedPanel());
         _tabBar.x = 34;
         _tabBar.y = 37;
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
         var _loc6_:TextField = null;
         var _loc7_:int = 0;
         var _loc5_:DisplayObject = assetRepository.getDisplayObject("BackgroundDark");
         _loc5_.width = 693;
         _loc5_.height = 522;
         AlignmentUtil.alignAccordingToPositionOf(_loc5_,_background,21,30);
         helpContainer.addChild(_loc5_);
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("PoseMedium4");
         AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc5_,10,76);
         helpContainer.addChild(_loc3_);
         var _temp_2:* = helpContainer;
         var _loc10_:String = "ui.windows.beast.cave.help.title";
         var _loc2_:TextField = createDefaultCaptionTextField(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc10_),WomTextFormats.FONT_SIZE_22);
         AlignmentUtil.alignAccordingToPositionOf(_loc2_,_loc5_,200,109);
         var _loc9_:DisplayObject = _loc2_;
         var _loc8_:int = _loc2_.height;
         var _loc4_:Boolean = Languages.activeLanguageId == "ar";
         _loc7_ = 1;
         while(_loc7_ < 6)
         {
            _loc1_ = assetRepository.getDisplayObject("MainQuestPreviewComplete");
            AlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_loc9_,10,_loc8_);
            if(_loc7_ == 1)
            {
               _loc1_.x += _loc4_ ? 425 : 25;
               _loc1_.y += 5;
            }
            helpContainer.addChild(_loc1_);
            §§push(§§findproperty(createDefaultTextField));
            §§push(helpContainer);
            var _loc11_:String = "ui.windows.beast.cave.help.tips." + _loc7_;
            _loc6_ = §§pop().createDefaultTextField(§§pop(),peak.i18n.PText.INSTANCE.getText0(_loc11_),_loc4_ ? WomTextFormats.RIGHT_18 : WomTextFormats.FONT_SIZE_18,405);
            if(_loc4_)
            {
               AlignmentUtil.alignLeftOf(_loc6_,_loc1_,3);
            }
            else
            {
               AlignmentUtil.alignRightOf(_loc6_,_loc1_,3);
            }
            helpContainer.addChild(_loc6_);
            _loc9_ = _loc1_;
            _loc8_ = _loc6_.height;
            _loc7_++;
         }
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
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignLeftOf(_helpButton,_closeButton,3);
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         helpContainer.visible = param1;
         contentContainer.visible = !param1;
      }
      
      public function get tabBar() : WomBeastCaveTabBar
      {
         return _tabBar;
      }
      
      public function get tabPanels() : Dictionary
      {
         return _tabPanels;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
      
      public function updateTabs(param1:BeastInfo, param2:BeastTypeDIO) : void
      {
         var _loc3_:Array = [];
         if(param1 != null)
         {
            var _temp_1:* = _loc3_;
            var _loc4_:String = "ui.windows.beast.cave.beast.tab.beast";
            _temp_1.push(peak.i18n.PText.INSTANCE.getText0(_loc4_));
            if(param1.level < param2.maxLevels)
            {
               var _temp_2:* = _loc3_;
               var _loc5_:String = "ui.windows.beast.cave.beast.tab.evolution";
               _temp_2.push(peak.i18n.PText.INSTANCE.getText0(_loc5_));
               if(_tabPanels[1] is DailyFeedPanel)
               {
                  swapPanels(1,3);
               }
            }
            else
            {
               var _temp_3:* = _loc3_;
               var _loc6_:String = "ui.windows.beast.cave.beast.tab.dailyfeed";
               _temp_3.push(peak.i18n.PText.INSTANCE.getText0(_loc6_));
               if(_tabPanels[1] is EvolutionPanel)
               {
                  swapPanels(1,3);
               }
            }
            if(!(_tabPanels[0] is BeastPanel))
            {
               swapPanels(0,2);
            }
         }
         else if(!(_tabPanels[0] is BeastCaveBeastKeeperPanel))
         {
            swapPanels(0,2);
         }
         var _temp_4:* = _loc3_;
         var _loc7_:String = "ui.windows.beast.cave.beast.tab.change";
         _temp_4.push(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         _tabBar.dataProvider = new DataProvider(_loc3_);
         if(param1 == null)
         {
            _tabBar.selectedIndex = 0;
         }
         if(_tabBar.selectedIndex != -1)
         {
            activateTabByIndex(_tabBar.selectedIndex);
         }
         drawLayout();
      }
      
      public function get helpButton() : Button
      {
         return _helpButton;
      }
      
      private function swapPanels(param1:int, param2:int) : void
      {
         var _loc3_:Sprite = _tabPanels[param1];
         _tabPanels[param1] = _tabPanels[param2];
         _tabPanels[param2] = _loc3_;
      }
   }
}


package wom.view.ui.mainframe.city
{
   import com.greensock.TweenMax;
   import peak.component.mobile.MPButton;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   import wom.view.ui.common.MobileInboxMenuButtonView;
   import wom.view.ui.common.MobileQuestTooltipView;
   
   public class MobileMenuPanel extends FlatteningSprite implements View
   {
      
      public static const TUTORIAL_ALL:int = 0;
      
      public static const TUTORIAL_BUILD:int = 1;
      
      public static const TUTORIAL_STORE:int = 2;
      
      public static const TUTORIAL_WAR:int = 3;
      
      public static const TUTORIAL_ALLIANCE:int = 4;
      
      public static const TUTORIAL_QUEST:int = 5;
      
      public static const TUTORIAL_FRIENDS:int = 6;
      
      public static const TUTORIAL_RANKING:int = 7;
      
      public static const TUTORIAL_INBOX:int = 8;
      
      public static const TUTORIAL_ITEMS:Array = [1,2,3,4,5,6,7,8];
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _newStashItemIcon:DisplayObject;
      
      protected var _buildMenuButton:MPButton;
      
      protected var _storeMenuButton:MPButton;
      
      protected var _warMenuButton:MPButton;
      
      protected var _allianceMenuButton:MPButton;
      
      protected var _visibleWidth:int;
      
      protected var _visibleHeight:int;
      
      private var _questMenuButton:MPButton;
      
      private var _questMenuButtonVisibilityAccordingToTutorial:Boolean = true;
      
      private var _newQuestIndicator:MobileQuestTooltipView;
      
      private var _progressQuestIndicator:MobileQuestTooltipView;
      
      private var _friendsMenuButton:MPButton;
      
      private var _rankingMenuButton:MPButton;
      
      private var _inboxMenuButtonView:MobileInboxMenuButtonView;
      
      public function MobileMenuPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _buildMenuButton = MobileWomUIComponentFactory.createMenuButton("Blue","Large","IconBuildLBordered",15,-4);
         _buildMenuButton.width = 125;
         var _temp_2:* = _buildMenuButton;
         var _loc1_:String = "ui.mainframe.city.menupanel.build";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_buildMenuButton);
         _storeMenuButton = MobileWomUIComponentFactory.createMenuButton("Blue","Medium","IconStoreM",13,-4);
         _storeMenuButton.width = 92;
         var _temp_4:* = _storeMenuButton;
         var _loc2_:String = "ui.mainframe.city.menupanel.store";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_storeMenuButton);
         _newStashItemIcon = assetRepository.getDisplayObject("MobileBeigeBackground");
         _newStashItemIcon.visible = false;
         addChild(_newStashItemIcon);
         _questMenuButton = MobileWomUIComponentFactory.createMenuButton("White","Small","IconQuestMBordered",5,-2);
         _questMenuButton.setPaddings(10,20,20,20);
         _questMenuButton.width = 70;
         var _temp_7:* = _questMenuButton;
         var _loc3_:String = "ui.mainframe.city.menupanel.quest";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_questMenuButton);
         var _temp_10:* = §§findproperty(MobileQuestTooltipView);
         var _temp_9:* = assetRepository;
         var _temp_8:* = 145;
         var _loc4_:String = "ui.windows.quest.new";
         var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _newQuestIndicator = new MobileQuestTooltipView(_temp_9,_temp_8,peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc5_));
         _newQuestIndicator.visible = false;
         _newQuestIndicator.alpha = 0;
         addChild(_newQuestIndicator);
         var _temp_14:* = §§findproperty(MobileQuestTooltipView);
         var _temp_13:* = assetRepository;
         var _temp_12:* = 145;
         var _loc6_:String = "ui.windows.quest.progress";
         var _loc7_:* = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _progressQuestIndicator = new MobileQuestTooltipView(_temp_13,_temp_12,peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc7_));
         _progressQuestIndicator.visible = false;
         _progressQuestIndicator.alpha = 0;
         addChild(_progressQuestIndicator);
         _friendsMenuButton = MobileWomUIComponentFactory.createMenuButton("White","Small","IconSocialM",5,-1);
         _friendsMenuButton.width = 70;
         var _temp_17:* = _friendsMenuButton;
         var _loc8_:String = "ui.mainframe.city.menupanel.friends";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         addChild(_friendsMenuButton);
         _rankingMenuButton = MobileWomUIComponentFactory.createMenuButton("White","Small","IconRankingMBordered",5,-1);
         _rankingMenuButton.width = 70;
         var _temp_19:* = _rankingMenuButton;
         var _loc9_:String = "ui.mainframe.city.menupanel.rank";
         _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         addChild(_rankingMenuButton);
         _allianceMenuButton = MobileWomUIComponentFactory.createMenuButton("White","Small","IconAllianceM",5,-1);
         _allianceMenuButton.width = 70;
         var _temp_21:* = _allianceMenuButton;
         var _loc10_:String = "ui.mainframe.city.menupanel.alliance";
         _temp_21.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_allianceMenuButton);
         _inboxMenuButtonView = new MobileInboxMenuButtonView();
         addChild(_inboxMenuButtonView);
         _warMenuButton = MobileWomUIComponentFactory.createMenuButton("Red","Large","IconWarL",15,-3);
         _warMenuButton.width = 125;
         var _temp_24:* = _warMenuButton;
         var _loc11_:String = "ui.mainframe.city.menupanel.war";
         _temp_24.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(_warMenuButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _questMenuButton.x = 10;
         _questMenuButton.y = visibleHeight - 286;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_newQuestIndicator,_questMenuButton,_questMenuButton.width + 27);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_progressQuestIndicator,_questMenuButton,_questMenuButton.width + 27);
         _friendsMenuButton.x = 10;
         _friendsMenuButton.y = visibleHeight - 215;
         _buildMenuButton.x = 10;
         _buildMenuButton.y = visibleHeight - _buildMenuButton.height - 10;
         _storeMenuButton.x = 141;
         _storeMenuButton.y = visibleHeight - _storeMenuButton.height - 9;
         MobileAlignmentUtil.alignAccordingToPositionOf(_newStashItemIcon,_storeMenuButton,5,-25);
         _inboxMenuButtonView.x = visibleWidth - _inboxMenuButtonView.button.width - 141;
         _inboxMenuButtonView.y = _storeMenuButton.y;
         _warMenuButton.x = visibleWidth - _warMenuButton.width - 10;
         _warMenuButton.y = _buildMenuButton.y;
         _rankingMenuButton.x = visibleWidth - _rankingMenuButton.width - 10;
         _rankingMenuButton.y = visibleHeight - 286;
         _allianceMenuButton.x = visibleWidth - _allianceMenuButton.width - 10;
         _allianceMenuButton.y = visibleHeight - 215;
         flattenIfInStage();
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function get buildMenuButton() : MPButton
      {
         return _buildMenuButton;
      }
      
      public function get storeMenuButton() : MPButton
      {
         return _storeMenuButton;
      }
      
      public function get allianceMenuButton() : MPButton
      {
         return _allianceMenuButton;
      }
      
      public function get warMenuButton() : MPButton
      {
         return _warMenuButton;
      }
      
      public function get newStashItemIcon() : DisplayObject
      {
         return _newStashItemIcon;
      }
      
      public function get questMenuButton() : MPButton
      {
         return _questMenuButton;
      }
      
      public function get friendsMenuButton() : MPButton
      {
         return _friendsMenuButton;
      }
      
      public function get rankingMenuButton() : MPButton
      {
         return _rankingMenuButton;
      }
      
      public function get inboxMenuButtonView() : MobileInboxMenuButtonView
      {
         return _inboxMenuButtonView;
      }
      
      public function updateAllianceLogo(param1:AllianceSummaryInfo) : void
      {
         var _loc2_:MobileCoatOfArmsView = null;
         unflattenIfInStage();
         if(param1)
         {
            _loc2_ = new MobileCoatOfArmsView(assetRepository);
            _loc2_.updateWithCoatOfArmsInfo(param1.coaInfo);
            if(_loc2_.height != 51)
            {
               _loc2_.scaleX = _loc2_.scaleY = 51 / _loc2_.height;
            }
            _allianceMenuButton.defaultIcon = _loc2_;
         }
         else
         {
            _allianceMenuButton.defaultIcon = assetRepository.getDisplayObject("IconAllianceM");
         }
         flattenIfInStage();
      }
      
      private function setVisibleOfTutorialItem(param1:int, param2:Boolean) : void
      {
         switch(param1 - 1)
         {
            case 0:
               _buildMenuButton.visible = param2;
               break;
            case 1:
               _storeMenuButton.visible = param2;
               break;
            case 2:
               _warMenuButton.visible = param2;
               break;
            case 3:
               _allianceMenuButton.visible = param2;
               break;
            case 4:
               _questMenuButton.visible = _questMenuButtonVisibilityAccordingToTutorial = param2;
               break;
            case 5:
               _friendsMenuButton.visible = param2;
               break;
            case 6:
               _rankingMenuButton.visible = param2;
               break;
            case 7:
               _inboxMenuButtonView.visible = param2;
         }
      }
      
      public function updateVisibleOfTutorialItems(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            if(param1.indexOf(0) >= 0)
            {
               for each(_loc2_ in TUTORIAL_ITEMS)
               {
                  setVisibleOfTutorialItem(_loc2_,true);
               }
            }
            else
            {
               for each(_loc2_ in TUTORIAL_ITEMS)
               {
                  setVisibleOfTutorialItem(_loc2_,false);
               }
               for each(_loc2_ in param1)
               {
                  setVisibleOfTutorialItem(_loc2_,true);
               }
            }
            flattenIfInStage();
         }
      }
      
      public function get questMenuButtonVisibilityAccordingToTutorial() : Boolean
      {
         return _questMenuButtonVisibilityAccordingToTutorial;
      }
      
      public function showIndicators(param1:Boolean) : void
      {
         if(this.isFlattened)
         {
            unflattenIfInStage();
         }
         if(param1)
         {
            _newQuestIndicator.alpha = 0;
            _newQuestIndicator.visible = true;
            TweenMax.to(_newQuestIndicator,1,{
               "onComplete":onNewQuestTweenComplete,
               "alpha":1,
               "repeat":1,
               "repeatDelay":4,
               "yoyo":true
            });
         }
         else
         {
            _progressQuestIndicator.alpha = 0;
            _progressQuestIndicator.visible = true;
            TweenMax.to(_progressQuestIndicator,1,{
               "onComplete":onProgressQuestTweenComplete,
               "alpha":1,
               "repeat":1,
               "repeatDelay":4,
               "yoyo":true
            });
         }
      }
      
      private function onNewQuestTweenComplete() : void
      {
         _newQuestIndicator.alpha = 0;
         _newQuestIndicator.visible = false;
         flattenIfInStage();
      }
      
      private function onProgressQuestTweenComplete() : void
      {
         _progressQuestIndicator.alpha = 0;
         _progressQuestIndicator.visible = false;
         flattenIfInStage();
      }
      
      public function flattenIfInStage() : void
      {
         if(stage)
         {
            flatten();
         }
      }
      
      private function unflattenIfInStage() : void
      {
         if(stage)
         {
            unflatten();
         }
      }
   }
}


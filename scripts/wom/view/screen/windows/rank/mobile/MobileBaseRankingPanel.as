package wom.view.screen.windows.rank.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.controls.supportClasses.IViewPort;
   import feathers.data.ListCollection;
   import peak.component.mobile.MPList;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.rank.RankingInfo;
   import wom.model.game.rank.RankingSortCriteria;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTabBar;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileBaseRankingPanel extends Sprite implements View
   {
      
      protected static const WIDTH:int = 999;
      
      protected static const HEIGHT:int = 620;
      
      protected static const ALL_TIME_INDEX:int = 0;
      
      protected static const WEEKLY_INDEX:int = 1;
      
      protected static const DAILY_INDEX:int = 2;
      
      private static const PAGE_REQUEST_PULL_MARGIN:int = 120;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _rankingList:MPList;
      
      protected var _previousPageInfoTF:MobileWomTextField;
      
      protected var _nextPageInfoTF:MobileWomTextField;
      
      protected var _tabBar:MobileWomTabBar;
      
      protected var _criterion:RankingSortCriteria;
      
      protected var rank:int;
      
      protected var _currentPage:int;
      
      protected var _firstDataReceived:Boolean;
      
      protected var _ownGameId:String;
      
      public function MobileBaseRankingPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         _loc1_.width = 999;
         _loc1_.height = 620;
         _loc1_.y = 44;
         addChild(_loc1_);
         _tabBar = new MobileWomTabBar();
         var _temp_5:* = _tabBar;
         var _temp_4:* = §§findproperty(ListCollection);
         var _loc3_:String = "ui.windows.rank.alltime";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc4_:String = "ui.windows.rank.weekly";
         var _temp_2:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = "ui.windows.rank.daily";
         _temp_5.dataProvider = new ListCollection([_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc5_)]);
         addChild(_tabBar);
         var _loc2_:int = 949;
         _previousPageInfoTF = new MobileCaptionTextField();
         _previousPageInfoTF.textRendererProperties.textFormat = getCaptionTextFormat(38,"center");
         _previousPageInfoTF.width = _loc2_;
         addChild(_previousPageInfoTF);
         _nextPageInfoTF = new MobileCaptionTextField();
         _nextPageInfoTF.textRendererProperties.textFormat = getCaptionTextFormat(38,"center");
         _nextPageInfoTF.width = _loc2_;
         addChild(_nextPageInfoTF);
         _rankingList = new MPList();
         _rankingList.itemRendererFactory = rankingViewRendererFactory;
         alignList(_loc1_);
         _rankingList.height = 620 - 42;
         _rankingList.width = _loc2_;
         addChild(_rankingList);
         _firstDataReceived = false;
      }
      
      protected function alignList(param1:DisplayObject) : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_rankingList,param1,25,25);
      }
      
      public function updateWithOwnGameId(param1:String) : void
      {
         _ownGameId = param1;
      }
      
      protected function rankingViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileRankingViewRenderer = new MobileRankingViewRenderer(assetRepository,_ownGameId,0);
         _loc1_.width = _rankingList.width;
         _loc1_.height = 101;
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_previousPageInfoTF,_rankingList,0,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_nextPageInfoTF,_rankingList,0,_rankingList.height - 45);
      }
      
      public function rankingInfoUpdated(param1:RankingInfo) : void
      {
         _firstDataReceived = true;
         _currentPage = param1.page;
         _previousPageInfoTF.visible = _currentPage != 1;
         _nextPageInfoTF.visible = !param1.isLastPage;
         _rankingList.dataProvider = new ListCollection(param1.rankings);
         _rankingList.validate();
      }
      
      public function checkNextPageRequestConditions() : Boolean
      {
         var _loc2_:IViewPort = null;
         var _loc1_:Number = NaN;
         if(_rankingList && _rankingList.viewPort && _rankingList.dataProvider)
         {
            _loc2_ = _rankingList.viewPort;
            _loc1_ = _loc2_.verticalScrollPosition - _rankingList.dataProvider.length * _loc2_.verticalScrollStep + _rankingList.height;
            if(_loc1_ > 120)
            {
               var _temp_3:* = _nextPageInfoTF;
               var _loc3_:String = "m.ui.windows.leaderboard.releasefornextpage";
               _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               return true;
            }
         }
         return false;
      }
      
      public function checkPreviousPageRequestConditions() : Boolean
      {
         var _loc1_:IViewPort = null;
         if(_rankingList && _rankingList.viewPort && _rankingList.dataProvider)
         {
            _loc1_ = _rankingList.viewPort;
            if(_loc1_.verticalScrollPosition < -120)
            {
               var _temp_3:* = _previousPageInfoTF;
               var _loc2_:String = "m.ui.windows.leaderboard.releaseforpreviouspage";
               _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               return true;
            }
         }
         return false;
      }
      
      public function scrollCompleted() : void
      {
         var _temp_1:* = _previousPageInfoTF;
         var _loc1_:String = "m.ui.windows.leaderboard.pullforpreviouspage";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _temp_2:* = _nextPageInfoTF;
         var _loc2_:String = "m.ui.windows.leaderboard.pullfornextpage";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      public function updateCriterion() : void
      {
      }
      
      public function get tabBar() : MobileWomTabBar
      {
         return _tabBar;
      }
      
      public function get criterion() : RankingSortCriteria
      {
         return _criterion;
      }
      
      public function get rankingList() : MPList
      {
         return _rankingList;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get firstDataReceived() : Boolean
      {
         return _firstDataReceived;
      }
   }
}


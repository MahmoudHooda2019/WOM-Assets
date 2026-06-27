package wom.view.screen.windows.inbox.mobile
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPScrollPane;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomScrollPane;
   
   public class MobileInboxPanel extends Sprite implements View
   {
      
      private static const WIDTH:int = 999;
      
      private static const HEIGHT:int = 586;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _background:DisplayObject;
      
      private var _scrollPane:MPScrollPane;
      
      private var _requestContainers:Vector.<MobileRequestContainerView>;
      
      public function MobileInboxPanel(param1:int = 999, param2:int = 586)
      {
         super();
         _width = param1;
         _height = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("MobileDarkBackground");
         _background.width = _width;
         _background.height = _height;
         addChild(_background);
         _scrollPane = new MobileWomScrollPane();
         _scrollPane.width = 971;
         _scrollPane.height = _height - 40;
         _scrollPane.horizontalScrollPolicy = "off";
         _scrollPane.verticalScrollPolicy = "on";
         addChild(_scrollPane);
         _requestContainers = new Vector.<MobileRequestContainerView>();
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_scrollPane,_background,20);
         var _loc2_:int = -1;
         _loc1_ = 0;
         while(_loc1_ < _requestContainers.length)
         {
            if(_requestContainers[_loc1_].totalCount > 0)
            {
               if(_loc2_ < 0)
               {
                  _requestContainers[_loc1_].x = _requestContainers[_loc1_].y = 0;
               }
               else
               {
                  MobileAlignmentUtil.alignBelowOf(_requestContainers[_loc1_],_requestContainers[_loc2_],15);
               }
               _loc2_ = _loc1_;
            }
            else
            {
               _requestContainers[_loc1_].x = _requestContainers[_loc1_].y = 0;
            }
            _loc1_++;
         }
      }
      
      private function clear() : void
      {
         for each(var _loc1_ in _requestContainers)
         {
            if(contains(_loc1_))
            {
               _scrollPane.removeChild(_loc1_);
            }
         }
         _requestContainers.length = 0;
      }
      
      public function update(param1:Dictionary) : Vector.<ProfileIdPair>
      {
         var _loc5_:MobileRequestContainerView = null;
         clear();
         var _loc6_:Vector.<ProfileIdPair> = null;
         if(param1 != null)
         {
            _loc6_ = new Vector.<ProfileIdPair>();
            for each(var _loc4_ in RequestInfo.sortedRequestTypes())
            {
               if(_loc4_ in param1)
               {
                  _loc5_ = new MobileRequestContainerView(_loc4_);
                  _scrollPane.addChild(_loc5_);
                  _requestContainers.push(_loc5_);
                  for each(var _loc2_ in param1[_loc4_])
                  {
                     for each(var _loc3_ in _loc2_)
                     {
                        if(!_loc3_.friendProfile.isNpc)
                        {
                           _loc6_.push(new ProfileIdPair(_loc3_.friendProfile.platformId,_loc3_.friendProfile.avatar));
                        }
                     }
                  }
               }
            }
         }
         drawLayout();
         return _loc6_;
      }
      
      public function get requestContainers() : Vector.<MobileRequestContainerView>
      {
         return _requestContainers;
      }
   }
}


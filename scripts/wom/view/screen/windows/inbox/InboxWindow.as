package wom.view.screen.windows.inbox
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.friend.request.RequestInfo;
   import wom.view.component.WomScrollPane;
   import wom.view.util.GenericWindow;
   
   public class InboxWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 639;
      
      private static const WINDOW_HEIGHT:int = 508;
      
      private var _scrollPaneBackground:DisplayObject;
      
      private var _scrollPane:WomScrollPane;
      
      private var _scrollPaneContent:Sprite;
      
      private var _requestContainers:Vector.<RequestContainerView>;
      
      public function InboxWindow()
      {
         super(639,508);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.inbox.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _scrollPaneBackground = assetRepository.getDisplayObject("BackgroundLight");
         _scrollPaneBackground.width = 589;
         _scrollPaneBackground.height = 458;
         addChild(_scrollPaneBackground);
         _scrollPane = new WomScrollPane();
         _scrollPane.width = 576;
         _scrollPane.height = 442;
         _scrollPane.verticalScrollPolicy = "on";
         addChild(_scrollPane);
         _scrollPaneContent = new Sprite();
         _requestContainers = new Vector.<RequestContainerView>();
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         AlignmentUtil.alignAccordingToPositionOf(_scrollPaneBackground,_background,25,25);
         AlignmentUtil.alignAccordingToPositionOf(_scrollPane,_background,36,32);
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
                  AlignmentUtil.alignBelowOf(_requestContainers[_loc1_],_requestContainers[_loc2_],15);
               }
               _loc2_ = _loc1_;
            }
            else
            {
               _requestContainers[_loc1_].x = _requestContainers[_loc1_].y = 0;
            }
            _loc1_++;
         }
         _scrollPane.source = _scrollPaneContent;
      }
      
      private function clear() : void
      {
         for each(var _loc1_ in _requestContainers)
         {
            if(contains(_loc1_))
            {
               _scrollPaneContent.removeChild(_loc1_);
            }
         }
         _requestContainers.length = 0;
      }
      
      public function update(param1:Dictionary) : Vector.<ProfileIdPair>
      {
         var _loc5_:RequestContainerView = null;
         clear();
         var _loc6_:Vector.<ProfileIdPair> = null;
         if(param1 != null)
         {
            _loc6_ = new Vector.<ProfileIdPair>();
            for each(var _loc4_ in RequestInfo.sortedRequestTypes())
            {
               if(_loc4_ in param1)
               {
                  _loc5_ = new RequestContainerView(_loc4_);
                  _scrollPaneContent.addChild(_loc5_);
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
      
      public function get requestContainers() : Vector.<RequestContainerView>
      {
         return _requestContainers;
      }
   }
}


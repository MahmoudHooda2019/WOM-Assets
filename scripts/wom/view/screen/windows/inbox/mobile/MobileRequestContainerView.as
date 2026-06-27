package wom.view.screen.windows.inbox.mobile
{
   import peak.component.mobile.MPButton;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileRequestContainerView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _requestType:int;
      
      private var _totalCount:int;
      
      private var _count:int;
      
      private var _requestViews:Vector.<MobileBaseRequestView>;
      
      private var _seeMoreRequestButton:MPButton;
      
      public function MobileRequestContainerView(param1:int)
      {
         super();
         _requestType = param1;
         _totalCount = 0;
         _count = 0;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _requestViews = new Vector.<MobileBaseRequestView>();
         _seeMoreRequestButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         _seeMoreRequestButton.label = "";
         _seeMoreRequestButton.width = 79;
         addChild(_seeMoreRequestButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_requestType > -1)
         {
            _loc1_ = _totalCount - _count;
            if(_loc1_ > 20)
            {
               _loc1_ = 20;
            }
            var _temp_2:* = _seeMoreRequestButton;
            var _temp_1:* = "ui.windows.inbox.seemore";
            var _loc3_:int = _loc1_;
            var _loc4_:String = _temp_1;
            _temp_2.label = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         }
         if(_requestViews.length > 0)
         {
            _requestViews[0].x = 0;
            _requestViews[0].y = 0;
         }
         _loc2_ = 1;
         while(_loc2_ < _requestViews.length)
         {
            MobileAlignmentUtil.alignBelowOf(_requestViews[_loc2_],_requestViews[_loc2_ - 1],15);
            _loc2_++;
         }
         _seeMoreRequestButton.isEnabled = _seeMoreRequestButton.visible = _count < _totalCount;
         if(_seeMoreRequestButton.isEnabled && _requestViews.length > 0)
         {
            MobileAlignmentUtil.alignBelowOf(_seeMoreRequestButton,_requestViews[_requestViews.length - 1],5);
         }
         else
         {
            _seeMoreRequestButton.x = 0;
            _seeMoreRequestButton.y = 0;
         }
      }
      
      public function update(param1:Vector.<Vector.<RequestInfo>>, param2:int) : void
      {
         var _loc4_:RequestInfo = null;
         _totalCount = param2;
         _count = 0;
         var _loc6_:int = 0;
         var _loc5_:Vector.<Vector.<RequestInfo>> = param1;
         while(§§hasnext(_loc5_,_loc6_))
         {
            var _loc3_:Vector.<RequestInfo> = §§nextvalue(_loc6_,_loc5_);
            loop1:
            switch(_requestType - 1)
            {
               case 0:
                  addRequestView(new MobileStaffRequestView(_loc3_[0]));
                  break;
               case 1:
                  addRequestView(new MobilePartRequestView(_loc3_));
                  break;
               case 2:
                  addRequestView(new MobileGiftRequestView(_loc3_));
                  break;
               case 8:
                  addRequestView(new MobileRewardRequestView(_loc3_[0]));
                  break;
               case 9:
                  addRequestView(new MobileAllianceInvitationRequestView(_loc3_[0]));
                  break;
               case 10:
                  addRequestView(new MobileWorkerStaffRequestView(_loc3_[0]));
                  break;
               case 12:
                  switch((_loc4_ = _loc3_[0]).type - 13)
                  {
                     case 0:
                        addRequestView(new MobileMysteryGoldRequestView(_loc4_));
                        break loop1;
                     case 1:
                        addRequestView(new MobileMysteryRpRequestView(_loc4_));
                        break loop1;
                     case 2:
                        addRequestView(new MobileMysteryResourceRequestView(_loc4_));
                        break loop1;
                     default:
                        break loop1;
                  }
            }
            _count += _loc3_.length;
         }
         drawLayout();
      }
      
      private function addRequestView(param1:MobileBaseRequestView) : void
      {
         addChild(param1);
         _requestViews.push(param1);
      }
      
      public function removeRequestView(param1:MobileBaseRequestView, param2:int) : void
      {
         _totalCount -= param2;
         _count -= param2;
         var _loc3_:int = _requestViews.indexOf(param1);
         removeChild(_requestViews.splice(_loc3_,1).pop());
         drawLayout();
      }
      
      public function get seeMoreRequestButton() : MPButton
      {
         return _seeMoreRequestButton;
      }
      
      public function get requestViews() : Vector.<MobileBaseRequestView>
      {
         return _requestViews;
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function get totalCount() : int
      {
         return _totalCount;
      }
   }
}


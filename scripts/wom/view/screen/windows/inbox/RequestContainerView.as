package wom.view.screen.windows.inbox
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBrownMiniButton;
   
   public class RequestContainerView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _requestType:int;
      
      private var _totalCount:int;
      
      private var _count:int;
      
      private var _requestViews:Vector.<BaseRequestView>;
      
      private var _headerTextField:TextField;
      
      private var _seeMoreRequestButtonBg:DisplayObject;
      
      private var _seeMoreRequestButton:WomButton;
      
      public function RequestContainerView(param1:int)
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
         _requestViews = new Vector.<BaseRequestView>();
         _headerTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerTextField.autoSize = "left";
         addChild(_headerTextField);
         _seeMoreRequestButton = new WomBrownMiniButton();
         _seeMoreRequestButton.label = "";
         _seeMoreRequestButton.width = 79;
         addChild(_seeMoreRequestButton);
         _seeMoreRequestButtonBg = assetRepository.getDisplayObject("TransparentAsset");
         _seeMoreRequestButtonBg.width = 1;
         _seeMoreRequestButtonBg.height = 25;
         addChild(_seeMoreRequestButtonBg);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _headerTextField.x = 0;
         _headerTextField.y = 4;
         if(_requestType > -1)
         {
            _loc1_ = _totalCount - _count;
            if(_loc1_ > 20)
            {
               _loc1_ = 20;
            }
            var _temp_2:* = _headerTextField;
            var _temp_1:* = "ui.windows.inbox.requesttype." + _requestType + ".containerheader";
            var _loc3_:int = _totalCount;
            var _loc4_:String = _temp_1;
            _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
            var _temp_4:* = _seeMoreRequestButton;
            var _temp_3:* = "ui.windows.inbox.seemore";
            var _loc5_:int = _loc1_;
            var _loc6_:String = _temp_3;
            _temp_4.label = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         }
         _headerTextField.visible = _totalCount > 0;
         if(_requestViews.length > 0)
         {
            AlignmentUtil.alignBelowOf(_requestViews[0],_headerTextField,0);
         }
         _loc2_ = 1;
         while(_loc2_ < _requestViews.length)
         {
            AlignmentUtil.alignBelowOf(_requestViews[_loc2_],_requestViews[_loc2_ - 1],15);
            _loc2_++;
         }
         _seeMoreRequestButton.enabled = _seeMoreRequestButton.visible = _count < _totalCount;
         if(_seeMoreRequestButton.enabled && _requestViews.length > 0)
         {
            AlignmentUtil.alignBelowOf(_seeMoreRequestButton,_requestViews[_requestViews.length - 1],5);
         }
         else
         {
            AlignmentUtil.alignBelowOf(_seeMoreRequestButton,_headerTextField,10);
         }
         AlignmentUtil.alignAccordingToPositionOf(_seeMoreRequestButtonBg,_seeMoreRequestButton,0,0);
      }
      
      public function update(param1:Vector.<Vector.<RequestInfo>>, param2:int) : void
      {
         var _loc4_:RequestInfo = null;
         _totalCount = param2;
         _count = 0;
         drawLine();
         for each(var _loc3_ in param1)
         {
            switch(_requestType - 1)
            {
               case 0:
                  addRequestView(new StaffRequestView(_loc3_[0]));
                  break;
               case 1:
                  addRequestView(new PartRequestView(_loc3_));
                  break;
               case 2:
                  addRequestView(new GiftRequestView(_loc3_));
                  break;
               case 8:
                  addRequestView(new RewardRequestView(_loc3_[0]));
                  break;
               case 9:
                  addRequestView(new AllianceInvitationRequestView(_loc3_[0]));
                  break;
               case 10:
                  addRequestView(new WorkerStaffRequestView(_loc3_[0]));
                  break;
               case 11:
                  addRequestView(new InviteFromInboxRequestView(_loc3_[0]));
                  break;
               case 12:
                  switch((_loc4_ = _loc3_[0]).type - 13)
                  {
                     case 0:
                        addRequestView(new MysteryGoldRequestView(_loc4_));
                        break;
                     case 1:
                        addRequestView(new MysteryRpRequestView(_loc4_));
                        break;
                     case 2:
                        addRequestView(new MysteryResourceRequestView(_loc4_));
                  }
            }
            _count += _loc3_.length;
         }
         drawLayout();
      }
      
      private function addRequestView(param1:BaseRequestView) : void
      {
         addChild(param1);
         _requestViews.push(param1);
         if(_requestViews.length > 1)
         {
            param1.drawLine();
         }
      }
      
      public function drawLine() : void
      {
         graphics.lineStyle(0,9865300,1);
         graphics.moveTo(0,25);
         graphics.lineTo(553,25);
      }
      
      public function removeRequestView(param1:BaseRequestView, param2:int) : void
      {
         _totalCount -= param2;
         _count -= param2;
         var _loc3_:int = _requestViews.indexOf(param1);
         removeChild(_requestViews.splice(_loc3_,1).pop());
         drawLayout();
      }
      
      public function get seeMoreRequestButton() : WomButton
      {
         return _seeMoreRequestButton;
      }
      
      public function get requestViews() : Vector.<BaseRequestView>
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


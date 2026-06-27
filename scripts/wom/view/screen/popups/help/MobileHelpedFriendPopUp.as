package wom.view.screen.popups.help
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.help.HelpInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   
   public class MobileHelpedFriendPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 567;
      
      private static const WINDOW_HEIGHT:int = 398;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      protected var _list:MPList;
      
      protected var _helps:Object;
      
      protected var _numOfHelps:int;
      
      public function MobileHelpedFriendPopUp(param1:Object, param2:int = 567, param3:int = 398)
      {
         super(param2,param3);
         _helps = param1;
         _numOfHelps = 0;
         for(var _loc4_ in param1)
         {
            _numOfHelps = _numOfHelps + 1;
         }
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.helpedfriend.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker4");
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         _list = new MPList();
         _list.itemRendererFactory = factory;
         _list.height = 300;
         _list.width = 488;
         _list.horizontalScrollPolicy = "off";
         _list.verticalScrollPolicy = "on";
         _list.layout = new VerticalLayout();
         addChild(_list);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 263;
         var _temp_5:* = _actionButton;
         var _loc2_:String = "ui.popups.helpedfriend.saythanks";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_actionButton);
         fillPane();
         drawLayout();
      }
      
      protected function factory() : IListItemRenderer
      {
         var _loc1_:MobileHelpedFriendLineRenderer = new MobileHelpedFriendLineRenderer(assetRepository,facebookAPIManager);
         _loc1_.width = 480;
         _loc1_.height = 75;
         return _loc1_;
      }
      
      protected function fillPane() : void
      {
         var _loc2_:Array = [];
         for(var _loc1_ in _helps)
         {
            _loc2_.push({
               "helper":(_helps[_loc1_][0] as HelpInfo).helper,
               "helps":_helps[_loc1_]
            });
         }
         _list.dataProvider = new ListCollection(_loc2_);
         _list.validate();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-202,-71);
         MobileAlignmentUtil.alignAccordingToPositionOf(_list,_background,45,33);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2);
      }
      
      public function get helps() : Object
      {
         return _helps;
      }
      
      public function get list() : MPList
      {
         return _list;
      }
      
      public function get numOfHelps() : int
      {
         return _numOfHelps;
      }
   }
}


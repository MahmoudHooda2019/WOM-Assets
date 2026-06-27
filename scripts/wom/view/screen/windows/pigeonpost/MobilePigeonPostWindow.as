package wom.view.screen.windows.pigeonpost
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.viral.Subscription;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   
   public class MobilePigeonPostWindow extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 560;
      
      private static const WINDOW_HEIGHT:int = 524;
      
      private var _infoButton:MPRigidButton;
      
      private var _listViewHeader:MPTextField;
      
      private var _checkBoxList:MPList;
      
      private var _visitForumTF:MPTextField;
      
      private var _visitForumBG:DisplayObject;
      
      private var _visitForumButton:MobileWomButton;
      
      private var _infoViewBG:DisplayObject;
      
      private var _listViewBG:DisplayObject;
      
      private var _infoViewDescTF:MPTextField;
      
      private var _infoView:Sprite;
      
      private var _listView:Sprite;
      
      public function MobilePigeonPostWindow(param1:int = 560, param2:int = 524)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.pigeonpost.title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker4");
         addChild(_imageAsset);
         _listView = new Sprite();
         _infoView = new Sprite();
         _listViewBG = assetRepository.getDisplayObject("MobileBeigeBackground");
         _listViewBG.width = 472;
         _listViewBG.height = 412;
         _listView.addChild(_listViewBG);
         _listViewHeader = new MobileCaptionTextField();
         _listViewHeader.textRendererProperties.textFormat = getCaptionTextFormat(27);
         _listView.addChild(_listViewHeader);
         var _temp_7:* = _listViewHeader;
         var _loc2_:String = "ui.windows.pigeonpost.header";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _checkBoxList = new MPList();
         _checkBoxList.itemRendererFactory = factory;
         _checkBoxList.width = 418;
         _checkBoxList.height = 325;
         _checkBoxList.horizontalScrollPolicy = "off";
         _checkBoxList.verticalScrollPolicy = "on";
         _checkBoxList.allowMultipleSelection = true;
         _listView.addChild(_checkBoxList);
         addChild(_listView);
         _infoViewBG = assetRepository.getDisplayObject("MobileBeigeBackground");
         _infoViewBG.width = 472;
         _infoViewBG.height = 412;
         _infoView.addChild(_infoViewBG);
         _infoViewDescTF = new MobileWomTextField();
         _infoViewDescTF.textRendererProperties.textFormat = getWomTextFormat(25,"center");
         _infoViewDescTF.textRendererProperties.wordWrap = true;
         _infoViewDescTF.width = 392;
         _infoView.addChild(_infoViewDescTF);
         var _temp_11:* = _infoViewDescTF;
         var _loc3_:String = "m.ui.windows.pigeonpost.desc";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _visitForumBG = assetRepository.getDisplayObject("MobileDarkBackground");
         _visitForumBG.width = 415;
         _visitForumBG.height = 233;
         _infoView.addChild(_visitForumBG);
         _visitForumTF = new MobileWomTextField();
         _visitForumTF.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         _visitForumTF.width = 366;
         _visitForumTF.textRendererProperties.wordWrap = true;
         _visitForumTF.textRendererProperties.multiline = true;
         _infoView.addChild(_visitForumTF);
         var _temp_14:* = _visitForumTF;
         var _loc4_:String = "m.ui.windows.pigeonpost.visitForumDesc";
         _temp_14.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _visitForumButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _visitForumButton.width = 169;
         _infoView.addChild(_visitForumButton);
         var _temp_16:* = _visitForumButton;
         var _loc5_:String = "m.ui.windows.pigeonpost.visitForumButton";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_infoView);
         _infoView.visible = false;
         _infoButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         addChild(_infoButton);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 322;
         addChild(_actionButton);
         var _temp_19:* = _actionButton;
         var _loc6_:String = "ui.windows.pigeonpost.saveandclose";
         _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-226,34);
         MobileAlignmentUtil.alignAccordingToPositionOf(_listViewBG,_background,44,56);
         MobileAlignmentUtil.alignAccordingToPositionOf(_infoViewBG,_background,44,56);
         MobileAlignmentUtil.alignAccordingToPositionOf(_listViewHeader,_listViewBG,38,30);
         _infoButton.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_infoButton,_listViewBG,-(_infoButton.width >> 1) + 5,-(_infoButton.height >> 1) + 5);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_checkBoxList,_listViewBG,75);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_infoViewDescTF,_infoViewBG,46);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_visitForumBG,_infoViewBG,140);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_visitForumTF,_visitForumBG,48);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_visitForumButton,_visitForumBG,118);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - (_actionButton.height >> 1));
      }
      
      private function factory() : IListItemRenderer
      {
         var _loc1_:MobilePigeonPostCheckBoxItemRenderer = new MobilePigeonPostCheckBoxItemRenderer();
         _loc1_.width = 418;
         _loc1_.height = 50;
         _loc1_.isQuickHitAreaEnabled = true;
         return _loc1_;
      }
      
      public function fillList(param1:Vector.<int>, param2:BuildingTypeInfo) : void
      {
         var _loc6_:Object = null;
         var _loc5_:Subscription = null;
         var _loc4_:Boolean = false;
         var _loc8_:int = 0;
         var _loc3_:Array = [];
         var _loc7_:Vector.<int> = new Vector.<int>();
         _loc8_ = 0;
         while(_loc8_ < Subscription.availableSubscriptions.length)
         {
            _loc5_ = Subscription.availableSubscriptions[_loc8_];
            _loc4_ = _loc5_ != Subscription.BEAST_HEALTH_IS_FULL && _loc5_ != Subscription.BEAST_READY_FOR_TRAINING || param2 && param2.currentInstanceCount > 0;
            §§push("subscription");
            §§push(_loc5_);
            §§push("label");
            var _loc9_:String = "notifications." + _loc5_.id + ".display";
            _loc6_ = null;
            _loc3_.push(_loc6_);
            if(_loc6_.selected)
            {
               _loc7_.push(_loc8_);
            }
            _loc8_++;
         }
         _checkBoxList.dataProvider = new ListCollection(_loc3_);
         _checkBoxList.selectedIndices = _loc7_;
         _checkBoxList.validate();
      }
      
      public function infoButtonClicked() : void
      {
         if(!_infoView.visible)
         {
            MobileWomUIComponentFactory.addFlipTween(_listView,_infoView,true,switchView);
         }
         else
         {
            MobileWomUIComponentFactory.addFlipTween(_infoView,_listView,true,switchView);
         }
      }
      
      private function switchView() : void
      {
         _infoView.visible = !_infoView.visible;
         _listView.visible = !_listView.visible;
      }
      
      public function get infoButton() : MPRigidButton
      {
         return _infoButton;
      }
      
      public function get checkBoxList() : MPList
      {
         return _checkBoxList;
      }
      
      public function get visitForumButton() : MobileWomButton
      {
         return _visitForumButton;
      }
   }
}


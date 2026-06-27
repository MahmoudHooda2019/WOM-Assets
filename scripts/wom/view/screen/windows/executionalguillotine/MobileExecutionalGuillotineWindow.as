package wom.view.screen.windows.executionalguillotine
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileBackgroundWithLabelView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileExecutionalGuillotineWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 840;
      
      private static const WINDOW_HEIGHT:int = 674;
      
      public static const EXECUTIONAL_GUILLOTINE:int = 1;
      
      public static const MERCENARY_BARRACKS:int = 2;
      
      public static const ALLIANCE_BARRACKS:int = 3;
      
      public static const FRIEND_WATCHPOST:int = 4;
      
      protected var informationSprite:MobileBackgroundWithLabelView;
      
      private var _mercenaryViews:Vector.<MobileExecutionalGuillotineMercenaryView>;
      
      protected var _mercenaryViewHolder:Sprite;
      
      protected var viewHolderBg:DisplayObject;
      
      protected var capacityLabel:MPTextField;
      
      protected var capacityBg:DisplayObject;
      
      private var _capacityProgress:MobileWomProgressBar;
      
      private var _selectAllButton:MobileWomButton;
      
      private var _executeButton:MobileWomButton;
      
      private var _viewType:int;
      
      public function MobileExecutionalGuillotineWindow(param1:int = 1, param2:int = 840, param3:int = 674)
      {
         super(param2,param3,windowEnumerations);
         _viewType = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc3_:String = "ui.windows." + (_viewType == 1 ? "executionalguillotine" : (_viewType == 2 ? "mercenarybarracks" : (_viewType == 3 ? "alliancebarracks" : (_viewType == 4 ? "friendwatchpost" : "watchpost")))) + ".header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String;
         var _loc5_:String;
         var _loc6_:String;
         var _loc7_:String;
         var _loc2_:String = _viewType == 1 ? (_loc4_ = "ui.windows.executionalguillotine.question",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_viewType == 2 ? (_loc5_ = "ui.windows.mercenarybarracks.subheadernew",peak.i18n.PText.INSTANCE.getText0(_loc5_)) : (_viewType == 3 ? (_loc6_ = "ui.windows.alliancebarracks.subheader",peak.i18n.PText.INSTANCE.getText0(_loc6_)) : (_loc7_ = "ui.windows.friendwatchpost.subheader",peak.i18n.PText.INSTANCE.getText0(_loc7_))));
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         informationSprite = new MobileBackgroundWithLabelView(752,59,_loc2_,_loc1_);
         addChild(informationSprite);
         informationSprite.text = _loc2_;
         _mercenaryViewHolder = new Sprite();
         addChild(_mercenaryViewHolder);
         viewHolderBg = assetRepository.getDisplayObject("MobileBeigeBackground");
         viewHolderBg.width = 762;
         viewHolderBg.height = _viewType == 1 ? 452 : (_viewType == 2 ? 520 : (_viewType == 3 ? 452 : 452));
         _mercenaryViewHolder.addChild(viewHolderBg);
         capacityBg = assetRepository.getDisplayObject("MobileDarkBackground");
         capacityBg.width = _viewType == 1 ? 560 : (_viewType == 2 ? 754 : (_viewType == 3 ? 754 : 754));
         capacityBg.height = 58;
         addChild(capacityBg);
         capacityLabel = new MobileCaptionTextField();
         capacityLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(capacityLabel);
         var _loc8_:String;
         var _loc9_:String;
         var _loc10_:String;
         var _loc11_:String;
         capacityLabel.text = _viewType == 1 ? (_loc8_ = "ui.mainframe.city.tooltip.capacity",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_viewType == 2 ? (_loc9_ = "ui.windows.executionalguillotine.capacitycombined",peak.i18n.PText.INSTANCE.getText0(_loc9_)) : (_viewType == 3 ? (_loc10_ = "ui.mainframe.city.tooltip.capacity",peak.i18n.PText.INSTANCE.getText0(_loc10_)) : (_loc11_ = "ui.mainframe.city.tooltip.capacity",peak.i18n.PText.INSTANCE.getText0(_loc11_))));
         _capacityProgress = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _capacityProgress.width = _viewType == 1 ? 298 : (_viewType == 2 ? 298 : (_viewType == 3 ? 636 : 636));
         _capacityProgress.height = 34;
         _capacityProgress.minimum = 0;
         _capacityProgress.align = "center";
         addChild(_capacityProgress);
         _selectAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         var _temp_9:* = _selectAllButton;
         var _loc12_:String = "ui.windows.executionalguillotine.selectall";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         _selectAllButton.visible = _viewType == 1;
         _selectAllButton.width = 140;
         addChild(_selectAllButton);
         _executeButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         var _temp_11:* = _executeButton;
         var _loc13_:String = "ui.windows.executionalguillotine.execute";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         _executeButton.visible = _viewType == 1;
         _executeButton.width = 175;
         addChild(_executeButton);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         capacityLabel.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(informationSprite,_background,45,45);
         MobileAlignmentUtil.alignAccordingToPositionOf(_mercenaryViewHolder,_background,41,111);
         MobileAlignmentUtil.alignBelowWithXMarginOf(capacityBg,_mercenaryViewHolder,5,8);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(capacityLabel,capacityBg,_viewType == 1 ? 26 : (_viewType == 2 ? 55 : (_viewType == 3 ? 26 : 26)));
         capacityLabel.y += 2;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_capacityProgress,capacityBg,_viewType == 1 ? 106 : (_viewType == 2 ? 385 : (_viewType == 3 ? 106 : 106)));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_selectAllButton,capacityBg,410);
         MobileAlignmentUtil.alignRightWithYMarginOf(_executeButton,capacityBg,1,11);
         if(_mercenaryViews.length > 0)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_mercenaryViews[0],viewHolderBg,_viewType == 1 ? 36 : (_viewType == 2 ? 23 : (_viewType == 3 ? 45 : 45)),_viewType == 1 ? 34 : (_viewType == 2 ? 28 : (_viewType == 3 ? 45 : 45)));
         }
         _loc1_ = 1;
         while(_loc1_ < _mercenaryViews.length)
         {
            if(_loc1_ % 5 == 0)
            {
               MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 5],_viewType == 1 ? 25 : (_viewType == 2 ? 17 : (_viewType == 3 ? 41 : 41)),_mercenaryViews[_loc1_ - 5].visibleHeight);
            }
            else
            {
               MobileAlignmentUtil.alignWidthSpecifiedRightOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 1],_viewType == 1 ? 40 : (_viewType == 2 ? 7 : (_viewType == 3 ? 54 : 54)),_mercenaryViews[_loc1_ - 1].visibleWidth);
            }
            _loc1_++;
         }
      }
      
      public function addMercenaries(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc3_:MobileExecutionalGuillotineMercenaryView = null;
         clearMercenaryViewHolder();
         _mercenaryViews = new Vector.<MobileExecutionalGuillotineMercenaryView>();
         for each(var _loc2_ in param1)
         {
            _loc3_ = new MobileExecutionalGuillotineMercenaryView(_loc2_,_viewType);
            _mercenaryViews.push(_loc3_);
            _mercenaryViewHolder.addChild(_loc3_);
         }
         drawLayout();
      }
      
      private function clearMercenaryViewHolder() : void
      {
         removeChild(_mercenaryViewHolder);
         _mercenaryViewHolder = new Sprite();
         _mercenaryViewHolder.addChild(viewHolderBg);
         addChild(_mercenaryViewHolder);
      }
      
      public function get capacityProgress() : MobileWomProgressBar
      {
         return _capacityProgress;
      }
      
      public function get selectAllButton() : MobileWomButton
      {
         return _selectAllButton;
      }
      
      public function get executeButton() : MobileWomButton
      {
         return _executeButton;
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function get mercenaryViews() : Vector.<MobileExecutionalGuillotineMercenaryView>
      {
         return _mercenaryViews;
      }
      
      public function set capacityProgressBar(param1:MobileWomProgressBar) : void
      {
         _capacityProgress = param1;
      }
      
      public function set capacityStatus(param1:String) : void
      {
         _capacityProgress.label = param1;
      }
   }
}


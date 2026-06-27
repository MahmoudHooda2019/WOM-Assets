package wom.view.screen.windows.tuskhorn
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPProgressBar;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileBackgroundWithLabelView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileTuskHornWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 1468;
      
      private static const WINDOW_HEIGHT:int = 1165;
      
      private var informationSprite:MobileBackgroundWithLabelView;
      
      private var housingProgressBar:MPProgressBar;
      
      private var housingTextField:MPTextField;
      
      private var _clearAllButton:MPButton;
      
      private var _engageCombatButton:MobileWomButton;
      
      private var _capacity:int;
      
      private var _selectedCapacity:int;
      
      private var _price:int;
      
      private var _mercenaryViews:Vector.<MobileTuskHornMercenaryView>;
      
      private var mercenaryViewHolder:Sprite;
      
      public function MobileTuskHornWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(1468 >> 1,1165 >> 1,param1);
         _mercenaryViews = new Vector.<MobileTuskHornMercenaryView>();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc3_:String = "ui.windows.tuskhorn.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String = "ui.windows.tuskhorn.information";
         var _loc2_:String = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         informationSprite = new MobileBackgroundWithLabelView(637,51,_loc2_,_loc1_);
         addChild(informationSprite);
         informationSprite.drawLayout();
         housingProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         housingProgressBar.width = 559;
         housingProgressBar.minimum = 0;
         addChild(housingProgressBar);
         housingTextField = new MobileCaptionTextField();
         housingTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(housingTextField);
         _clearAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         var _temp_6:* = _clearAllButton;
         var _loc5_:String = "ui.windows.tuskhorn.clearall";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _clearAllButton.width = 255;
         addChild(_clearAllButton);
         _engageCombatButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_8:* = _engageCombatButton;
         var _loc6_:String = "ui.windows.tuskhorn.engagecombat";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _engageCombatButton.width = 304;
         _engageCombatButton.defaultIcon = assetRepository.getDisplayObject("IconMightM");
         _engageCombatButton.rightLabel = NumberUtil.prettyFormat(_price,null,null,null,3,6) + "";
         addChild(_engageCombatButton);
         mercenaryViewHolder = new Sprite();
         addChild(mercenaryViewHolder);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(informationSprite,_background,46,32);
         MobileAlignmentUtil.alignAccordingToPositionOf(housingProgressBar,_background,88,477);
         MobileAlignmentUtil.alignAccordingToPositionOf(_clearAllButton,_background,85,(1165 >> 1) - 50);
         MobileAlignmentUtil.alignRightOf(_engageCombatButton,_clearAllButton,8);
         MobileAlignmentUtil.alignMiddleOf(housingTextField,housingProgressBar);
         mercenaryViewHolder.x = 42;
         mercenaryViewHolder.y = 101;
         _loc1_ = 1;
         while(_loc1_ < _mercenaryViews.length)
         {
            if(_loc1_ % 5 == 0)
            {
               MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 5],30,_mercenaryViews[_loc1_ - 5].visibleHeight);
            }
            else
            {
               MobileAlignmentUtil.alignWidthSpecifiedRightOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 1],35,_mercenaryViews[_loc1_ - 1].visibleWidth);
            }
            _loc1_++;
         }
      }
      
      public function get mercenaryViews() : Vector.<MobileTuskHornMercenaryView>
      {
         return _mercenaryViews;
      }
      
      public function updateSpaceStatus(param1:int) : void
      {
         _selectedCapacity = param1;
         housingProgressBar.value = param1;
         var _temp_4:* = housingTextField;
         var _temp_3:* = "ui.windows.tuskhorn.capacity";
         var _temp_2:* = NumberUtil.prettyFormat(param1);
         var _loc2_:String = NumberUtil.prettyFormat(_capacity);
         var _loc3_:String = _temp_2;
         var _loc4_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_);
         drawLayout();
      }
      
      public function get clearAllButton() : MPButton
      {
         return _clearAllButton;
      }
      
      public function get engageCombatButton() : MPButton
      {
         return _engageCombatButton;
      }
      
      public function get capacity() : int
      {
         return _capacity;
      }
      
      public function set capacity(param1:int) : void
      {
         _capacity = param1;
         housingProgressBar.maximum = _capacity;
      }
      
      public function get selectedCapacity() : int
      {
         return _selectedCapacity;
      }
      
      public function set price(param1:int) : void
      {
         _price = param1;
         _engageCombatButton.rightLabel = NumberUtil.prettyFormat(_price,null,null,null,3,6) + "";
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function addMercenaries(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc3_:MobileTuskHornMercenaryView = null;
         if(_mercenaryViews.length == 0)
         {
            _mercenaryViews = new Vector.<MobileTuskHornMercenaryView>();
            for each(var _loc2_ in param1)
            {
               _loc3_ = new MobileTuskHornMercenaryView(_loc2_);
               _mercenaryViews.push(_loc3_);
               mercenaryViewHolder.addChild(_loc3_);
            }
            drawLayout();
         }
      }
   }
}


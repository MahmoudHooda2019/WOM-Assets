package wom.view.screen.popups.npcattack.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.npcattack.MobileNPCAttackPopupBatchView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileNPCAttackPopup extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 751;
      
      private static const WINDOW_HEIGHT:int = 385;
      
      public static const VISIBLE_COUNT:int = 6;
      
      private var backgroundAsset:DisplayObject;
      
      private var mercenaryAsset:DisplayObject;
      
      private var _npcName:String;
      
      private var _unitTypeAmountDictionary:Vector.<UnitTypeAmountDTO>;
      
      private var _batchViews:Vector.<MobileNPCAttackPopupBatchView>;
      
      private var _prepareDefensesButton:MPButton;
      
      private var _engageAttackButton:MPButton;
      
      private var _skipButton:MobileWomButton;
      
      public function MobileNPCAttackPopup(param1:String, param2:Vector.<UnitTypeAmountDTO>)
      {
         super(751,385,null,false);
         _npcName = param1;
         _unitTypeAmountDictionary = param2;
      }
      
      override protected function initLayout() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:MobileNPCAttackPopupBatchView = null;
         super.initLayout();
         var _loc7_:String = "ui.popups.npcattack.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         backgroundAsset = assetRepository.getDisplayObject("NPCAttackBackground");
         addChild(backgroundAsset);
         if(_npcName == "NPC_1")
         {
            var _loc8_:String = "domain.npcs.1.name";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            _loc3_ = "ShriekingDragonClan";
         }
         else if(_npcName == "NPC_2")
         {
            var _loc9_:String = "domain.npcs.2.name";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            _loc3_ = "RagingBullClan";
         }
         else if(_npcName == "NPC_3")
         {
            var _loc10_:String = "domain.npcs.3.name";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            _loc3_ = "DemonKingClan";
         }
         else if(_npcName == "NPC_4")
         {
            var _loc11_:String = "domain.npcs.4.name";
            _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            _loc3_ = "IronHandClan";
         }
         _batchViews = new Vector.<MobileNPCAttackPopupBatchView>();
         for each(var _loc1_ in _unitTypeAmountDictionary)
         {
            _loc4_ = new MobileNPCAttackPopupBatchView(_loc1_);
            _batchViews.push(_loc4_);
            addChild(_loc4_);
         }
         _prepareDefensesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _prepareDefensesButton.width = 210;
         var _temp_5:* = _prepareDefensesButton;
         var _loc12_:String = "ui.popups.npcattack.preparedefenses2";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         addChild(_prepareDefensesButton);
         _engageAttackButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _engageAttackButton.width = 190;
         var _temp_7:* = _engageAttackButton;
         var _loc13_:String = "ui.popups.npcattack.engageattack2";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         addChild(_engageAttackButton);
         _skipButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _skipButton.width = 250;
         var _temp_9:* = _skipButton;
         var _loc14_:String = "ui.popups.npcattack.skip";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         _skipButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _skipButton.rightLabel = "10";
         addChild(_skipButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MobileNPCAttackPopupBatchView = null;
         MobileAlignmentUtil.alignMiddleOf(backgroundAsset,_background);
         _loc2_ = 0;
         while(_loc2_ < _batchViews.length)
         {
            _loc1_ = _batchViews[_loc2_];
            if(_loc2_ >= 6)
            {
               _loc1_.visible = false;
            }
            else if(_loc2_ == 0)
            {
               _loc1_.visible = true;
               _loc1_.x = 380;
               _loc1_.y = 75;
            }
            else if(_loc2_ % 3 == 0)
            {
               _loc1_.visible = true;
               MobileAlignmentUtil.alignBelowOf(_loc1_,_batchViews[_loc2_ - 3],20);
            }
            else
            {
               _loc1_.visible = true;
               MobileAlignmentUtil.alignRightOf(_loc1_,_batchViews[_loc2_ - 1],20);
            }
            _loc2_++;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_prepareDefensesButton,_background,35,323);
         MobileAlignmentUtil.alignRightOf(_engageAttackButton,_prepareDefensesButton,15);
         MobileAlignmentUtil.alignRightOf(_skipButton,_engageAttackButton,15);
      }
      
      public function get prepareDefensesButton() : MPButton
      {
         return _prepareDefensesButton;
      }
      
      public function get engageAttackButton() : MPButton
      {
         return _engageAttackButton;
      }
      
      public function get skipButton() : MobileWomButton
      {
         return _skipButton;
      }
   }
}


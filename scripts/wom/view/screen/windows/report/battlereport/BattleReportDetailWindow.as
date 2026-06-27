package wom.view.screen.windows.report.battlereport
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.game.report.battlereport.BattleReportLog;
   import wom.model.game.report.battlereport.PartLootedLog;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomScrollPane;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.ResourceGroupView;
   import wom.view.util.GenericWindow;
   
   public class BattleReportDetailWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 568;
      
      private static const WINDOW_HEIGHT:int = 526;
      
      private var _attackLogId:Number;
      
      private var _attackStartInMillis:Number;
      
      private var _battleReportViews:Vector.<BattleReportDetailView>;
      
      private var _damageReportView:BaseBattleReportView;
      
      private var _damageInflictedView:BaseBattleReportView;
      
      private var _scrollPane:WomScrollPane;
      
      private var _scrollPaneContent:Sprite;
      
      private var _lootedResourcesBackground:DisplayObject;
      
      private var _lootedResourcesLabel:TextField;
      
      private var _lootedResourcesView:ResourceGroupView;
      
      private var _opponentIdLabel:TextField;
      
      private var _opponentIdTF:TextField;
      
      private var _backButton:Button;
      
      private var _afterAttack:Boolean;
      
      public function BattleReportDetailWindow(param1:Number, param2:Number, param3:Boolean, param4:Vector.<WindowEnumeration> = null, param5:int = 568, param6:int = 526)
      {
         super(param5,param6,param4);
         _attackLogId = param1;
         _attackStartInMillis = param2;
         _afterAttack = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.battlereport.title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _battleReportViews = new Vector.<BattleReportDetailView>();
         _scrollPane = new WomScrollPane();
         _scrollPane.width = 568 - 44;
         _scrollPane.height = 278;
         _scrollPane.verticalScrollPolicy = "on";
         addChild(_scrollPane);
         _scrollPaneContent = new Sprite();
         _lootedResourcesBackground = assetRepository.getDisplayObject("BackgroundLight");
         addChild(_lootedResourcesBackground);
         _lootedResourcesLabel = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _lootedResourcesLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _lootedResourcesLabel.autoSize = "left";
         addChild(_lootedResourcesLabel);
         var _temp_7:* = _lootedResourcesLabel;
         var _loc2_:String = "ui.windows.battlereport.resourceslooted";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _lootedResourcesView = new ResourceGroupView(true,0);
         addChild(_lootedResourcesView);
         _backButton = new WomBlueLargeButton();
         _backButton.width = 169;
         var _loc3_:String;
         var _loc4_:String;
         _backButton.label = windowEnumerations == null || windowEnumerations.length <= 0 ? (_loc3_ = "ui.windows.battlereport.gohome",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : (_loc4_ = "ui.windows.battlereport.dismiss",peak.i18n.PText.INSTANCE.getText0(_loc4_));
         addChild(_backButton);
         _opponentIdLabel = new WomTextField();
         _opponentIdLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _opponentIdLabel.autoSize = "left";
         var _temp_12:* = _opponentIdLabel;
         var _loc5_:String = "ui.windows.battlereport.opponentid";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_opponentIdLabel);
         _opponentIdTF = new WomTextField(true);
         _opponentIdTF.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _opponentIdTF.autoSize = "left";
         addChild(_opponentIdTF);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _scrollPane.height = _damageReportView ? (_damageReportView.visible ? 246 : 278) : 278;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_scrollPane,_background,43);
         if(_battleReportViews.length > 0)
         {
            _battleReportViews[0].x = _battleReportViews[0].y = 0;
            _loc1_ = 1;
            while(_loc1_ < _battleReportViews.length)
            {
               AlignmentUtil.alignBelowOf(_battleReportViews[_loc1_],_battleReportViews[_loc1_ - 1],0);
               _loc1_++;
            }
         }
         _scrollPane.source = _scrollPaneContent;
         if(_damageReportView && _damageReportView.visible)
         {
            AlignmentUtil.alignBelowOf(_damageReportView,_scrollPane,0);
            if(_damageInflictedView)
            {
               AlignmentUtil.alignBelowOf(_damageInflictedView,_damageReportView,0);
            }
         }
         else if(_damageInflictedView)
         {
            AlignmentUtil.alignBelowOf(_damageInflictedView,_scrollPane,0);
         }
         _lootedResourcesBackground.width = _lootedResourcesView.width + 32;
         _lootedResourcesBackground.height = _lootedResourcesView.height + 40;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_lootedResourcesBackground,_background,369);
         AlignmentUtil.alignAccordingToPositionOf(_lootedResourcesLabel,_lootedResourcesBackground,20,-8);
         AlignmentUtil.alignMiddleOf(_lootedResourcesView,_lootedResourcesBackground);
         AlignmentUtil.alignAccordingToPositionOf(_opponentIdLabel,_background,18,480);
         AlignmentUtil.alignBelowOf(_opponentIdTF,_opponentIdLabel,-3);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_backButton,_background,483);
      }
      
      public function battleReportUpdated(param1:BattleReport) : void
      {
         var _loc3_:BattleReportDetailView = null;
         var _loc5_:int = 0;
         var _loc2_:BattleReportLog = null;
         if(!isNaN(param1.opponentGuid))
         {
            _opponentIdTF.text = param1.opponentGuid.toString();
            _opponentIdLabel.visible = _opponentIdTF.visible = true;
         }
         else
         {
            _opponentIdLabel.visible = _opponentIdTF.visible = false;
         }
         clearAll();
         for each(var _loc4_ in param1.lootedParts)
         {
            _loc3_ = new BattleReportDetailView(new PartLootedLog(666,_attackStartInMillis,_loc4_));
            _scrollPaneContent.addChild(_loc3_);
            _battleReportViews.push(_loc3_);
         }
         _loc5_ = 0;
         while(_loc5_ < param1.battleReportLogs.length)
         {
            _loc2_ = param1.battleReportLogs[_loc5_];
            _loc3_ = new BattleReportDetailView(_loc2_);
            _scrollPaneContent.addChild(_loc3_);
            _battleReportViews.push(_loc3_);
            _loc5_++;
         }
         var _temp_3:* = §§findproperty(BaseBattleReportView);
         var _temp_2:* = "";
         var _temp_1:* = "ui.windows.battlereport.totaldamage";
         var _loc9_:String = (100 - param1.totalDamagePercentage).toString();
         var _loc10_:String = _temp_1;
         _damageReportView = new BaseBattleReportView(_temp_2,peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_),0,true);
         _damageReportView.visible = param1.totalDamagePercentage >= 0;
         addChild(_damageReportView);
         var _temp_7:* = §§findproperty(BaseBattleReportView);
         var _temp_6:* = "";
         var _temp_5:* = "ui.windows.battlereport.damageinflicted";
         var _loc11_:String = param1.lastBattleDamagePercentage.toString();
         var _loc12_:String = _temp_5;
         _damageInflictedView = new BaseBattleReportView(_temp_6,peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_),0,true);
         _damageInflictedView.visible = param1.totalDamagePercentage >= 0;
         addChild(_damageInflictedView);
         _lootedResourcesView.updateWithResources(param1.lootedResources);
         drawLayout();
      }
      
      private function clearAll() : void
      {
         for each(var _loc1_ in _battleReportViews)
         {
            if(_scrollPaneContent.contains(_loc1_))
            {
               _scrollPaneContent.removeChild(_loc1_);
            }
         }
         _battleReportViews.length = 0;
      }
      
      public function get attackLogId() : Number
      {
         return _attackLogId;
      }
      
      public function get backButton() : Button
      {
         return _backButton;
      }
      
      public function get afterAttack() : Boolean
      {
         return _afterAttack;
      }
   }
}


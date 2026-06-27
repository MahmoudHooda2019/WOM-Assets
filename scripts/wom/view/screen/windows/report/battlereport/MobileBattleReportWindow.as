package wom.view.screen.windows.report.battlereport
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import wom.model.game.Profile;
   import wom.model.game.report.AttackLog;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBattleReportWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 628;
      
      private static const WINDOW_HEIGHT:int = 621;
      
      private var _resourceViewBackground:DisplayObject;
      
      private var _lootedResourcesView:MobileResourceGroupView;
      
      private var _lootedResourcesLabel:MPTextField;
      
      private var _actionButton:MPButton;
      
      private var _reportDetailView:MobileBattleReportDetailView;
      
      private var _reportGeneralView:MobileBattleReportGeneralInfoView;
      
      private var _infoButton:MPRigidButton;
      
      private var _attackLogId:Number;
      
      private var _attackStartInMillis:Number;
      
      private var _afterAttack:Boolean;
      
      private var _attacker:Profile;
      
      private var _defender:Profile;
      
      private var _battleReport:BattleReport;
      
      private var _attackLog:AttackLog;
      
      private var _isReportGeneralViewVisible:Boolean;
      
      public function MobileBattleReportWindow(param1:Number, param2:Number, param3:Boolean, param4:Profile = null, param5:Profile = null, param6:Vector.<WindowEnumeration> = null, param7:int = 628, param8:int = 621)
      {
         super(param7,param8,param6);
         _attackLogId = param1;
         _attackStartInMillis = param2;
         _afterAttack = param3;
         _attacker = param4;
         _defender = param5;
         _isReportGeneralViewVisible = true;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.battlereport.title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _resourceViewBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         _resourceViewBackground.width = 459;
         _resourceViewBackground.height = 115;
         addChild(_resourceViewBackground);
         _lootedResourcesLabel = new MobileCaptionTextField();
         _lootedResourcesLabel.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_lootedResourcesLabel);
         var _temp_4:* = _lootedResourcesLabel;
         var _loc2_:String = "ui.windows.battlereport.resourceslooted";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _lootedResourcesView = new MobileResourceGroupView(true);
         addChild(_lootedResourcesView);
         _reportGeneralView = new MobileBattleReportGeneralInfoView();
         addChild(_reportGeneralView);
         _infoButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         addChild(_infoButton);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 300;
         addChild(_actionButton);
         var _temp_9:* = _actionButton;
         var _loc3_:String = "ui.windows.battlereport.dismiss";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_reportDetailView)
         {
            _reportDetailView.x = 27;
            _reportDetailView.y = 27;
         }
         if(_reportGeneralView)
         {
            _reportGeneralView.x = 27;
            _reportGeneralView.y = 27;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_infoButton,_reportGeneralView);
         _infoButton.x -= _infoButton.width >> 1;
         _infoButton.y -= _infoButton.height >> 1;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_resourceViewBackground,_background,442);
         MobileAlignmentUtil.alignAccordingToPositionOf(_lootedResourcesLabel,_resourceViewBackground,19,-(_lootedResourcesLabel.height / 2));
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_lootedResourcesView,_resourceViewBackground,21);
         if(contains(_actionButton))
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2 - 6);
         }
      }
      
      public function battleReportUpdated(param1:BattleReport, param2:AttackLog, param3:String, param4:String, param5:Boolean) : void
      {
         _battleReport = param1;
         _attackLog = param2;
         _defender = param2.defender;
         _attacker = param2.attacker;
         _reportGeneralView.battleReportUpdated(_battleReport,_attackLog,param3,param4,param5);
         _lootedResourcesView.updateWithResources(param1.lootedResources);
         drawLayout();
      }
      
      public function generateCaps() : BitmapData
      {
         _actionButton.visible = false;
         _infoButton.visible = false;
         _closeButton.visible = false;
         var _loc2_:Rectangle = new Rectangle();
         getBounds(this,_loc2_);
         var _loc5_:Stage = Starling.current.stage;
         var _loc4_:RenderSupport = new RenderSupport();
         var _loc1_:Number = Starling.contentScaleFactor;
         _loc4_.clear();
         _loc4_.scaleMatrix(1,1);
         _loc4_.setOrthographicProjection(0,0,_loc5_.stageWidth,_loc5_.stageHeight);
         _loc4_.translateMatrix(-_loc2_.x,-_loc2_.y + 100);
         render(_loc4_,1);
         _loc4_.finishQuadBatch();
         var _loc3_:BitmapData = new BitmapData(_loc2_.width * _loc1_,_loc2_.height * _loc1_,true);
         Starling.context.drawToBitmapData(_loc3_);
         _actionButton.visible = true;
         _infoButton.visible = true;
         _closeButton.visible = true;
         return _loc3_;
      }
      
      public function get attackLogId() : Number
      {
         return _attackLogId;
      }
      
      public function get afterAttack() : Boolean
      {
         return _afterAttack;
      }
      
      public function get actionButton() : MPButton
      {
         return _actionButton;
      }
      
      public function get infoButton() : MPButton
      {
         return _infoButton;
      }
      
      public function get reportGeneralView() : MobileBattleReportGeneralInfoView
      {
         return _reportGeneralView;
      }
      
      public function get reportDetailView() : MobileBattleReportDetailView
      {
         return _reportDetailView;
      }
      
      public function set reportDetailView(param1:MobileBattleReportDetailView) : void
      {
         _reportDetailView = param1;
      }
      
      public function toggleViews() : void
      {
         _reportGeneralView.visible = _isReportGeneralViewVisible;
         _reportDetailView.visible = !_isReportGeneralViewVisible;
      }
      
      public function get battleReport() : BattleReport
      {
         return _battleReport;
      }
      
      public function get attackStartInMillis() : Number
      {
         return _attackStartInMillis;
      }
      
      public function get isReportGeneralViewVisible() : Boolean
      {
         return _isReportGeneralViewVisible;
      }
      
      public function set isReportGeneralViewVisible(param1:Boolean) : void
      {
         _isReportGeneralViewVisible = param1;
      }
      
      public function get attacker() : Profile
      {
         return _attacker;
      }
      
      public function get defender() : Profile
      {
         return _defender;
      }
   }
}


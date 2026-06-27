package wom.view.screen.windows.report.attacklog.mobile
{
   import feathers.controls.List;
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import peak.component.mobile.MPList;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.report.AttackLog;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileAttackLogPanel extends Sprite
   {
      
      private static const WIDTH:int = 999;
      
      private static const HEIGHT:int = 586;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _attackerMe:Boolean;
      
      private var _defenderMe:Boolean;
      
      private var _attackLogs:Vector.<AttackLog>;
      
      private var _attackLogsList:MPList;
      
      private var _background:DisplayObject;
      
      private var _userGameId:String;
      
      public function MobileAttackLogPanel(param1:String, param2:Boolean = true, param3:Boolean = true, param4:int = 999, param5:int = 586)
      {
         super();
         _userGameId = param1;
         _attackerMe = param2;
         _defenderMe = param3;
         _width = param4;
         _height = param5;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("MobileDarkBackground");
         _background.width = _width;
         _background.height = _height;
         addChild(_background);
         createAndAddLogList();
         drawLayout();
      }
      
      private function createAndAddLogList() : void
      {
         _attackLogsList = new MPList();
         _attackLogsList.itemRendererFactory = _attackerMe ? attackerRendererFactory : defenderRendererFactory;
         _attackLogsList.y = 25;
         _attackLogsList.height = _height - 40;
         _attackLogsList.width = 971;
         addChild(_attackLogsList);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_attackLogsList,_background,25);
      }
      
      public function attackLogsUpdated(param1:Vector.<AttackLog>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AttackLog = null;
         if(_attackLogs != null)
         {
            _attackLogs.length = 0;
         }
         else
         {
            _attackLogs = new Vector.<AttackLog>();
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            if(_attackerMe && _loc2_.attacker.gameId == _userGameId || _defenderMe && _loc2_.defender.gameId == _userGameId)
            {
               _attackLogs.push(_loc2_);
            }
            _loc3_++;
         }
         _attackLogsList.dataProvider = new ListCollection(_attackLogs);
         _attackLogsList.validate();
      }
      
      public function recreateAttackLogList() : void
      {
         if(_attackLogsList && contains(_attackLogsList))
         {
            removeChild(_attackLogsList);
         }
         createAndAddLogList();
         drawLayout();
      }
      
      private function attackerRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileAttackLogViewRenderer = new MobileAttackLogViewRenderer(assetRepository,true);
         _loc1_.width = 971;
         _loc1_.height = 121;
         return _loc1_;
      }
      
      private function defenderRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileAttackLogViewRenderer = new MobileAttackLogViewRenderer(assetRepository,false);
         _loc1_.width = 971;
         _loc1_.height = 121;
         return _loc1_;
      }
      
      public function get attackLogsList() : List
      {
         return _attackLogsList;
      }
   }
}


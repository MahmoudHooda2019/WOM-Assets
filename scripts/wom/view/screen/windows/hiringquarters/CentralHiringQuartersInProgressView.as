package wom.view.screen.windows.hiringquarters
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import wom.model.resource.WomAssetRepository;
   
   public class CentralHiringQuartersInProgressView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _closeIcon:DisplayObject;
      
      private var mercenaryAsset:String;
      
      private var _buildingInstanceId:int;
      
      private var _dontAskForOverflow:Boolean = false;
      
      public function CentralHiringQuartersInProgressView(param1:String, param2:int, param3:Boolean = false)
      {
         super();
         this.mercenaryAsset = param1;
         _buildingInstanceId = param2;
         _dontAskForOverflow = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:DisplayObject = assetRepository.getDisplayObject(mercenaryAsset);
         addChild(_loc1_);
         _closeIcon = assetRepository.getDisplayObject("HiringQuartersCancel2");
         _closeIcon.visible = false;
         addChild(_closeIcon);
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get closeIcon() : DisplayObject
      {
         return _closeIcon;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function set buildingInstanceId(param1:int) : void
      {
         _buildingInstanceId = param1;
      }
      
      public function get dontAskForOverflow() : Boolean
      {
         return _dontAskForOverflow;
      }
      
      public function set dontAskForOverflow(param1:Boolean) : void
      {
         _dontAskForOverflow = param1;
      }
   }
}


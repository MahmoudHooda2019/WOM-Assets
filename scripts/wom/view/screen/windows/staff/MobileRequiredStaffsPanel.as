package wom.view.screen.windows.staff
{
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileRequiredStaffsPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _staffViewList:Vector.<MobileRequiredStaffView>;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _staffPrerequisites:Vector.<StaffDIO>;
      
      private var _staffs:Vector.<StaffInfo>;
      
      private var _timeReductionsPerStaff:Vector.<int>;
      
      public function MobileRequiredStaffsPanel()
      {
         super();
         _staffPrerequisites = new Vector.<StaffDIO>();
         _staffs = new Vector.<StaffInfo>();
         _staffViewList = new Vector.<MobileRequiredStaffView>();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in _staffViewList)
         {
            _loc1_.x = _loc2_;
            _loc2_ += 194;
         }
      }
      
      private function clearAll() : void
      {
         for each(var _loc1_ in _staffViewList)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _staffViewList.length = 0;
      }
      
      public function updateWithStaffList(param1:BuildingInfo, param2:Vector.<StaffDIO>, param3:Vector.<StaffInfo>, param4:Vector.<Vector.<int>>) : void
      {
         _buildingInfo = param1;
         _staffPrerequisites = param2;
         _staffs = param3;
         _timeReductionsPerStaff = param4[param1.level];
         update();
      }
      
      public function update() : void
      {
         var _loc4_:int = 0;
         var _loc1_:StaffInfo = null;
         var _loc3_:MobileRequiredStaffView = null;
         clearAll();
         _loc4_ = 0;
         while(_loc4_ < _staffPrerequisites.length)
         {
            _loc1_ = null;
            for each(var _loc2_ in _staffs)
            {
               if(_staffPrerequisites[_loc4_].id == _loc2_.staffId)
               {
                  _loc1_ = _loc2_;
                  break;
               }
            }
            _loc3_ = new MobileRequiredStaffView(_buildingInfo.instanceId,_staffPrerequisites[_loc4_],_loc1_,_timeReductionsPerStaff[_loc4_]);
            addChild(_loc3_);
            _staffViewList.push(_loc3_);
            _loc4_++;
         }
         drawLayout();
      }
   }
}


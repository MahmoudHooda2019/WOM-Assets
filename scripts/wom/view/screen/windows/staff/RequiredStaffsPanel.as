package wom.view.screen.windows.staff
{
   import flash.display.DisplayObject;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.view.util.PagingPanel;
   
   public class RequiredStaffsPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 582;
      
      private static const HEIGHT:int = 244;
      
      private static const VIEWS_PER_ROW:int = 4;
      
      private var _staffViewList:Vector.<RequiredStaffView>;
      
      private var _staffArrows:Vector.<DisplayObject>;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _staffPrerequisites:Vector.<StaffDIO>;
      
      private var _staffs:Vector.<StaffInfo>;
      
      private var _timeReductionsPerStaff:Vector.<int>;
      
      public function RequiredStaffsPanel()
      {
         super(582,244,1,4);
         _staffPrerequisites = new Vector.<StaffDIO>();
         _staffs = new Vector.<StaffInfo>();
         _staffViewList = new Vector.<RequiredStaffView>();
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _timeReductionsPerStaff = new Vector.<int>();
         _staffArrows = new Vector.<DisplayObject>();
         update(currentPageNumber);
      }
      
      override public function drawLayout() : void
      {
         var _loc2_:RequiredStaffView = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc1_:DisplayObject = null;
         updateBackground(582,244);
         _loc4_ = 0;
         while(_loc4_ < _staffViewList.length)
         {
            _loc2_ = _staffViewList[_loc4_];
            if(_loc4_ == 0)
            {
               _staffViewList[_loc4_].x = 20;
               _staffViewList[_loc4_].y = 20;
            }
            else if(_loc4_ == _columnCount)
            {
               AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_loc2_,_staffViewList[0],185);
            }
            else
            {
               AlignmentUtil.alignRightOf(_loc2_,_loc3_,18);
            }
            if(_loc4_ < _staffArrows.length)
            {
               _loc1_ = _staffArrows[_loc4_];
               AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc1_,_loc2_,_loc2_.width + int((20 - _loc1_.width) / 2));
               _loc1_.y -= 5;
            }
            _loc3_ = _loc2_;
            _loc4_++;
         }
         super.drawLayout();
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
         for each(var _loc2_ in _staffArrows)
         {
            if(contains(_loc2_))
            {
               removeChild(_loc2_);
            }
         }
         _staffArrows.length = 0;
      }
      
      public function updateWithStaffList(param1:BuildingInfo, param2:Vector.<StaffDIO>, param3:Vector.<StaffInfo>, param4:Vector.<Vector.<int>>) : void
      {
         _buildingInfo = param1;
         _staffPrerequisites = param2;
         _staffs = param3;
         _timeReductionsPerStaff = param4[param1.level];
         checkPageFull(_currentPageNumber);
      }
      
      public function update(param1:int) : void
      {
         var _loc8_:int = 0;
         var _loc2_:StaffInfo = null;
         var _loc6_:RequiredStaffView = null;
         var _loc5_:AssetDisplayObject = null;
         _currentPageNumber = param1;
         clearAll();
         var _loc7_:int = itemCountPerPage();
         var _loc4_:int;
         _loc8_ = _loc4_ = _currentPageNumber * _loc7_;
         while(_loc8_ < _loc4_ + _loc7_ && _loc8_ < _staffPrerequisites.length)
         {
            _loc2_ = null;
            for each(var _loc3_ in _staffs)
            {
               if(_staffPrerequisites[_loc8_].id == _loc3_.staffId)
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
            _loc6_ = new RequiredStaffView(_buildingInfo.instanceId,_staffPrerequisites[_loc8_],_loc2_,_timeReductionsPerStaff[_loc8_ - _loc4_]);
            addChild(_loc6_);
            _staffViewList.push(_loc6_);
            if(_loc8_ < _loc4_ + _loc7_ - 1 && _loc8_ < _staffPrerequisites.length - 1)
            {
               _loc5_ = assetRepository.getDisplayObject("ArrowStep");
               addChild(_loc5_);
               _staffArrows.push(_loc5_);
            }
            _loc8_++;
         }
         setPagingButtonsVisibility(_staffPrerequisites.length);
         drawLayout();
      }
      
      public function checkPageFull(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = itemCountPerPage();
         var _loc3_:Boolean = false;
         _loc6_ = param1 * _loc5_;
         while(_loc6_ < param1 * _loc5_ + _loc5_ && _loc6_ < _staffPrerequisites.length)
         {
            _loc4_ = true;
            for each(var _loc2_ in _staffs)
            {
               if(_staffPrerequisites[_loc6_].id == _loc2_.staffId)
               {
                  _loc4_ = false;
                  break;
               }
            }
            if(_loc4_)
            {
               _loc3_ = true;
               break;
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            update(param1);
         }
         else if((param1 + 1) * itemCountPerPage() > _staffPrerequisites.length)
         {
            update(0);
         }
         else
         {
            checkPageFull(param1 + 1);
         }
      }
   }
}


package wom.view.screen.windows.recruitmentchamber
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomCarousel;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileRecruitmentChamberWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 831;
      
      private static const WINDOW_HEIGHT:int = 623;
      
      private var _buildingInstanceId:int;
      
      private var _serverSpeed:int;
      
      private var _mercenaryList:MobileWomCarousel;
      
      private var unlockedButton:MPButton;
      
      private var _startButton:MPButton;
      
      private var _recruitButton:MobileWomButton;
      
      private var _stopButton:MPButton;
      
      private var _finishNowButton:MobileWomButton;
      
      private var _speedUpButton:MobileWomButton;
      
      private var _anyRecruitingJobExist:Boolean;
      
      private var _currentlyRecruitingUnitTypeId:int;
      
      private var _initialUnitTypeId:int;
      
      private var allRecruitsDone:Boolean;
      
      private var possibleRecruitmentUnitId:int;
      
      private var _unitIDtoIndexMap:Dictionary;
      
      public function MobileRecruitmentChamberWindow(param1:int, param2:int, param3:int = -1, param4:Vector.<WindowEnumeration> = null)
      {
         super(831,623,param4);
         _buildingInstanceId = param1;
         _serverSpeed = param2;
         _initialUnitTypeId = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.recruitmentchamber.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _mercenaryList = MobileWomUIComponentFactory.createCarousel("horizontal",227,358,514);
         _mercenaryList.itemRendererFactory = recruitmentChamberRendererFactory;
         _mercenaryList.width = 831 - 34;
         _mercenaryList.height = 514;
         addChild(_mercenaryList);
         unlockedButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         unlockedButton.width = 250;
         var _temp_4:* = unlockedButton;
         var _loc2_:String = "ui.windows.recruitmentchamber.unlocked";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         unlockedButton.isEnabled = false;
         addChild(unlockedButton);
         _startButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _startButton.width = 196;
         var _temp_6:* = _startButton;
         var _loc3_:String = "m.ui.windows.recruitmentchamber.start";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_startButton);
         _recruitButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _recruitButton.width = 352;
         _recruitButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         var _temp_8:* = _recruitButton;
         var _loc4_:String = "m.ui.windows.recruitmentchamber.recruit";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _recruitButton.rightLabel = " ";
         addChild(_recruitButton);
         _stopButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _stopButton.width = 109;
         var _temp_10:* = _stopButton;
         var _loc5_:String = "ui.windows.recruitmentchamber.stop";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_stopButton);
         _finishNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _finishNowButton.width = 393;
         _finishNowButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         var _temp_12:* = _finishNowButton;
         var _loc6_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _finishNowButton.rightLabel = " ";
         addChild(_finishNowButton);
         _speedUpButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _speedUpButton.width = 211;
         _speedUpButton.defaultIcon = assetRepository.getDisplayObject("IconRPM");
         var _temp_14:* = _speedUpButton;
         var _loc7_:String = "ui.windows.constructionsite.cutdurationwithrp";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _speedUpButton.rightLabel = "30";
         addChild(_speedUpButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_mercenaryList,_background,41);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(unlockedButton,_background,623 - 55);
         MobileAlignmentUtil.alignAccordingToPositionOf(_stopButton,_background,48,623 - 44);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_finishNowButton,_stopButton,118);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_speedUpButton,_finishNowButton,403);
         MobileAlignmentUtil.alignAccordingToPositionOf(_startButton,_background,136,623 - 55);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_recruitButton,_startButton,209);
      }
      
      private function recruitmentChamberRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileRecruitmentChamberItemViewRenderer = new MobileRecruitmentChamberItemViewRenderer(assetRepository);
         _loc1_.width = 358;
         _loc1_.height = 514;
         return _loc1_;
      }
      
      public function get mercenaryList() : MobileWomCarousel
      {
         return _mercenaryList;
      }
      
      public function fillUnits(param1:Vector.<UnitTypeDIO>, param2:Dictionary) : void
      {
         _unitIDtoIndexMap = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         for each(var _loc3_ in param1)
         {
            _unitIDtoIndexMap[_loc3_.id] = _loc5_;
            _loc4_.push({
               "unitTypeDIO":_loc3_,
               "unitTypeInfo":param2[_loc3_.id],
               "serverSpeed":_serverSpeed,
               "showMercenaryView":true
            });
            _loc5_++;
         }
         _mercenaryList.dataProvider = new ListCollection(_loc4_);
         updateButtons();
         updateRecruitingJobExistance(param2,param1);
      }
      
      public function updateRecruitingUnitProgress(param1:Dictionary, param2:Vector.<UnitTypeDIO>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         var _loc3_:UnitTypeInfo = null;
         if(_anyRecruitingJobExist)
         {
            _loc5_ = int(_unitIDtoIndexMap[_currentlyRecruitingUnitTypeId]);
            _loc4_ = Boolean(_mercenaryList.dataProvider.getItemAt(_loc5_).showMercenaryView);
            _loc3_ = param1[_currentlyRecruitingUnitTypeId];
            _mercenaryList.dataProvider.setItemAt({
               "unitTypeDIO":param2[_loc5_],
               "unitTypeInfo":_loc3_,
               "serverSpeed":_serverSpeed,
               "showMercenaryView":_loc4_,
               "chamberLevel":-1,
               "cityMightAmount":-1
            },_loc5_);
         }
      }
      
      public function updateUnits(param1:Dictionary, param2:Vector.<UnitTypeDIO>, param3:int, param4:Number) : void
      {
         var _loc8_:Boolean = false;
         var _loc7_:UnitTypeInfo = null;
         var _loc6_:int = 0;
         for each(var _loc5_ in param2)
         {
            _loc8_ = Boolean(_mercenaryList.dataProvider.getItemAt(_loc6_).showMercenaryView);
            _loc7_ = param1[_loc5_.id];
            _mercenaryList.dataProvider.setItemAt({
               "unitTypeDIO":_loc5_,
               "unitTypeInfo":_loc7_,
               "serverSpeed":_serverSpeed,
               "showMercenaryView":_loc8_,
               "chamberLevel":param3,
               "cityMightAmount":param4
            },_loc6_);
            _loc6_++;
         }
         updateButtons();
         updateRecruitingJobExistance(param1,param2);
      }
      
      private function updateRecruitingJobExistance(param1:Dictionary, param2:Vector.<UnitTypeDIO>) : void
      {
         var _loc4_:UnitTypeInfo = null;
         _anyRecruitingJobExist = false;
         allRecruitsDone = true;
         possibleRecruitmentUnitId = -1;
         for each(var _loc3_ in param2)
         {
            _loc4_ = param1[_loc3_.id];
            if(allRecruitsDone)
            {
               allRecruitsDone = _loc4_.recruited;
            }
            if(_loc4_.currentlyRecruiting)
            {
               _anyRecruitingJobExist = true;
               _currentlyRecruitingUnitTypeId = _loc3_.id;
            }
            else if(!_loc4_.recruited && possibleRecruitmentUnitId == -1)
            {
               possibleRecruitmentUnitId = _loc3_.id;
            }
         }
      }
      
      public function updateButtons(param1:Boolean = false) : void
      {
         var _loc3_:UnitTypeInfo = selectedUnitTypeInfo;
         var _loc2_:UnitTypeDIO = selectedUnitTypeDIO;
         if(param1)
         {
            unlockedButton.visible = _startButton.visible = _recruitButton.visible = _stopButton.visible = _finishNowButton.visible = _speedUpButton.visible = false;
         }
         else
         {
            unlockedButton.visible = _loc3_.recruited;
            _startButton.visible = _recruitButton.visible = !_loc3_.recruited && !_loc3_.currentlyRecruiting;
            _stopButton.visible = _finishNowButton.visible = _speedUpButton.visible = _loc3_.currentlyRecruiting;
         }
         var _loc6_:Number = _loc2_.unlockCost.resourceAmount;
         var _loc5_:Number = _loc2_.unlockDurationInSecs / _serverSpeed;
         var _loc4_:Number = _loc3_.jobCreationTime + _loc3_.durationRemaining - new Date().getTime();
         _recruitButton.rightLabel = StoreUtil.mercenaryTrainAndRecruitPrice(_loc6_,_loc5_) + "";
         var _loc8_:String;
         _finishNowButton.rightLabel = _loc3_.durationRemaining < 300000 ? (_loc8_ = "ui.windows.constructionsite.free",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : StoreUtil.mercenaryTrainAndRecruitPrice(0,_loc4_ / 1000) + "";
      }
      
      public function get startButton() : MPButton
      {
         return _startButton;
      }
      
      public function get recruitButton() : MobileWomButton
      {
         return _recruitButton;
      }
      
      public function get stopButton() : MPButton
      {
         return _stopButton;
      }
      
      public function get finishNowButton() : MobileWomButton
      {
         return _finishNowButton;
      }
      
      public function get speedUpButton() : MobileWomButton
      {
         return _speedUpButton;
      }
      
      public function get selectedUnitTypeInfo() : UnitTypeInfo
      {
         return _mercenaryList.dataProvider.getItemAt(_mercenaryList.selectedPageIndex).unitTypeInfo;
      }
      
      public function get selectedUnitTypeDIO() : UnitTypeDIO
      {
         return _mercenaryList.dataProvider.getItemAt(_mercenaryList.selectedPageIndex).unitTypeDIO;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get anyRecruitingJobExist() : Boolean
      {
         return _anyRecruitingJobExist;
      }
      
      public function scrollToRequiredPage() : void
      {
         if(_initialUnitTypeId > -1 && _initialUnitTypeId in _unitIDtoIndexMap)
         {
            _mercenaryList.scrollToPageIndex(_unitIDtoIndexMap[_initialUnitTypeId],0,0);
         }
         else if(_anyRecruitingJobExist)
         {
            _mercenaryList.scrollToPageIndex(_unitIDtoIndexMap[_currentlyRecruitingUnitTypeId],0,0);
         }
         else if(!allRecruitsDone)
         {
            _mercenaryList.scrollToPageIndex(_unitIDtoIndexMap[possibleRecruitmentUnitId],0,0);
         }
         updateButtons();
      }
   }
}

